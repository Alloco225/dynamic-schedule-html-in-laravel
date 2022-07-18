// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ici/app/modules/onboarding/controllers/onboarding_controller.dart';
// import 'package:ici/app/modules/splash/views/splash_view.dart';

// import 'app/modules/onboarding/views/onboarding_view.dart';
// import 'app/modules/splash/controllers/splash_service.dart';
// import 'app/modules/splash/splash_view.dart';
// import 'app/routes/app_pages.dart';
// import 'services/auth_service.dart';

// void main() {
//   runApp(
//     GetMaterialApp.router(
//       title: "Application",
//       initialBinding: BindingsBuilder(
//         () {
//           Get.put(SplashService());
//           Get.put(OnboardingController());
//           Get.put(AuthService());
//         },
//       ),
//       getPages: AppPages.routes,
//       builder: (context, child) {
//         return FutureBuilder<bool>(
//           key: const ValueKey('initFuture'),
//           future: Get.find<SplashService>().init(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               if (!snapshot.data!) {
//                 return OnboardingView();
//               }
//               return child ?? const SizedBox.shrink();
//             }
//             return  SplashView();
//           },
//         );
//       },
//       // routeInformationParser: GetInformationParser(
//       //     // initialRoute: Routes.HOME,
//       //     ),
//       // routerDelegate: GetDelegate(
//       //   backButtonPopMode: PopMode.History,
//       //   preventDuplicateHandlingMode:
//       //       PreventDuplicateHandlingMode.ReorderRoutes,
//       // ),
//     ),
//   );
// }
