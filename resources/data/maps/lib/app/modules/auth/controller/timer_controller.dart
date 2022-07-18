import 'dart:async';

import 'package:get/get.dart';
import 'package:ici/app/const/env.dart';

class TimerService extends GetxService {

  late final Timer timer;

  final _waitTime = 30.obs;
  final _tries = 1.obs;

  final _duration = PROCESS.resendPasswordDuration.obs;
  final _isTimeReached = false.obs;
  get isTimeReached => _isTimeReached.value;
  get duration => _duration.value;
  get tries => _tries.value;
  get waitTime => _waitTime.value;

  set duration(v) => _duration.value = v;

  // get timer => _timer.value;

  get timerText {
    if (duration == 0) return '';
    var min = (duration / 60).floor();
    var sec = duration % 60;

    return "${min >= 10 ? min : '$min'}:${sec >= 10 ? sec : '0$sec'}";
  }

  void startTimer() {
    _isTimeReached.value = false;

    _duration.value = waitTime * tries;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_duration.value == 0) {
          _tries.value++;
          _isTimeReached.value = true;
          timer.cancel();
        } else {
          _duration.value--;
        }
      },
    );
  }
}
