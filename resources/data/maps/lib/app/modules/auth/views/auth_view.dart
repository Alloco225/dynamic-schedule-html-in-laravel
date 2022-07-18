import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/instance_manager.dart';
import 'package:ici/app/modules/auth/controller/auth_form_controller.dart';
import 'package:ici/app/modules/auth/controller/register_view_controller.dart';
import 'package:ici/services/api_service.dart';
//
import '/app/modules/auth/controller/auth_controller.dart';
import 'register/register_view.dart';
import '/app/modules/login/views/login_view.dart';
import '/app/modules/map/map_view.dart';
import '/app/utils/utils.dart';
import '/app/widgets/buttons.dart';
import 'package:page_transition/page_transition.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  void initState() {
    super.initState();
    bindDependencies();
  }

  /// ?
  /// Binds controllers and stuff
  bindDependencies() async {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => AuthFormController());
    Get.lazyPut(() => RegisterViewController());
    // Services again ?
    // Get.lazyPut(() => ApiService());
    ///
  }

  /// ? Set user permissions to guest
  _skipAuth() {
    // TODO set user to guest
    Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: MapView(),
        ));
  }

  _openSignupView() {
    UIUtils.openModalBottomSheet(context, view: const RegisterView());
  }

  _loadFacebookSignup() {
    //
  }

  _openLoginView() {
    UIUtils.openModalBottomSheet(context, view: LoginView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        // color: Colors.grey[50],
        color: Colors.yellow,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                // opacity: _nextAvailable() ? 1 : 0,
                opacity: 1,
                child: RawMaterialButton(
                  onPressed: _skipAuth,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "Plus tard",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          // fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            // const Spacer(),
            Hero(
              tag: "imageHero",
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: 200,
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100)),
                child: const Icon(
                  FeatherIcons.image,
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Con",
            //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //     ),
            //   ],
            // ),
            const Spacer(),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Some inspiring text",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "pages[activePageIndex].description",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.blueGrey
                    // fontSize: 30,
                    ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                ActionButton(
                  flex: 1,
                  action: _openSignupView,
                  heroTag: "mainActionButtonHeroin",
                  child: Text(
                    "S'inscrire avec Téléphone".toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  fillColor: Colors.orange,
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ActionButton(
                  flex: 1,
                  action: _loadFacebookSignup,
                  heroTag: "facebookActionButtonHeroin",
                  children: [
                    const Icon(FeatherIcons.facebook, color: Colors.white),
                    const SizedBox(width: 5),
                    Text(
                      "S'inscrire avec Facebook".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                  fillColor: Colors.blue,
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    "Vous avez déjà un compte ?",
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                // const SizedBox(width: 5),
                RawMaterialButton(
                  onPressed: _openLoginView,
                  padding: const EdgeInsets.all(5),
                  child: const Text(
                    "Connectez-vous",
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      // decoration: TextDecoration.underline,
                      // decorationThickness: 1.5,
                      //   textBaseline: TextBaseline.alphabetic
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
