/// * Amane Hosanna
/// for JooL International
/// Sun 1rst May 2022

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ici/app/const/styles.dart';
import 'package:ici/app/modules/auth/controller/timer_controller.dart';

//
import '/app/modules/splash/controllers/splash_service.dart';
import '/app/routes.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/storage_service.dart';

void main() async {
  await bindDependencies();
  //
  runApp(const MyApp());
}

/// ?
/// Binds dependencies (duh)
bindDependencies() async {
  await GetStorage.init();
  await initServices();
}

/// ?
/// Initialises services (duh)
initServices() async {
  // Services
  // ! Get.put(() => ApiService());
  // ! Get.put(() => StorageService());
  // services binding in splash
  Get.lazyPut(() => SplashService());
  Get.lazyPut(() => AuthService());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ici",
      theme: Styles.theme,
      // home: const SplashView(),
      initialRoute: Routes.root,
      onUnknownRoute: Routes.routeNotFound,
      // onGenerateRoute: Routes.router,
      routes: Routes.routes,
    );
  }
}
