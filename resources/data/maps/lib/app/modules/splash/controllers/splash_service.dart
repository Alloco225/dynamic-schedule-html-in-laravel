import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ici/services/api_service.dart';
import 'package:ici/services/storage_service.dart';

class SplashService extends GetxService {
  // final welcomeStr = ['GetX', 'Rules!'];
  // final activeStr = 0.obs;

  final storage = GetStorage();

  final isOnboarded = false.obs;
  final auth = false.obs;
  get isOnboardedValue => isOnboarded.value;
  get authValue => auth.value;

  final memo = AsyncMemoizer<Map>();

  Future<Map> init() async {
    debugPrint("\n\n**>> SplashService <<**\n");

    await initServices();
    return memo.runOnce(_initFunction);
  }

  initServices() async {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => StorageService());
    // ApiService.to.onInit();
    // StorageService.to.onInit();
  }

  // void _changeActiveString() {
  //   activeStr.value = (activeStr.value + 1) % welcomeStr.length;
  // }

  Future<Map> _initFunction() async {
    // final t = Timer.periodic(
    //   Duration(milliseconds: 500),
    //   (t) => _changeActiveString(),
    // );

    var isOnboarded = storage.read('ICI_ONBOARDED');
    var auth = storage.read('ICI_AUTH');
    Map result = {
      'is_onboarded': false,
      'auth': false,
    };

    if (isOnboarded != null) {
      isOnboarded.value = isOnboarded;
      result['is_onboarded'] = isOnboarded;
    }
    if (auth != null) {
      auth.value = auth;
      result['auth'] = auth;
    }
    debugPrint("<< SplashService $result");

    // await Future.delayed(Duration.zero);
    //simulate some long running operation
    // await Future.delayed(Duration(seconds: 5));
    //cancel the timer once we are done
    // t.cancel();
    // Check if onboarded or not
    return result;
  }

  /// ? Save user onboarded status
  markUserOnboarded() async {
    debugPrint(">>markUserOnboarded");
    try {
      var isOnboarded = await storage.write('ICI_ONBOARDED', true);
      return isOnboarded;
    } catch (e) {
      debugPrint("<<xx");
      debugPrint("$e");
    }
  }
}
