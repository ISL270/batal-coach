import 'package:btl/app/coach/features/exercise_details/presentation/cubit/exercise_details_cubit.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

part 'widgets/exercise_details_body.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  const ExerciseDetailsScreen({super.key});

  static const String name = 'exercise-details';

  @override
  Widget build(BuildContext context) {
    //used in many parts in Exercise Details Screen
    final cubit = context.read<ExerciseDetailsCubit>();
    return Screen(
      padding: EdgeInsets.zero,
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Weighted crunches',
          style: context.textThemeX.large.bold.copyWith(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.pencil, color: Colors.black),
            onPressed: () {},
          ),
          const Gap(5),
        ],
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              BlocBuilder<ExerciseDetailsCubit, ExerciseDetailsState>(
                builder: (context, state) {
                  return Container(
                    height: 360,
                    width: double.infinity,
                    color: Colors.white,
                    child: PageView.builder(
                      controller: cubit.pageController,
                      onPageChanged: cubit.changeActivePage,
                      itemCount: state.images.length,
                      itemBuilder: (context, index) {
                        final pages = List.generate(
                          state.images.length,
                          (index) => _ImageWithPlaceHolder(
                            image: state.images[index],
                          ),
                        );
                        return pages[index];
                      },
                    ),
                  );
                },
              ),
              BlocBuilder<ExerciseDetailsCubit, ExerciseDetailsState>(
                builder: (context, state) {
                  return Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: ColoredBox(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          state.images.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: InkWell(
                              onTap: () {
                                cubit.pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 900),
                                  curve: Curves.decelerate,
                                );
                              },
                              child: Container(
                                width: state.activePage == index ? 20.0 : 10.0,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: state.activePage == index
                                      ? context.colorsX.primary
                                      : context.colorsX.secondary,
                                  borderRadius: BorderRadius.circular(64),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 330),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Stack(
                children: [
                  _ContainerShapeWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: _ExerciseDetailsBody(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ImageWithPlaceHolder extends StatelessWidget {
  const _ImageWithPlaceHolder({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.contain,
      imageUrl: image,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Center(child: Icon(FontAwesomeIcons.image)),
    );
  }
}

class _ContainerShapeWidget extends StatelessWidget {
  const _ContainerShapeWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorsX.background,
        border: const Border(),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
    );
  }
}
