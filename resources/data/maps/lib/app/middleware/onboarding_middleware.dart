import 'package:get/get.dart';
import 'package:ici/app/routes/app_pages.dart';

class EnsureOnboardedMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    // you can do whatever you want here
    // but it's preferable to make this method fast
    // await Future.delayed(Duration(milliseconds: 500));

    // if (!await OnboardingService.to.check()) {
    //   const newRoute = Routes.ONBOARDING;
    //   return GetNavConfig.fromRoute(newRoute);
    // }
    return await super.redirectDelegate(route);
  }
}
