import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
//
import '/app/modules/404/views/404_view.dart';
import '/app/modules/auth/views/auth_view.dart';
import '/app/modules/map/map_view.dart';
import '/app/modules/splash/views/splash_view.dart';

class Routes {
  static String root = '/';
  static String home = '/home';
  static String auth = '/auth';
  static String login = '/login';
  static String notFound = '/404';
  static String register = '/register';
  static String onboarding = '/onboarding';
  static String resetPassword = '/reset_password';
  static String forgotPassword = '/forgot_password';

  static Map<String, WidgetBuilder> routes = {
    root: (ctx) => const SplashView(),
    notFound: (ctx) => const NotFoundView(),
    home: (ctx) => MapView(),
    auth: (ctx) => AuthView(),
    // register: (ctx) => RegisterView(),
    // login: (ctx) => LoginView(),
  };

  static Route<dynamic> routeNotFound(RouteSettings settings) =>
      MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => const NotFoundView());
  static Route<dynamic>? router(RouteSettings settings) {
    const duration = Duration(
      milliseconds: 700,
    );
    switch (settings.name) {
      case '/auth':
        return PageTransition(
            child: AuthView(),
            duration: duration,
            type: PageTransitionType.rightToLeft);
      default:
        return null;
    }

    // return MaterialPageRoute<void>(
    //     settings: settings,
    //     builder: (BuildContext context) => const NotFoundView(),
    //     );
  }
}
