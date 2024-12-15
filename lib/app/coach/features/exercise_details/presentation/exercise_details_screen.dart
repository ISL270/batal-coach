// ignore_for_file: camel_case_types
import 'dart:async';
import 'package:btl/app/core/extension_methods/english_x.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

part 'widgets/first_page_view.dart';
part 'widgets/second_page_view.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  const ExerciseDetailsScreen({super.key});

  static const String name = 'exercisedetails';

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  int activePage = 0;

  late List<Widget> pages;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted || !pageController.hasClients) return; // Safety check
      if (pageController.page == images.length - 1) {
        pageController.animateToPage(0,
            duration: const Duration(seconds: 1), curve: Curves.decelerate);
      } else {
        pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.decelerate);
      }
    });
  }

  final PageController pageController = PageController();
  final PageController pageViewController = PageController();

  Timer? timer;

  @override
  void initState() {
    super.initState();
    pages = List.generate(
      images.length,
      (index) => _ImageWithPlaceHolder(
        image: images[index],
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startTimer();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    timer?.cancel(); // Cancel the timer on dispose
    super.dispose();
  }

  final List<String> images = [
    'https://firebasestorage.googleapis.com/v0/b/btl-dev-69d91.appspot.com/o/default_exercises%2FDead-Bug.gif?alt=media&token=fd845f6f-9f96-4f8d-a904-b3ee8519d56c',
    'https://firebasestorage.googleapis.com/v0/b/btl-dev-69d91.appspot.com/o/default_exercises%2FOblique-Floor-Crunches.gif?alt=media&token=e137c34c-6aa4-4f72-a17f-eba678134b0b',
    'https://firebasestorage.googleapis.com/v0/b/btl-dev-69d91.appspot.com/o/default_exercises%2Fweighted_crunches.gif?alt=media&token=b17224d9-6542-4292-b600-fd9949a7f913',
  ];

  final List<String> setupLines = [
    '1. Lie down on your back.',
    '2. Bend your legs and stabilize your lower body.',
    '3. Cross your hands to opposite shoulders, or place them behind your ears without pulling on your neck.',
    '4. Lift your head and shoulder blades from the ground. Exhale as you rise.',
    '5. Lower, returning to your starting point. Inhale as you lower.',
  ];

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: 410,
                width: double.infinity,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (value) {
                    activePage = value;
                    setState(() {});
                  },
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: ColoredBox(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: InkWell(
                          onTap: () {
                            pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 900),
                              curve: Curves.decelerate,
                            );
                          },
                          child: Container(
                            width: activePage == index ? 20.0 : 10.0,
                            height: 10,
                            decoration: BoxDecoration(
                              color: activePage == index
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
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 380),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              child: Stack(
                children: [
                  const _ContainerShapeWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PageView(controller: pageViewController, children: [
                      FirstPageView(pageViewController: pageViewController),
                      SecondPageView(setupLines: setupLines)
                    ]),
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

class _titleWithASubTitleBehind extends StatelessWidget {
  const _titleWithASubTitleBehind({required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          title,
          style: context.textThemeX.large.bold.copyWith(fontSize: 24),
        ),
        const Gap(10),
        Text(
          subTitle,
          style: context.textThemeX.medium.bold
              .copyWith(color: Colors.grey, textBaseline: TextBaseline.ideographic),
        ),
      ],
    );
  }
}

class _exerciseDtailsBodySubTitle extends StatelessWidget {
  const _exerciseDtailsBodySubTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.textThemeX.medium.bold.copyWith(color: context.colorsX.onBackground),
    );
  }
}

class _generatedCircularContainer extends StatelessWidget {
  const _generatedCircularContainer({
    required this.options,
    required this.activeOption,
  });

  final List<String> options;
  final int activeOption;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 12,
      spacing: 12,
      children: List.generate(
        options.length,
        (index) => _circularContainer(
          label: options[index].capitalized,
          isActive: index == activeOption,
        ),
      ),
    );
  }
}

class _circularContainer extends StatelessWidget {
  const _circularContainer({
    required this.label,
    this.isActive = false,
    // ignore: unused_element
    this.width = 110,
  });

  final String label;
  final bool isActive;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: label.length >= 10 ? width + 10 : width,
      decoration: BoxDecoration(
        color: isActive ? context.colorsX.primary : context.colorsX.onBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          bottom: BorderSide(color: context.colorsX.onBackground),
          top: BorderSide(color: context.colorsX.onBackground),
          left: BorderSide(color: context.colorsX.onBackground),
          right: BorderSide(color: context.colorsX.onBackground),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            blurStyle: BlurStyle.outer,
            color: context.colorsX.onBackgroundTint35,
          ),
        ],
      ),
      child: SizedBox(
        height: 50,
        // width: isActive ? width + 10 : width,
        child: Center(
          child: Text(
            label,
            style: context.textThemeX.medium.bold
                .copyWith(color: context.colorsX.background, fontSize: isActive ? 17 : 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class _exerciseDetailsBodyTitle extends StatelessWidget {
  const _exerciseDetailsBodyTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: context.textThemeX.large.bold,
    );
  }
}

class _ImageWithPlaceHolder extends StatelessWidget {
  const _ImageWithPlaceHolder({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.infinity,
      fit: BoxFit.fill,
      imageUrl: image,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
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
        // boxShadow: const [
        //   BoxShadow(
        //     blurRadius: 5,
        //     blurStyle: BlurStyle.outer,
        //   ),
        //   BoxShadow(
        //     blurRadius: 2,
        //     blurStyle: BlurStyle.outer,
        //     color: Colors.grey,
        //   ),
        // ],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
    );
  }
}
