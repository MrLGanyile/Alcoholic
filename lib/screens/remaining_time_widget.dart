import 'package:flutter/cupertino.dart';

import '../main.dart';
import 'dart:developer' as debug;

typedef OnAnimationCompleted = Function();

class RemainingTimeWidget extends StatelessWidget {
  String time;
  OnAnimationCompleted onAnimationCompleted;

  RemainingTimeWidget({required this.time, required this.onAnimationCompleted});

  void checkIfAnimationIsDone() {
    if (time == '0:00:00' || time == '0:00:00') {
      onAnimationCompleted;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkIfAnimationIsDone();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Remaining Time',
          style: TextStyle(
              fontSize: MyApplication.infoTextFontSize,
              color: MyApplication.storesSpecialTextColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none),
        ),
        Text(
          time[1] == ':' ? time.substring(0, 7) : time,
          style: TextStyle(
              fontSize: MyApplication.infoTextFontSize,
              color: MyApplication.storesSpecialTextColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none),
        ),
      ],
    );
  }
}
