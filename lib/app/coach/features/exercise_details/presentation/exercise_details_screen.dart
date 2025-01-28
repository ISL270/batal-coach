import 'package:btl/app/coach/features/exercise_details/presentation/cubit/exercise_details_cubit.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

part 'widgets/exercise_details_body.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  const ExerciseDetailsScreen({required this.exercise, super.key});

  final Exercise exercise;
  static const String name = 'exercise-details';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExerciseDetailsCubit>();
    return Screen(
      padding: EdgeInsets.zero,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.colorsX.background,
        title: Text(
          exercise.name,
          style: context.textThemeX.large.bold,
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.penToSquare, size: 23.sp),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              BlocBuilder<ExerciseDetailsCubit, ExerciseDetailsState>(
                builder: (context, state) {
                  return Container(
                    height: 360.h,
                    width: double.infinity,
                    color: context.colorsX.background,
                    child: PageView.builder(
                      controller: cubit.pageController,
                      onPageChanged: cubit.changeActivePage,
                      itemCount: exercise.images.length,
                      itemBuilder: (context, index) {
                        final pages = List.generate(
                          exercise.images.length,
                          (index) => _ImageWithPlaceHolder(
                            image: exercise.mockImage,
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
                    bottom: 50.h,
                    left: 0,
                    right: 0,
                    child: ColoredBox(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          exercise.images.length,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: InkWell(
                              onTap: () {
                                cubit.pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 900),
                                  curve: Curves.decelerate,
                                );
                              },
                              child: Container(
                                width: state.activePage == index ? 20.0.w : 10.0.w,
                                height: 5.h,
                                decoration: BoxDecoration(
                                  color: state.activePage == index
                                      ? context.colorsX.primary
                                      : context.colorsX.secondary,
                                  borderRadius: BorderRadius.circular(64.r),
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
          Padding(
            padding: EdgeInsets.only(top: 330.h),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
              child: Stack(
                children: [
                  const _ContainerShapeWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: _ExerciseDetailsBody(exercise),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8), // Adjust the value for desired curvature
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: image,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Center(child: Icon(FontAwesomeIcons.image)),
        ),
      ),
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
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32.r),
        ),
      ),
    );
  }
}
