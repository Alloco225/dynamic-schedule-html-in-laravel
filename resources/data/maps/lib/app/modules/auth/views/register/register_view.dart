// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:ici/app/modules/auth/controller/timer_controller.dart';
//
import '/app/const/styles.dart';
import '/app/modules/auth/controller/auth_controller.dart';
import '/app/modules/auth/controller/auth_form_controller.dart';
import '/app/modules/auth/controller/register_view_controller.dart';
import '/app/widgets/buttons.dart';

import 'register_form_view.dart';
import 'verify_phone_form_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

// enum PageState { Register, Loading, VerifyPhone }
// enum OverlayModalState { None, Loading, Error, Success }

class _RegisterViewState extends State<RegisterView>
    with TickerProviderStateMixin {
  final AuthController _authController = Get.find();
  final AuthFormController _authFormController = Get.find();
  final RegisterViewController _registerViewController = Get.find();

  /// ? Animation
  late AnimationController _bodySwitcherAnimation;
  // late Animation _bodySwitcherAnimation;

  /// ? Animation Tweens
  late Tween<Offset> _slideTween;
  //

  /// ? UI
  ///
  // double heightFactor = .6;

  // PageState _registerViewController.pageState = PageState.Register;
  // OverlayModalState _modalState = OverlayModalState.None;

  /// ? Inits
  ///
  @override
  void initState() {
    super.initState();
    // _authController.onReady((){
    // _authController.onReady((){
    // _registerViewController.pageState = PageState.Register;
    _initPage();
    setState(() {});
    // })
  }

  @override
  void dispose() {
    _bodySwitcherAnimation.dispose();
    super.dispose();
  }

  _initPage() {
    _bodySwitcherAnimation = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    _slideTween = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: const Offset(0, 0),
    );

    _bodySwitcherAnimation.forward();
  }

  /// ? Leave the page
  _exitPage() {
    if (_registerViewController.modalState == OverlayModalState.Loading) {
      return;
    }
    // Clear modal

    _registerViewController.clearModal();

    if (_registerViewController.pageState == PageState.Register) {
      Navigator.of(context).pop();
      return;
    }
    if (_registerViewController.pageState == PageState.VerifyPhone) {
      // TODO condition leaving
      _registerViewController.setPage(PageState.Register);
      return;
    }
    return;
  }

  // Main action
  _mainButtonAction() async {
    debugPrint(">> _mainButtonAction");
    if (!_registerViewController.isMainButtonActive) {
      await _authFormController.validateForm();
      _authFormController.validateTerms();
      debugPrint("!! Inactive");
      return;
    }

    debugPrint("\n\n>> action");
    switch (_registerViewController.pageState) {
      case PageState.VerifyPhone:
        return _verifyPhone();
      case PageState.Register:
        return _register();
      default:
    }
  }

  _register() async {
    //
    // _registerViewController.pageState = PageState.Loading;

    _registerViewController.setModal(OverlayModalState.Loading);
    // Try Login
    // await Future.delayed(const Duration(seconds: 3));
    try {
      await _authController.login();
      await _registerViewController.setModal(OverlayModalState.Success,
          duration: 800);
      _registerViewController.setPage(PageState.VerifyPhone);
      // Wait 3 seconds to auto check otp
      await Future.delayed(const Duration(seconds: 3));
      _verifyPhone();
    } catch (e) {
      debugPrint("xx $e");
      _registerViewController.setModal(OverlayModalState.Error);
    }
  }

  _verifyPhone() async {
    if (!_authFormController.isOtpValid) return;

    _registerViewController.setModal(OverlayModalState.Loading);
    // Try Verifying Phone number
    await Future.delayed(const Duration(seconds: 3));
    try {
      // await _authController.verifyPhone();
      await _registerViewController.setModal(OverlayModalState.Success,
          duration: 5000);
      //
    } catch (e) {
      debugPrint("xx $e");
      _registerViewController.setModal(OverlayModalState.Error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // double keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      double heightFactor = .65;
      if (isKeyboardVisible) {
        heightFactor = .8;
      }

      return FractionallySizedBox(
        heightFactor: heightFactor,
        child: DraggableScrollableSheet(
          initialChildSize: 1,
          minChildSize: 1,
          maxChildSize: 1,
          expand: false,
          builder: (_, controller) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              // direction: Axis.vertical,
              children: [
                /// ? Page title (duh!)
                Obx(() => PageTitle(state: _registerViewController.pageState)),

                /// ? Page body
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: AnimatedSwitcher(
                          duration: Styles.animationDuration,
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return SlideTransition(
                                position: _slideTween.animate(
                                  CurvedAnimation(
                                    parent: _bodySwitcherAnimation,
                                    curve: Curves.fastOutSlowIn,
                                  ),
                                ),
                                child: child);
                          },
                          child: Obx(() => BodyView(
                              state: _registerViewController.pageState)),
                        ),
                      ),

                      /// ? Overlay Modal
                      Positioned.fill(
                        child: Obx(() => OverlayModalView(
                              state: _registerViewController.modalState,
                            )),
                      ),
                    ],
                  ),
                ),

                /// ? Main Actions
                ///
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackArrowButton(onPressed: _exitPage),
                      const SizedBox(
                        width: 15,
                      ),
                      Obx(
                        () => ActionButton(
                            flex: 2,
                            action: _mainButtonAction,
                            heroTag: "mainActionButtonHero",
                            fillColor:
                                _registerViewController.isMainButtonActive
                                    ? Colors.orange
                                    : Colors.blueGrey,
                            child: Text(
                              _registerViewController.mainButtonActionText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class PageTitle extends StatelessWidget {
  final PageState state;
  const PageTitle({
    Key? key,
    this.state = PageState.Register,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "Inscrivez-vous";
    String subtitle = "Profitez de ici";

    if (state == PageState.VerifyPhone) {
      title = "Une dernière étape";
      subtitle = "On va juste vérifier ton numéro";
    }

    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Styles.h3.copyWith(color: Colors.blueGrey.shade900),
      ),
      subtitle: Text(
        subtitle,
        textAlign: TextAlign.center,
        style: Styles.small,
      ),
    );
  }
}

class BodyView extends StatelessWidget {
  final PageState state;
  const BodyView({
    Key? key,
    this.state = PageState.Loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case PageState.Register:
        return const RegisterFormView();
      case PageState.VerifyPhone:
        return VerifyPhoneForm();
      default:
        return const LoadingView();
    }
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blueGrey, borderRadius: BorderRadius.circular(100)),
        child: const Icon(
          FeatherIcons.loader,
          size: 30,
        ),
      ),
    );
  }
}

