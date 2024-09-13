import 'package:flutter/material.dart';

import '../main.dart';

import 'dart:developer' as debug;

import 'remaining_time_widget.dart';

class CountDownAnimation extends StatefulWidget {
  DateTime specialDate;
  Duration since;
  late AnimationController animationController;
  late String time;

  CountDownAnimation({
    Key? key,
    required this.specialDate,
    required this.since,
  }) : super(key: key);

  @override
  State createState() => CountDownAnimationState();
}

class CountDownAnimationState extends State<CountDownAnimation>
    with TickerProviderStateMixin {
  late Animation<Duration> timeRemaining;
  late DateTime justNow;

  @override
  void initState() {
    super.initState();
    justNow = DateTime.now();
    int periodInSeconds = widget.specialDate.difference(justNow).inSeconds;
    debug.log('Init Duration Is $periodInSeconds Seconds');
    widget.animationController = AnimationController(
      duration: Duration(seconds: periodInSeconds),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    debug.log(
        'Build Duration Is ${widget.specialDate.difference(justNow).inSeconds} Seconds');
    timeRemaining = Tween<Duration>(
      begin: widget.specialDate.difference(justNow),
      end: Duration.zero,
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );
    _playAnimation();

    return AnimatedBuilder(
      builder: remainingTime,
      animation: widget.animationController,
    );
  }

  void update() {
    debug.log('Time Collapsed From Count Down Animation.');
  }

  Widget remainingTime(BuildContext context, Widget? child) {
    widget.time = timeRemaining.value.toString().substring(0, 8);
    /*if(timeRemaining.isCompleted){
      update();
      
    }*/
    return RemainingTimeWidget(
      time: widget.time[1] == ':' ? widget.time.substring(0, 7) : widget.time,
      onAnimationCompleted: update,
    );
  }

  Future<void> _playAnimation() async {
    try {
      await widget.animationController.forward().orCancel;
    } on TickerCanceled {
      // The animation got canceled, probably because it was disposed of.
    }
  }
}
