// ignore_for_file: camel_case_types
import 'dart:async';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

part 'widgets/exercise_details_body.dart';

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

  final DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

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
              Container(
                height: 360,
                width: double.infinity,
                color: Colors.white,
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
      // width: double.infinity,
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