class OverlayModalView extends StatelessWidget {
  final OverlayModalState state;
  const OverlayModalView({
    Key? key,
    this.state = OverlayModalState.None,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case OverlayModalState.Loading:
        return const ModalLoadingView();
      case OverlayModalState.Error:
        return const ModalErrorView();
      case OverlayModalState.Success:
        return const ModalSuccessView();
      default:
        return Container();
    }
  }
}

class ModalSuccessView extends StatelessWidget {
  const ModalSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModalContent(
      icon: const Icon(FeatherIcons.check, color: Colors.green),
      text: Text(
        "Validé",
        style: Styles.subtitle_success,
      ),
    );
  }
}

class ModalErrorView extends StatelessWidget {
  final String errorMessage;
  const ModalErrorView(
      {Key? key, this.errorMessage = "Une erreur s'est produite"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModalContent(
      icon: const Icon(FeatherIcons.alertTriangle, color: Colors.red),
      text: Text(
        errorMessage,
        style: Styles.subtitle_error,
      ),
    );
  }
}

class ModalLoadingView extends StatelessWidget {
  // final Widget text;
  // final Widget icon;
  const ModalLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ModalContent();
  }
}

class ModalContent extends StatelessWidget {
  final Widget? text;
  final Widget? icon;
  const ModalContent({Key? key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Styles.animationDuration,
      curve: Styles.animationCurve,
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? const Icon(FeatherIcons.loader),
          const SizedBox(height: 5),
          text ??
              const Text(
                "Loading",
                style: Styles.subtitle,
              ),
        ],
      ),
    );
  }
}
