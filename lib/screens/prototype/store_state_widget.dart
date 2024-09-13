import 'dart:developer' as debug;
import 'package:alcoholic/screens/prototype/wait_widget.dart';
import 'package:flutter/material.dart';

import '../../models/prototype/old_competition.dart';
import '../../models/prototype/old_store.dart';
import '../../models/prototype/samples_for_testing.dart';
import 'no_competition_widget.dart';
import 'on_play_widget.dart';
import 'on_wait_widget.dart';
import 'winner_widget.dart';

enum StoreState {
  hasNoCompetition,
  hasCurrentlyPlayingCompetition,
  hasWinner,
  hasCommingCompetition,
}

class StoreStateWidget extends StatefulWidget {
  Store store;
  SampleForTesting sampleForTesting;

  StoreStateWidget({
    super.key,
    required this.store,
    required this.sampleForTesting,
  });

  @override
  StoreStateWidgetState createState() => StoreStateWidgetState();
}

class StoreStateWidgetState extends State<StoreStateWidget>
    with TickerProviderStateMixin {
  late StoreState storeState;

  late AnimationController animationController;
  late Duration animationDuration;
  late DateTime justNow;

  late String time;
  Animation<Duration>? timeRemaining;
  bool hasTimeRemaining = true;

  late Duration changeFromWaitAfter;
  Duration changeFromWinnerAfter = const Duration(hours: 1);
  Duration changeFromPlayAfter = const Duration(minutes: 3);

  StoreStateWidgetState();

  @override
  void initState() {
    super.initState();
    justNow = DateTime.now();
    setStoreState();

    switch (storeState) {
      case StoreState.hasNoCompetition:
        animationController = AnimationController(
          duration: Duration.zero,
          vsync: this,
        );
        break;

      case StoreState.hasCommingCompetition:
        DateTime specialDate = findSpecialDate()!;
        animationDuration = specialDate.difference(justNow);

        animationController = AnimationController(
          duration: animationDuration,
          vsync: this,
        );

        timeRemaining = Tween<Duration>(
          begin: animationDuration,
          end: Duration.zero,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(
              0.0,
              1.0,
              curve: Curves.linear,
            ),
          ),
        );
        break;

      case StoreState.hasCurrentlyPlayingCompetition:
        animationDuration =
            widget.store.competitions[_findSpecialDateIndex()].duration!;
        animationController = AnimationController(
          duration: animationDuration,
          vsync: this,
        );
        break;

      default:
        animationDuration = const Duration(seconds: 5);
        animationController = AnimationController(
          duration: animationDuration,
          vsync: this,
        );
    }
  }

  void setStoreState() {
    int specialDateIndex = _findSpecialDateIndex();
    justNow = DateTime.now();

    debug.log('Special Date Index: $specialDateIndex\n');
    // There is no competition to be watched today.
    if (specialDateIndex < 0) {
      Competition? prevCompetition = widget.store.findPrevCompetition(justNow);
      Competition? nextCompetition = widget.store.findNextCompetition(justNow);

      // Either Show The Previous Or Comming Competition.
      if (prevCompetition != null && nextCompetition != null) {
        debug.log('Either Show The Previous Or Comming Competition\n');
        Duration halfOfDifferenceInSeconds = Duration(
                seconds: widget.store.findTimeDifferenceInSeconds(
                        prevCompetition, nextCompetition) ~/
                    2)
            .abs();

        DateTime middleDate =
            prevCompetition.dateTime.add(halfOfDifferenceInSeconds);
        Duration timePassedSincePrevCompetitionDate =
            prevCompetition.dateTime.difference(DateTime.now()).abs();

        if (prevCompetition.dateTime
            .add(timePassedSincePrevCompetitionDate)
            .isAfter(middleDate)) {
          storeState = StoreState.hasCommingCompetition;
        } else {
          storeState = StoreState.hasWinner;
        }
      }

      // There Was A Competition/Draw But It Time Has Passed.
      // Assuming There Is Only One Competition On A Given Day.
      else if (nextCompetition == null && prevCompetition != null) {
        debug.log('There Was A Competition/Draw But It Time Has Passed.\n');
        storeState = StoreState.hasWinner;
      }
      // The draw is comming soon.
      else if (nextCompetition != null && prevCompetition == null) {
        debug.log('The draw is comming soon.\n');
        storeState = StoreState.hasCommingCompetition;
      } else {
        // There is no draw created by a store owner.
        debug.log('There is no draw created by a store owner.\n');
        storeState = StoreState.hasNoCompetition;
      }
    } else {
      // There is a competition to be watched today.
      storeState = StoreState.hasCurrentlyPlayingCompetition;
    }
  }

  void updateHasTimeRemaining() {
    setState(() {
      hasTimeRemaining = false;
    });
  }

  int _findSpecialDateIndex() {
    for (int i = 0; i < widget.store.competitions.length; i++) {
      if (widget.store.competitions[i].dateTime.year == DateTime.now().year &&
          widget.store.competitions[i].dateTime.month == DateTime.now().month &&
          widget.store.competitions[i].dateTime.day == DateTime.now().day) {
        return i;
      }
    }
    return -1;
  }

  DateTime? findSpecialDate() {
    int specialDateIndex = _findSpecialDateIndex();
    justNow = DateTime.now();

    // There is no competition to be watched today.
    if (specialDateIndex < 0) {
      Competition? prevCompetition = widget.store.findPrevCompetition(justNow);
      Competition? nextCompetition = widget.store.findNextCompetition(justNow);

      // Either Show The Previous Or Comming Competition.
      if (prevCompetition != null && nextCompetition != null) {
        Duration halfOfDifferenceInSeconds = Duration(
                seconds: widget.store.findTimeDifferenceInSeconds(
                        prevCompetition, nextCompetition) ~/
                    2)
            .abs();

        DateTime middleDate =
            prevCompetition.dateTime.add(halfOfDifferenceInSeconds);
        Duration timePassedSincePrevCompetitionDate =
            prevCompetition.dateTime.difference(DateTime.now()).abs();

        if (prevCompetition.dateTime
            .add(timePassedSincePrevCompetitionDate)
            .isAfter(middleDate)) {
          return nextCompetition.dateTime;
        } else {
          return prevCompetition.dateTime;
        }
      }

      // There Was A Competition/Draw But It Time Has Passed.
      // Now Show The Last Won Price.
      // Assuming There Is Only One Competition On A Given Day.
      else if (nextCompetition == null && prevCompetition != null) {
        return prevCompetition.dateTime;
      }
      // The draw is comming soon.
      else if (nextCompetition != null && prevCompetition == null) {
        return nextCompetition.dateTime;
      } else {
        return null;
      }
    }

    // There is a competition to be watched today.
    return widget.store.competitions[specialDateIndex].dateTime;
  }

  void updateRemainingTimeTween() {
    DateTime specialDate = findSpecialDate()!;
    animationDuration = specialDate.difference(justNow);

    timeRemaining = Tween<Duration>(
      begin: animationDuration,
      end: Duration.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _playAnimation();

    return AnimatedBuilder(
      builder: displayApproriatePage,
      animation: animationController,
    );
  }

  Widget displayApproriatePage(BuildContext context, Widget? child) {
    int specialDateIndex = _findSpecialDateIndex();
    justNow = DateTime.now();

    // There is no competition to be watched today.
    if (specialDateIndex < 0) {
      Competition? prevCompetition = widget.store.findPrevCompetition(justNow);
      Competition? nextCompetition = widget.store.findNextCompetition(justNow);

      // Either Show The Previous Or Comming Competition.
      if (prevCompetition != null && nextCompetition != null) {
        Duration halfOfDifferenceInSeconds = Duration(
                seconds: widget.store.findTimeDifferenceInSeconds(
                        prevCompetition, nextCompetition) ~/
                    2)
            .abs();

        DateTime middleDate =
            prevCompetition.dateTime.add(halfOfDifferenceInSeconds);
        Duration timePassedSincePrevCompetitionDate =
            prevCompetition.dateTime.difference(DateTime.now()).abs();

        if (prevCompetition.dateTime
            .add(timePassedSincePrevCompetitionDate)
            .isAfter(middleDate)) {
          if (hasTimeRemaining) {
            /*
            changeFromWaitAfter = nextCompetition.dateTime.difference(now);
            return OnWaitWidget(
              store:widget.store, 
              sampleForTesting: widget.sampleForTesting, 
              competition:nextCompetition, 
              duration: changeFromWaitAfter,
              onAnimationCompleted: updateHasTimeRemaining,
            );*/

            if (timeRemaining == null) {
              updateRemainingTimeTween();
            }
            time = timeRemaining!.value.toString().substring(0, 8);
            if (time[1] == ':') {
              time = time.substring(0, 7);
            }
            debug.log('$time\n');
            return WaitWidget(
                time: time,
                storeName: widget.store.storeName,
                address: widget.store.address,
                sampleForTesting: widget.sampleForTesting,
                competition: nextCompetition,
                onRemainingTimeElapsed: updateHasTimeRemaining,
                imageURL: widget.store.picPath + widget.store.picName);
          } else {
            return OnPlayWidget(
              store: widget.store,
              duration: changeFromPlayAfter,
            );
          }
        } else {
          if (widget.store.lastWonPrice!.competition.dateTime
                  .difference(DateTime.now())
                  .inHours <
              24) {
            return WinnerWidget(
              wonPrice: widget.store.lastWonPrice!,
              duration: changeFromWinnerAfter,
            );
          } else {
            return NoCompetitionWidget(
              store: widget.store,
              sampleForTesting: widget.sampleForTesting,
              duration: const Duration(seconds: 30),
            );
          }
        }
      }

      // There Was A Competition/Draw But It Time Has Passed.
      // Now Show The Last Won Price.
      // Assuming There Is Only One Competition On A Given Day.
      else if (nextCompetition == null && prevCompetition != null) {
        if (widget.store.lastWonPrice!.competition.dateTime
                .difference(DateTime.now())
                .inHours <
            24) {
          return WinnerWidget(
            wonPrice: widget.store.lastWonPrice!,
            duration: changeFromWinnerAfter,
          );
        } else {
          return NoCompetitionWidget(
            store: widget.store,
            sampleForTesting: widget.sampleForTesting,
            duration: const Duration(seconds: 30),
          );
        }
      }
      // The draw is comming soon.
      else if (nextCompetition != null && prevCompetition == null) {
        if (hasTimeRemaining) {
          changeFromWaitAfter = nextCompetition.dateTime.difference(justNow);
          /*return OnWaitWidget(
              store:widget.store, 
              sampleForTesting: widget.sampleForTesting, 
              competition:nextCompetition, 
              duration: changeFromWaitAfter,
              onAnimationCompleted: updateHasTimeRemaining,
            );*/
          if (timeRemaining == null) {
            updateRemainingTimeTween();
          }

          time = timeRemaining!.value.toString().substring(0, 8);
          if (time[1] == ':') {
            time = time.substring(0, 7);
          }
          debug.log(time);
          return WaitWidget(
              time: time,
              storeName: widget.store.storeName,
              address: widget.store.address,
              sampleForTesting: widget.sampleForTesting,
              competition: nextCompetition,
              onRemainingTimeElapsed: updateHasTimeRemaining,
              imageURL: widget.store.picPath + widget.store.picName);
        } else {
          return OnPlayWidget(
            store: widget.store,
            duration: changeFromPlayAfter,
          );
        }
      } else {
        return NoCompetitionWidget(
          store: widget.store,
          sampleForTesting: widget.sampleForTesting,
          duration: const Duration(seconds: 30),
        );
      }
    }

    // There is a competition to be watched today.
    else {
      Competition competition = widget.store.competitions[specialDateIndex];

      // The Draw/Competition Is Currently Playing.
      if (justNow.isAfter(competition.dateTime) &&
          justNow.isBefore(competition.dateTime.add(competition.duration!))) {
        return OnPlayWidget(
          store: widget.store,
          duration: changeFromPlayAfter,
        );
      }
      // The Draw/Competition Is Over.
      else if (justNow
          .isAfter(competition.dateTime.add(competition.duration!))) {
        if (widget.store.lastWonPrice!.competition.dateTime
                .difference(DateTime.now())
                .inHours <
            24) {
          return WinnerWidget(
            wonPrice: widget.store.lastWonPrice!,
            duration: changeFromWinnerAfter,
          );
        } else {
          return NoCompetitionWidget(
            store: widget.store,
            sampleForTesting: widget.sampleForTesting,
            duration: const Duration(seconds: 30),
          );
        }
      }

      // The searched store name exist and the draw is about to begin.
      // A countdown clock needs to be display until the draw begins,
      // in which chase it will disappear.
      else {
        if (hasTimeRemaining) {
          changeFromWaitAfter = competition.dateTime.difference(justNow);
          /*return OnWaitWidget(
              store:widget.store, 
              sampleForTesting: widget.sampleForTesting, 
              competition:competition, 
              duration: changeFromWaitAfter,
              onAnimationCompleted: updateHasTimeRemaining,
            );*/
          if (timeRemaining == null) {
            updateRemainingTimeTween();
          }

          time = timeRemaining!.value.toString().substring(0, 8);
          if (time[1] == ':') {
            time = time.substring(0, 7);
          }
          debug.log(time);
          return WaitWidget(
              time: time,
              storeName: widget.store.storeName,
              address: widget.store.address,
              sampleForTesting: widget.sampleForTesting,
              competition: competition,
              onRemainingTimeElapsed: updateHasTimeRemaining,
              imageURL: widget.store.picPath + widget.store.picName);
        } else {
          return OnPlayWidget(
            store: widget.store,
            duration: changeFromPlayAfter,
          );
        }
      }
    }
  }

  Future<void> _playAnimation() async {
    try {
      await animationController.forward().orCancel;
    } on TickerCanceled {
      // The animation got canceled, probably because it was disposed of.
    }
  }
}
