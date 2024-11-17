import 'package:alcoholic/controllers/competition_controller.dart';
import 'package:alcoholic/models/stores/store_draw_state.dart';
import 'package:alcoholic/screens/competition_finished_widget.dart';
import 'package:alcoholic/screens/grand_prices_grid._widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../controllers/store_controller.dart';

import '../../models/stores/store_draw.dart';
import '../main.dart';
import '../models/Utilities/converter.dart';
import '../models/Utilities/read_only.dart';
import '../models/competitions/competition.dart';
import '../models/section_name.dart';
import 'competitors_grid_widget.dart';
import 'no_competition_widget.dart';
import 'on_play_widget.dart';
import 'on_wait_widget.dart';
import 'wait_widget.dart';
import 'dart:developer' as debug;

class StoreStateWidget extends StatefulWidget {
  // Step 1 - Accept the current store.
  String storeId;
  String storeName;
  String storeImageURL;
  SectionName sectionName;

  StoreStateWidget({
    super.key,
    required this.storeId,
    required this.storeName,
    required this.storeImageURL,
    required this.sectionName,
  });

  @override
  StoreStateWidgetState createState() => StoreStateWidgetState();
}

class StoreStateWidgetState extends State<StoreStateWidget> {
  late DateTime justNow;

  late StoreController storeController;
  late CompetitionController competitionController;
  Reference storageReference = FirebaseStorage.instance
      .refFromURL("gs://alcoholic-expressions.appspot.com/");

  late Stream<List<StoreDraw>> storeDrawsStream;
  late List<StoreDraw> storeDraws;

  StoreDraw? latestStoreDraw;
  Duration? remainingDuration;

  bool isCurrentlyViewed = false;

  @override
  void initState() {
    super.initState();

    storeController = StoreController.storeController;
    competitionController = CompetitionController.competitionController;

    storeDrawsStream = storeController.findStoreDraws(widget.storeId);

    justNow = DateTime.now();
  }

  StoreStateWidgetState();

  void updateIsCurrentlyViewed(bool isCurrentlyViewed) {
    setState(() {
      this.isCurrentlyViewed = isCurrentlyViewed;
    });
  }

