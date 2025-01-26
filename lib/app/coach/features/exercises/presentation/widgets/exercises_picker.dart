import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercises/domain/repositories/exercises_repository.dart';
import 'package:btl/app/coach/features/exercises/presentation/bloc/exercises_bloc.dart';
import 'package:btl/app/coach/features/exercises/presentation/exercises_screen.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/models/status.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ExercisePicker extends StatefulWidget {
  const ExercisePicker({super.key});

  static Future<List<Exercise>?> show(BuildContext context) async {
    final exercises = await Navigator.of(context).push<List<Exercise>>(
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_) => BlocProvider(
          create: (context) => ExercisesBloc(getIt.get<ExercisesRepository>()),
          child: const ExercisePicker(),
        ),
      ),
    );
    return exercises;
  }

  @override
  State<ExercisePicker> createState() => _ExercisePickerState();
}

class _ExercisePickerState extends State<ExercisePicker> {
  late final ExercisesBloc _bloc;
  late final ScrollController _scrollCntrlr;
  late final TextEditingController _searchCntrlr;
  final isCollapsed = ValueNotifier<bool>(false);
  final _slctdExercises = <Exercise>[];

  @override
  void initState() {
    super.initState();
    _scrollCntrlr = ScrollController();
    _bloc = context.read<ExercisesBloc>();
    _searchCntrlr = TextEditingController();
    _searchCntrlr.addListener(
      () {
        if (_searchCntrlr.text.isEmpty) {
          _bloc.add(const ExcsSearched(''));
        }
      },
    );
    _scrollCntrlr.addListener(
      () {
        if (_bloc.state.status.isSuccess && _bloc.state.exercises.result.length > 5) {
          return;
        }
        _scrollCntrlr.jumpTo(0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      safeAreaValues: SafeAreaValues.none(),
      padding: EdgeInsets.zero,
      appBar: AppBar(
        title: const Text('Select exercise'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Flexible(
                  child: SizedBox(
                    height: 40,
                    child: CupertinoSearchTextField(
                      controller: _searchCntrlr,
                      onChanged: (searchTerm) => _bloc.add(ExcsSearched(searchTerm)),
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: CupertinoColors.black.withOpacity(0.6),
                      ),
                      placeholder: 'Search',
                      placeholderStyle: const TextStyle(color: CupertinoColors.systemGrey),
                      backgroundColor: CupertinoColors.tertiarySystemFill,
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.tune),
                  color: context.colorsX.primary,
                  padding: const EdgeInsetsDirectional.only(start: 20, end: 5),
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    // This value must be true in order to show the BottomSheet above the BottomNavBar
                    useRootNavigator: true,
                    scrollControlDisabledMaxHeightRatio: 0.75,
                    builder: (context) => BlocProvider.value(
                      value: _bloc,
                      child: const ExcFilterBottomSheet(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<ExercisesBloc, ExercisesState>(
        builder: (context, state) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels >= (notification.metrics.maxScrollExtent * .7)) {
                _bloc.add(ExcsNextPageFetched());
              }
              return true;
            },
            child: switch (state.status) {
              Loading() => const Center(child: CircularProgressIndicator()),
              _ => state.exercises.result.isEmpty
                  ? const Center(child: Text('No exercises found'))
                  : ListView.separated(
                      controller: _scrollCntrlr,
                      itemCount: state.exercises.result.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 0,
                        indent: 20,
                        endIndent: 20,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      itemBuilder: (context, i) {
                        final exc = state.exercises.result[i];
                        return InkWell(
                          onTap: () {
                            if (_slctdExercises.contains(exc)) {
                              setState(() => _slctdExercises.remove(exc));
                            } else {
                              setState(() => _slctdExercises.add(exc));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            child: Row(
                              children: [
                                if (_slctdExercises.contains(exc))
                                  Icon(
                                    size: 23.r,
                                    Icons.check_circle,
                                    color: context.colorsX.primary,
                                  )
                                else
                                  Icon(
                                    size: 23.r,
                                    Icons.circle_outlined,
                                    color: context.colorsX.onBackgroundTint35,
                                  ),
                                const Gap(15),
                                Expanded(
                                  child: ListTile(
                                    horizontalTitleGap: 15,
                                    contentPadding: EdgeInsets.zero,
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        width: 57,
                                        imageUrl: exc.mockImage,
                                      ),
                                    ),
                                    title: Text(
                                      exc.name,
                                      style: context.textThemeX.medium.bold,
                                    ),
                                    subtitle: Text(
                                      '${context.tr(exc.mainMuscle.name)} - ${context.tr(exc.equipment?.name ?? '')} - ${context.tr(exc.type?.name ?? '')} - ${context.tr(exc.level?.name ?? '')}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.textThemeX.small,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            },
          );
        },
      ),
      floatingActionButton: _slctdExercises.isEmpty
          ? null
          : Button.filled(
              onPressed: () => Navigator.pop(context, _slctdExercises),
              label: 'Add',
              density: ButtonDensity.comfortable,
            ),
    );
  }

  @override
  void dispose() {
    _scrollCntrlr.dispose();
    _searchCntrlr.dispose();
    super.dispose();
  }
}
