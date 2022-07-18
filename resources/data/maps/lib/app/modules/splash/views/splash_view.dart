import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '/app/modules/map/map_view.dart';
import '/app/modules/onboarding/views/onboarding_view.dart';
import '../controllers/splash_service.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);


  /// Check api and storage n stuff
  /// 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Map>(
      key: const ValueKey('initFuture'),
      future: Get.find<SplashService>().init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            Map data = snapshot.data!;

            // if(data['auth']){

            // }
            if (data['is_onboarded'] == false) {
              return const OnboardingView();
            }

              return MapView();
          }
          // return child ?? const SizedBox.shrink();
        }

        return const LoadingView();
      },
    ));
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