  Widget remainingTime(int minutes, int seconds) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Remaining Time ',
              style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.storesSpecialTextColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
            Text(
              '$minutes:$seconds',
              style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.storesSpecialTextColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
          ],
        ));
  }

  Column retrieveStoreDetails(BuildContext context) {
    // Information About The Hosting Store.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The Name Of A Store On Which The Winner Won From.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Store Name',
                style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    color: MyApplication.storesTextColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.storeName,
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.storesTextColor,
                    decoration: TextDecoration.none,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),

        // The Address Of A Store On Which The Winner Won From.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Store Area',
                style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.storesTextColor,
                    decoration: TextDecoration.none),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  Converter.asString(widget.sectionName),
                  style: TextStyle(
                      fontSize: MyApplication.infoTextFontSize,
                      fontWeight: FontWeight.bold,
                      color: MyApplication.storesTextColor,
                      decoration: TextDecoration.none,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<String> retrieveStoreImageURL() {
    return storageReference.child(widget.storeImageURL).getDownloadURL();
  }

  AspectRatio retrieveStoreImage(BuildContext context, String storeImageURL) {
    // The Image Of A Store On Which The Winner Won From.
    return AspectRatio(
      aspectRatio: 5 / 2,
      child: Container(
        //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8) ,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(storeImageURL)),
        ),
      ),
    );
  }

  Widget myStoreState() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: StreamBuilder<List<StoreDraw>>(
        stream: storeDrawsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            storeDraws = snapshot.data as List<StoreDraw>;

            // The are store draws on a given store.
            if (storeDraws.isNotEmpty) {
              latestStoreDraw = storeDraws[0 /*storeDraws.length - 1*/];

              int day = latestStoreDraw!.drawDateAndTime.day;
              int month = latestStoreDraw!.drawDateAndTime.month;
              int year = latestStoreDraw!.drawDateAndTime.year;
              int hour = latestStoreDraw!.drawDateAndTime.hour;
              int minute = latestStoreDraw!.drawDateAndTime.minute;

              String readOnlyId = "$day-$month-$year-$hour-$minute";

              return StreamBuilder<DocumentSnapshot>(
                stream: competitionController.retrieveReadOnly(readOnlyId),
                builder: ((context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.exists) {
                    ReadOnly readOnly = ReadOnly.fromJson(snapshot.data);

                    // The store draw is not yet converted into a competition.
                    if (latestStoreDraw!.storeDrawState ==
                        StoreDrawState.notConvertedToCompetition) {
                      return WaitWidget(
                        storeDraw: latestStoreDraw!,
                      );
                    }
                    // The store draw is converted into a competition.
                    else if (latestStoreDraw!.storeDrawState ==
                        StoreDrawState.convertedToCompetition) {
                      if (readOnly.remainingTime < 0) {
                        return OnWaitWidget(
                          storeDraw: latestStoreDraw!,
                          remainingDuration:
                              Duration(seconds: readOnly.remainingTime * -1),
                        );
                      } else {
                        // store draw state suppose to be on playing-competition-state

                        //Display play icon
                        if (isCurrentlyViewed == false) {
                          return OnPlayWidget(
                            storeId: widget.storeId,
                            storeName: widget.storeName,
                            storeImageURL: widget.storeImageURL,
                            sectionName: widget.sectionName,
                            onCurrentlyViewedUpdate: updateIsCurrentlyViewed,
                          );
                        }

                        // Display either a grand price picking ui or group picking ui.
                        else {
                          return FutureBuilder(
                            future: competitionController
                                .findCompetition(latestStoreDraw!.storeDrawId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Competition competition =
                                    snapshot.data as Competition;
                                int grandPricePickingDuration =
                                    competition.grandPricePickingDuration!;
                                int groupPickingDuration =
                                    competition.groupPickingDuration!;

                                // Show grand price picking
                                if (readOnly.remainingTime <
                                    grandPricePickingDuration) {
                                  debug.log("returns grand prices grid...");
                                  return GrandPricesGridWidget(
                                      competitionId: competition.competitionId!,
                                      passedTime: readOnly.remainingTime);
                                }
                                // Show group picking
                                else if (readOnly.remainingTime <
                                    grandPricePickingDuration +
                                        groupPickingDuration) {
                                  debug.log("returns competitors grid...");
                                  return CompetitorsGridWidget(
                                      competitionId: competition.competitionId!,
                                      passedTime: readOnly.remainingTime);
                                }
                                // Show game over
                                else {
                                  return CompetitionFinishedWidget(
                                      endMoment: competition.dateTime.add(Duration(
                                          seconds: competition
                                                  .grandPricePickingDuration! +
                                              competition
                                                  .groupPickingDuration!)));
                                }
                              } else if (snapshot.hasError) {
                                debug.log(
                                    'Error fetching competition data ${snapshot.error}');
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          );
                        }
                      }
                    }

                    // The competition is currently playing.
                    else if (latestStoreDraw!.storeDrawState ==
                        StoreDrawState.playingCompetition) {
                      return OnPlayWidget(
                        storeId: widget.storeId,
                        storeName: widget.storeName,
                        storeImageURL: widget.storeImageURL,
                        sectionName: widget.sectionName,
                        onCurrentlyViewedUpdate: updateIsCurrentlyViewed,
                      );
                    }
                    // The competition is over.
                    else {
                      return NoCompetitionWidget(
                          storeId: widget.storeId,
                          storeName: widget.storeName,
                          storeImageURL: widget.storeImageURL,
                          sectionName: widget.sectionName);
                    }
                  } else if (snapshot.hasError) {
                    debug.log(
                        "Error Fetching read only Data - ${snapshot.error}");
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    // The corresponding readonly document do not exist yet.
                    return WaitWidget(
                      storeDraw: latestStoreDraw!,
                    );
                  }
                }),
              );
            }
            // There are no store draws on a given store.
            else {
              return NoCompetitionWidget(
                  storeId: widget.storeId,
                  storeName: widget.storeName,
                  storeImageURL: widget.storeImageURL,
                  sectionName: widget.sectionName);
            }
          } else if (snapshot.hasError) {
            debug
                .log("Error Fetching Last Store Draw Data - ${snapshot.error}");
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FutureBuilder(
                future: retrieveStoreImageURL(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return retrieveStoreImage(context, snapshot.data as String);
                  } else if (snapshot.hasError) {
                    debug.log('Error Fetching Store Image - ${snapshot.error}');
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
          retrieveStoreDetails(context),
          myStoreState(),
        ],
      ),
    );
  }
}
