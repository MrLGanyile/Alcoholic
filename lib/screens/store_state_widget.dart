import 'package:alcoholic/controllers/competition_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../controllers/store_controller.dart';

import '../../models/Utilities/global.dart';
import '../../models/stores/store.dart';
import '../../models/stores/store_draw.dart';
import '../../models/competitions/won_price_summary.dart';
import 'no_competition_widget.dart';
import 'on_play_widget.dart';
import 'wait_widget.dart';
import 'winner_widget.dart';
import 'dart:developer' as debug;

class StoreStateWidget extends StatefulWidget {
  // Step 1 - Accept the current store.
  String storeId;

  StoreStateWidget({
    super.key,
    required this.storeId,
  });

  @override
  StoreStateWidgetState createState() => StoreStateWidgetState();
}

class StoreStateWidgetState extends State<StoreStateWidget> {
  List<Widget> storeStates = [];
  late DateTime justNow;

  StoreController storeController = StoreController.storeController;
  CompetitionController competitionController =
      CompetitionController.competitionController;
  // Step 3 - Query the current store's draws.
  late Query<Map<String, dynamic>> query;

  late Duration? remainingDuration;

  @override
  void initState() {
    super.initState();
    debug.log('store state widget [initState]...');

    justNow = DateTime.now();

    // Step 3 - Query the current store's draws.
    query = FirebaseFirestore.instance
        .collection('stores')
        .doc('+27674533323') // +27787653542 +27832121223
        .collection('store_draws')
        .orderBy('drawDateAndTime.year', descending: false)
        .orderBy('drawDateAndTime.month', descending: false)
        .orderBy('drawDateAndTime.day', descending: false)
        .orderBy('drawDateAndTime.hour', descending: false)
        .orderBy('drawDateAndTime.minute', descending: false);
  }

  /* Only allowed to set commingSoonCompetition,
     currentlyPlayingCompetition, hasWinner */
  void addCommingSoonOrPlayingOrHasWinner(String storeDrawId,
      DocumentSnapshot<Map<String, dynamic>> readOnlySnapshot) {
    debug.log('addCommingSoonOrPlayingOrHasWinner...');
    FirebaseFirestore.instance
        .collection("competitions")
        .doc(storeDrawId)
        .snapshots()
        .map((competitionSnapshot) {
      if (competitionSnapshot.exists) {
        debug.log('competitionSnapshot.exists...');
        // The competition is comming soon, remaining time should be displayed.
        if (readOnlySnapshot.data()!['remainingTime'] < 0 &&
            competitionSnapshot.data()!["isLive"] == false) {
          debug.log('The competition is comming soon...');
          remainingDuration =
              Duration(seconds: readOnlySnapshot.data()!['remainingTime']);
          addStoreDrawStateWidget(
              storeDrawId, StoreState.hasCommingSoonCompetition);
        }
        // The competition is currently playing.
        else if (readOnlySnapshot.data()!['remainingTime'] >= 1 &&
            competitionSnapshot.data()!["isLive"] &&
            competitionSnapshot.data()!["isOver"] == false) {
          debug.log('The competition is currently playing...');
          addStoreDrawStateWidget(
              storeDrawId, StoreState.hasCurrentlyPlayingCompetition);
        }
        // The competition has a winner.
        else if (competitionSnapshot.data()!["isLive"] == false &&
            competitionSnapshot.data()!["isOver"]) {
          debug.log('The competition has a winner...');
          addStoreDrawStateWidget(storeDrawId, StoreState.hasWinner);
        }
      }
    });
  }

  StoreStateWidgetState();

  void addStoreDrawStateWidget(String? storeDrawId, StoreState storeState) {
    // Step 5
    switch (storeState) {
      case StoreState.hasNoCompetition:
        debug.log('store state widget [hasNoCompetition]...');
        Store? store;
        storeController.findStore(widget.storeId).then((value) {
          store = value;

          storeStates.add(NoCompetitionWidget(
              storeId: store!.storeOwnerPhoneNumber,
              storeName: store!.storeName,
              sectionName: store!.sectionName,
              storeImageURL: store!.storeImageURL));
        });

        break;
      case StoreState
          .hasCommingCompetition: /*
        storeStates.add(WaitWidget(
          storeId: widget.storeId,
          storeDrawId: storeDrawId!,
        )); */
        break;
      case StoreState
          .hasCommingSoonCompetition: /*
        storeStates.add(WaitWidget(
          storeId: widget.storeId,
          storeDrawId: storeDrawId!,
          remainingDuration: remainingDuration,
        )); */
        break;
      case StoreState
          .hasCurrentlyPlayingCompetition: /*
        StoreDraw? storeDraw;
        storeController.findStoreDraw(widget.storeId, storeDrawId!);
        storeStates.add(OnPlayWidget(
            storeId: widget.storeId,
            storeName: storeDraw?.storeName,
            sectionName: storeDraw?.sectionName,
            storeImageURL: storeDraw?.storeImageURL)); */
        break;
      case StoreState.hasWinner:
        debug.log('store state widget [hasWinner]...');
        WonPriceSummary? wonPriceSummary;
        competitionController
            .findWonPriceSummary('+27674533323', storeDrawId!)
            .then((value) {
          wonPriceSummary = value;
          storeStates.add(WinnerWidget(wonPriceSummary: wonPriceSummary!));
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    debug.log('store state widget [build]...');
    query.snapshots().forEach((element) {
      // No store draws have ever been created on this store so far.
      if (element.size == 0) {
        addStoreDrawStateWidget(null, StoreState.hasNoCompetition);
      } else {
        // Step 4 - Check whether each store draw has a competition.
        query.snapshots().map((storeDrawsSnapshot) =>
            storeDrawsSnapshot.docs.map((storeDrawDoc) {
              StoreDraw storeDraw = StoreDraw.fromJson(storeDrawDoc.data());

              // Find the date of the current store draw.
              int day = storeDraw.drawDateAndTime.day;
              int month = storeDraw.drawDateAndTime.month;
              int year = storeDraw.drawDateAndTime.year;
              int hour = storeDraw.drawDateAndTime.hour;
              int minute = storeDraw.drawDateAndTime.minute;
              String competitionDateId = '$day-$month-$year-$hour-$minute';

              /* Check if the current store draw is yet 
              converted into a competition or not.*/
              FirebaseFirestore.instance
                  .collection('read_only')
                  .doc(competitionDateId)
                  .snapshots()
                  .map((readOnlySnapshot) {
                /* The current store draw has a competition 
                    either comming soon, in progress or that is finished.*/
                if (readOnlySnapshot.exists) {
                  addCommingSoonOrPlayingOrHasWinner(
                      storeDraw.storeDrawId, readOnlySnapshot);
                } else if (storeDraw.isOpen) {
                  addStoreDrawStateWidget(
                      storeDraw.storeDrawId, StoreState.hasCommingCompetition);
                }
              });
            }));
      }
    });

    return ListView(
      children: storeStates,
    );
  }
}
