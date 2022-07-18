import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/instance_manager.dart';
import 'package:ici/app/const/styles.dart';
import 'package:ici/app/modules/auth/views/auth_view.dart';
import 'package:page_transition/page_transition.dart';
import '/app/modules/splash/controllers/splash_service.dart';
import '/app/routes.dart';
import '/app/widgets/buttons.dart';
import '/models/onboarding_item.dart';
import 'index_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with TickerProviderStateMixin {
  SplashService _splashService = Get.find();

  List<OnboardingItem> pages = [
    OnboardingItem(
      title: "1 Onboarding long title long",
      description: "Description long, description",
      imageAsset: "",
    ),
    OnboardingItem(
      title: "2 Onboarding long",
      description: "Description long 2, description",
      imageAsset: "",
    ),
    OnboardingItem(
      title: "3 long title long",
      description: "Description long, description",
      imageAsset: "",
    ),
  ];

  int activePageIndex = 0;

  /// * Animations
  /// TODO add animations
  /// ? Animation Controllers
  late AnimationController _titleAnimationController;
  late AnimationController _descriptionAnimationController;
  late AnimationController _imageAnimationController;

  /// ? Animation Tweens
  late Tween<Offset> _slideTween;
  late Tween<Offset> _slideDownTween;
  late Tween<double> _opacityTween;

  /// ? Animation init
  ///
  initAnimations() {
    /// ? Animations
    _titleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );

    /// ? Tweens
    _slideTween = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: const Offset(0, 0),
    );
    _slideDownTween = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    );

    _opacityTween = Tween(begin: 0.0, end: 1.0);
  }

  /// ? Inistate
  ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAnimations();
  }

  /// ? Didchange deps
  ///
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    startMountedAnimations();
    super.didChangeDependencies();
  }

  /// ? Dispose
  ///
  @override
  void dispose() {
    super.dispose();
    _titleAnimationController.dispose();
    _descriptionAnimationController.dispose();
    _imageAnimationController.dispose();
  }

  /// App Mounted
  ///
  startMountedAnimations() async {
    //
    await _titleAnimationController.reverse();
    Future.delayed(const Duration(milliseconds: 700));
    await _titleAnimationController.forward();
  }

  ///
  ///

  _previousAvailable() => activePageIndex > 0;
  _nextAvailable() => activePageIndex < pages.length - 1;

  _previousPage() async {
    if (activePageIndex <= 0) return;
    await _titleAnimationController.reverse();

    activePageIndex--;
    setState(() {});
    await _titleAnimationController.forward();
  }

  /// Goes to next page index
  _nextPage() async {
    if (activePageIndex >= pages.length - 1) return;
    await _titleAnimationController.reverse();
    activePageIndex++;
    setState(() {});
    await _titleAnimationController.forward();
  }

  _skipPages() async {
    while (_nextAvailable()) {
      _nextPage();
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  _mainButtonAction() {
    if (_nextAvailable()) {
      return _nextPage();
    }
    return _goToAuth();
  }

  /// ? Save onboarded status and go to auth screen
  _goToAuth() async {
    //
    // await _splashService.markUserOnboarded();

    Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: const AuthView(),
        ));
    // Navigator.of(context).pushNamed(Routes.auth);
    // Navigator.of(context).pushReplacementNamed(Routes.auth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    opacity: _nextAvailable() ? 1 : 0,
                    child: RawMaterialButton(
                      onPressed: _skipPages,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "Passer",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Hero(
                    tag: "imageHero",
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100)),
                      padding: const EdgeInsets.all(50),
                      child: const Icon(
                        FeatherIcons.image,
                      ),
                    ),
                  ),
                  const Spacer(),
                  FadeTransition(
                    opacity: _opacityTween.animate(
                      CurvedAnimation(
                        parent: _titleAnimationController,
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                    child: SlideTransition(
                      position: _slideDownTween.animate(
                        CurvedAnimation(
                          parent: _titleAnimationController,
                          curve: Curves.fastOutSlowIn,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          pages[activePageIndex].title,
                          textAlign: TextAlign.center,
                          style: Styles.h1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      pages[activePageIndex].description,
                      textAlign: TextAlign.center,
                      style: Styles.small
                    ),
                  ),
                  const SizedBox(height: 10),
                  SlidingIndexIndicatorView(
                    count: pages.length,
                    activeIndex: activePageIndex,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_previousAvailable())
                    Expanded(
                      child: AnimatedContainer(
                        duration: Styles.animationDuration,
                        curve: Styles.animationCurve,
                        child: RawMaterialButton(
                          onPressed: _previousPage,
                          fillColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey.shade300)),
                          child: const Icon(FeatherIcons.arrowLeft),
                        ),
                      ),
                    ),
                  if (_previousAvailable())
                    const SizedBox(
                      width: 15,
                    ),
                  ActionButton(
                    flex: 2,
                    action: _mainButtonAction,
                    heroTag: "mainActionButtonHero",
                    fillColor: Colors.orange,
                    children: [
                      Text(
                        (_nextAvailable() ? 'Suivant' : 'Commencer')
                            .toUpperCase(),
                        style: Styles.button_white
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
