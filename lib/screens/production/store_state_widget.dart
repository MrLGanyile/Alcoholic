import 'dart:developer' as debug;

import 'package:flutter/material.dart';

import '../../controllers/production/store_controller.dart';

import '../../models/production/competitions/competition.dart';
import '../../models/production/stores/store_draw.dart';
import '../../models/production/stores/won_price_summary.dart';
import 'no_competition_widget.dart';
import 'on_play_widget.dart';
import 'wait_widget.dart';
import 'winner_widget.dart';

enum StoreState {
  hasNoCompetition,
  hasCurrentlyPlayingCompetition,
  hasWinner,
  hasCommingCompetition,
}

class StoreStateWidget extends StatefulWidget {
  // Step 1
  String storeId;

  /* The first element has a store draw whose date 
  is 1993-02-15 for the Sake Of A NoCompetition Screen's.
  The subsequent elements are in ascending order based on 
  their competition date.*/
  List<StoreDraw> commingStoreDraws;

  StoreStateWidget({
    super.key,
    required this.storeId,
    required this.commingStoreDraws,
  });

  @override
  StoreStateWidgetState createState() => StoreStateWidgetState();
}

class StoreStateWidgetState extends State<StoreStateWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Duration animationDuration;
  late DateTime justNow;

  StoreController storeController = StoreController.storeController;
  // Step 2
  late Stream<List<StoreDraw>> storeDrawsStream;
  late StoreState storeState;

  String?
      timeLeft; // Only Used If The Current State Is 'hasCommingCompetition'.
  Animation<Duration>?
      timeRemaining; // Only Used If The Current State Is 'hasCommingCompetition'.
  bool?
      hasTimeRemaining; // Only Used If The Current State Is 'hasCommingCompetition'.

  WonPriceSummary?
      lastWonPrice; // Only Used If The Current State Is 'hasWinner'.

  bool?
      isCompetitionOver; // Only Used If The Current State Is 'hasCurrentlyPlayingCompetition'.
  Future<Competition>?
      currentlyPlayingCompetition; // Only Used If The Current State Is 'hasCurrentlyPlayingCompetition'.

  @override
  void initState() {
    super.initState();

    justNow = DateTime.now();

    // Step 3
    storeDrawsStream = storeController.findStoreDraws(widget.storeId);
    setStoreState();

    switch (storeState) {
      case StoreState.hasNoCompetition:
        isCompetitionOver = null;

        animationController = AnimationController(
          duration: Duration.zero,
          vsync: this,
        );
        break;

      case StoreState.hasCommingCompetition:
        isCompetitionOver = null;
        hasTimeRemaining = true;

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
        isCompetitionOver = false;
        //currentlyPlayingCompetition = storeController.findCompetition()
        //GrandPricesGrid grandPricesGrid = storeController.findGrandPricesGrid(
        //currentlyPlayingCompetition.competitionId, grandPricesGridId);

        //animationDuration =  widget.commingStoreDraws[_findSpecialDateIndex()].duration!;
        animationController = AnimationController(
          duration: animationDuration,
          vsync: this,
        );
        break;

      default: // hasWinner

        isCompetitionOver = true;
        lastWonPrice = storeController.findWonPriceSummary(widget.storeId)
            as WonPriceSummary;

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

    // There is no competition to be watched today.
    if (specialDateIndex < 0) {
      StoreDraw? prevStoreDraw = findPrevStoreDraw(justNow);
      StoreDraw? nextStoreDraw = findNextStoreDraw(justNow);

      // Either Show The Previous Or Comming Competition.
      if (prevStoreDraw != null && nextStoreDraw != null) {
        Duration halfOfDifferenceInSeconds = Duration(
                seconds:
                    findTimeDifferenceInSeconds(prevStoreDraw, nextStoreDraw) ~/
                        2)
            .abs();

        DateTime middleDate =
            prevStoreDraw.drawDateAndTime.add(halfOfDifferenceInSeconds);
        Duration timePassedSincePrevCompetitionDate =
            prevStoreDraw.drawDateAndTime.difference(DateTime.now()).abs();

        if (prevStoreDraw.drawDateAndTime
            .add(timePassedSincePrevCompetitionDate)
            .isAfter(middleDate)) {
          storeState = StoreState.hasCommingCompetition;
        } else {
          storeState = StoreState.hasWinner;
        }
      }

      // There Was A Competition/Draw But It Time Has Passed.
      // Assuming There Is Only One Competition On A Given Day.
      else if (nextStoreDraw == null && prevStoreDraw != null) {
        storeState = StoreState.hasWinner;
      }
      // The draw is comming soon.
      else if (nextStoreDraw != null && prevStoreDraw == null) {
        storeState = StoreState.hasCommingCompetition;
      } else {
        // There is no draw created by a store owner.
        storeState = StoreState.hasNoCompetition;
      }
    }

    // There is a competition to be watched today.
    storeState = StoreState.hasCurrentlyPlayingCompetition;
  }

  StoreStateWidgetState();

  int _findSpecialDateIndex() {
    DateTime now = DateTime.now();

    for (int i = 0; i < widget.commingStoreDraws.length; i++) {
      if (widget.commingStoreDraws[i].drawDateAndTime.year == now.year &&
          widget.commingStoreDraws[i].drawDateAndTime.month == now.month &&
          widget.commingStoreDraws[i].drawDateAndTime.day == now.day) {
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
      StoreDraw? prevStoreDraw = findPrevStoreDraw(justNow);
      StoreDraw? nextStoreDraw = findNextStoreDraw(justNow);

      // Either Show The Previous Or Comming Competition.
      if (prevStoreDraw != null && nextStoreDraw != null) {
        Duration halfOfDifferenceInSeconds = Duration(
                seconds:
                    findTimeDifferenceInSeconds(prevStoreDraw, nextStoreDraw) ~/
                        2)
            .abs();

        DateTime middleDate =
            prevStoreDraw.drawDateAndTime.add(halfOfDifferenceInSeconds);
        Duration timePassedSincePrevCompetitionDate =
            prevStoreDraw.drawDateAndTime.difference(DateTime.now()).abs();

        if (prevStoreDraw.drawDateAndTime
            .add(timePassedSincePrevCompetitionDate)
            .isAfter(middleDate)) {
          return nextStoreDraw.drawDateAndTime;
        } else {
          return prevStoreDraw.drawDateAndTime;
        }
      }

      // There Was A Competition/Draw But It Time Has Passed.
      // Now Show The Last Won Price.
      // Assuming There Is Only One Competition On A Given Day.
      else if (nextStoreDraw == null && prevStoreDraw != null) {
        return prevStoreDraw.drawDateAndTime;
      }
      // The draw is comming soon.
      else if (nextStoreDraw != null && prevStoreDraw == null) {
        return nextStoreDraw.drawDateAndTime;
      } else {
        return null;
      }
    }

    // There is a competition to be watched today.
    return widget.commingStoreDraws[specialDateIndex].drawDateAndTime;
  }

  void updateHasTimeRemaining() {
    setState(() {
      hasTimeRemaining = false;
    });
  }

  void updateIsCompetitionOver() {
    setState(() {
      isCompetitionOver = true;
    });
  }

  StoreDraw? findPrevStoreDraw(DateTime now) {
    StoreDraw? prevDraw;
    int competitionIndex;
    for (competitionIndex = 0;
        competitionIndex < widget.commingStoreDraws.length;
        competitionIndex++) {
      if (widget.commingStoreDraws[competitionIndex].drawDateAndTime
          .isBefore(now)) {
        prevDraw = widget.commingStoreDraws[competitionIndex];
      }
    }

    return prevDraw;
  }

  StoreDraw? findNextStoreDraw(DateTime now) {
    StoreDraw? nextStoreDraw;
    for (int competitionIndex = widget.commingStoreDraws.length - 1;
        competitionIndex >= 0;
        competitionIndex--) {
      if (widget.commingStoreDraws[competitionIndex].drawDateAndTime
          .isAfter(now)) {
        nextStoreDraw = widget.commingStoreDraws[competitionIndex];
      }
    }

    return nextStoreDraw;
  }

  int findTimeDifferenceInSeconds(
      StoreDraw prevStoreDraw, StoreDraw nextStoreDraw) {
    Duration duration =
        prevStoreDraw.drawDateAndTime.difference(nextStoreDraw.drawDateAndTime);
    return duration.inSeconds;
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

  void upadateLastWonPrice() {
    if (lastWonPrice != null) {
      lastWonPrice = null;
    }
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
    DateTime now = DateTime.now();

    StoreDraw storeDraw;
    // There is no competition to be watched today.
    if (specialDateIndex < 0) {
      StoreDraw? prevStoreDraw = findPrevStoreDraw(now);
      StoreDraw? nextStoreDraw = findNextStoreDraw(now);

      // Either Show The Previous Or Comming Competition.
      if (prevStoreDraw != null && nextStoreDraw != null) {
        Duration halfOfDifferenceInSeconds = Duration(
                seconds:
                    findTimeDifferenceInSeconds(prevStoreDraw, nextStoreDraw) ~/
                        2)
            .abs();

        DateTime middleDate =
            prevStoreDraw.drawDateAndTime.add(halfOfDifferenceInSeconds);
        Duration timePassedSincePrevCompetitionDate =
            prevStoreDraw.drawDateAndTime.difference(DateTime.now()).abs();

        if (prevStoreDraw.drawDateAndTime
            .add(timePassedSincePrevCompetitionDate)
            .isAfter(middleDate)) {
          storeDraw = widget.commingStoreDraws[_findSpecialDateIndex()];

          /* Make sure last won price summary is null if a 
          widget other than WinnerWidget is to be returned.*/
          upadateLastWonPrice();

          if (hasTimeRemaining == true) {
            if (timeRemaining == null) {
              updateRemainingTimeTween();
            }
            timeLeft = timeRemaining!.value.toString().substring(0, 8);
            if (timeLeft![1] == ':') {
              timeLeft = timeLeft!.substring(0, 7);
            }
            debug.log('$timeLeft\n');

            return WaitWidget(
              time: timeLeft!,
              storeDraw: storeDraw,
              onRemainingTimeElapsed: updateHasTimeRemaining,
            );
          } else {
            /* Make sure hasTimeRemaining is false if an 
            OnPlayWidget is to be returned.*/
            hasTimeRemaining = false;

            return OnPlayWidget(
                storeId: storeDraw.storeFK,
                storeName: storeDraw.storeName,
                sectionName: storeDraw.sectionName,
                storeImageURL: storeDraw.storeImageURL);
          }
        } else {
          if (lastWonPrice!.wonDate.difference(DateTime.now()).inHours < 24) {
            /* Make sure hasTimeRemaining is null if a 
            widget other than WaitWidget is to be returned.*/
            hasTimeRemaining = null;

            return WinnerWidget(
              wonPriceSummary: lastWonPrice!,
            );
          } else {
            /* Make sure last won price summary is null if a 
            widget other than WinnerWidget is to be returned.*/
            upadateLastWonPrice();

            /* Make sure hasTimeRemaining is null if a 
            widget other than WaitWidget is to be returned.*/
            hasTimeRemaining = null;

            return NoCompetitionWidget(
                storeId: widget.commingStoreDraws[0].storeFK,
                storeName: widget.commingStoreDraws[0].storeName,
                sectionName: widget.commingStoreDraws[0].sectionName,
                storeImageURL: widget.commingStoreDraws[0].storeImageURL);
          }
        }
      }

      // There Was A Competition/Draw But It Time Has Passed.
      // Now Show The Last Won Price.
      // Assuming There Is Only One Competition On A Given Day.
      else if (nextStoreDraw == null && prevStoreDraw != null) {
        if (lastWonPrice!.wonDate.difference(DateTime.now()).inHours < 24) {
          /* Make sure hasTimeRemaining is null if a 
          widget other than WaitWidget is to be returned.*/
          hasTimeRemaining = null;

          return WinnerWidget(
            wonPriceSummary: lastWonPrice!,
          );
        } else {
          /* Make sure last won price summary is null if a 
            widget other than WinnerWidget is to be returned.*/
          upadateLastWonPrice();

          /* Make sure hasTimeRemaining is null if a 
            widget other than WaitWidget is to be returned.*/
          hasTimeRemaining = null;

          return NoCompetitionWidget(
              storeId: widget.commingStoreDraws[0].storeFK,
              storeName: widget.commingStoreDraws[0].storeName,
              sectionName: widget.commingStoreDraws[0].sectionName,
              storeImageURL: widget.commingStoreDraws[0].storeImageURL);
        }
      }
      // The draw is comming soon.
      else if (nextStoreDraw != null && prevStoreDraw == null) {
        storeDraw = widget.commingStoreDraws[_findSpecialDateIndex()];

        /* Make sure last won price summary is null if a 
          widget other than WinnerWidget is to be returned.*/
        upadateLastWonPrice();

        if (hasTimeRemaining == true) {
          timeLeft = timeRemaining!.value.toString().substring(0, 8);
          if (timeLeft![1] == ':') {
            timeLeft = timeLeft!.substring(0, 7);
          }
          debug.log(timeLeft!);

          return WaitWidget(
            time: timeLeft!,
            storeDraw: storeDraw,
            onRemainingTimeElapsed: updateHasTimeRemaining,
          );
        } else {
          /* Make sure hasTimeRemaining is false if an 
            OnPlayWidget is to be returned.*/
          hasTimeRemaining = false;

          return OnPlayWidget(
              storeId: storeDraw.storeFK,
              storeName: storeDraw.storeName,
              sectionName: storeDraw.sectionName,
              storeImageURL: storeDraw.storeImageURL);
        }
      } else {
        /* Make sure last won price summary is null if a 
        widget other than WinnerWidget is to be returned.*/
        upadateLastWonPrice();

        /* Make sure hasTimeRemaining is null if a 
        widget other than WaitWidget is to be returned.*/
        hasTimeRemaining = null;

        return NoCompetitionWidget(
            storeId: widget.commingStoreDraws[0].storeFK,
            storeName: widget.commingStoreDraws[0].storeName,
            sectionName: widget.commingStoreDraws[0].sectionName,
            storeImageURL: widget.commingStoreDraws[0].storeImageURL);
      }
    }

    // There is a competition to be watched today.
    else {
      storeDraw = widget.commingStoreDraws[specialDateIndex];

      // The Draw/Competition Is Currently Playing.
      if (now.isAfter(storeDraw
              .drawDateAndTime) /*&& 
      now.isBefore(storeDraw.drawDateAndTime.add(storeDraw.duration!)) */
          ) {
        /* Make sure last won price summary is null if a 
        widget other than WinnerWidget is to be returned.*/
        upadateLastWonPrice();

        /* Make sure hasTimeRemaining is false if an 
        OnPlayWidget is to be returned.*/
        hasTimeRemaining = false;

        return OnPlayWidget(
          storeId: storeDraw.storeFK,
          storeName: storeDraw.storeName,
          storeImageURL: storeDraw.storeImageURL,
          sectionName: storeDraw.sectionName,
        );
      } else if (now
          .isAfter(storeDraw.drawDateAndTime /*.add(storeDraw.duration!)*/)) {
        if (lastWonPrice!.wonDate.difference(DateTime.now()).inHours < 24) {
          /* Make sure hasTimeRemaining is null if a 
          widget other than WaitWidget is to be returned.*/
          hasTimeRemaining = null;

          return WinnerWidget(
            wonPriceSummary: lastWonPrice!,
          );
        } else {
          /* Make sure last won price summary is null if a 
            widget other than WinnerWidget is to be returned.*/
          upadateLastWonPrice();

          /* Make sure hasTimeRemaining is null if a 
            widget other than WaitWidget is to be returned.*/
          hasTimeRemaining = null;

          return NoCompetitionWidget(
            storeId: widget.commingStoreDraws[0].storeFK,
            storeName: widget.commingStoreDraws[0].storeName,
            storeImageURL: widget.commingStoreDraws[0].storeImageURL,
            sectionName: widget.commingStoreDraws[0].sectionName,
          );
        }
      }

      // The searched store name exist and the draw is about to begin.
      // A countdown clock needs to be display until the draw begins,
      // in which chase it will disappear.
      else {
        storeDraw = widget.commingStoreDraws[_findSpecialDateIndex()];

        /* Make sure last won price summary is null if a 
          widget other than WinnerWidget is to be returned.*/
        upadateLastWonPrice();

        if (hasTimeRemaining == true) {
          if (timeRemaining == null) {
            updateRemainingTimeTween();
          }

          timeLeft = timeRemaining!.value.toString().substring(0, 8);
          if (timeLeft![1] == ':') {
            timeLeft = timeLeft!.substring(0, 7);
          }
          debug.log(timeLeft!);
          return WaitWidget(
            time: timeLeft!,
            storeDraw: storeDraw,
            onRemainingTimeElapsed: updateHasTimeRemaining,
          );
        } else {
          /* Make sure hasTimeRemaining is false if an 
            OnPlayWidget is to be returned.*/
          hasTimeRemaining = false;

          return OnPlayWidget(
            storeId: storeDraw.storeFK,
            storeName: storeDraw.storeName,
            storeImageURL: storeDraw.storeImageURL,
            sectionName: storeDraw.sectionName,
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
