import 'package:flutter/material.dart';
import 'dart:developer' as debug;

import '../../main.dart';
import '../../models/production/stores/store_draw.dart';
import 'competition_screen_helper.dart';

typedef OnRemainingTimeElapsed = Function();

class WaitWidget extends StatelessWidget {
  StoreDraw storeDraw;
  String time;
  OnRemainingTimeElapsed onRemainingTimeElapsed;

  WaitWidget(
      {required this.time,
      required this.storeDraw,
      required this.onRemainingTimeElapsed});

  void checkIfAnimationIsDone() {
    if (time == '0:00:00' || time == '00:00:00') {
      debug.log('Time Elapsed');
      time = '---';
      onRemainingTimeElapsed;
    }
  }

  Widget remainingTime() {
    checkIfAnimationIsDone();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
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
                  storeDraw.storeName,
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
                'Store Address',
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
                  'Store Address',
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

  AspectRatio retrieveStoreImage(BuildContext context) {
    // The Image Of A Store On Which The Winner Won From.
    return AspectRatio(
      aspectRatio: 5 / 2,
      child: Container(
        //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8) ,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(storeDraw.storeImageURL)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Column detailsColumn = retrieveStoreDetails(context);

    detailsColumn.children.add(remainingTime());

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: retrieveStoreImage(context),
        ),
        detailsColumn,
        _buildGrandPrices(),
      ]),
    );
  }

  Widget _buildGrandPrices() {
    Widget grid;

    double horizontalGrandPriceSpaceces = 10;

    switch (storeDraw.numberOfCompetitorsSoFar) {
      case 4:
        grid = Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(top: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Left Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 0),
                  const Expanded(child: SizedBox.shrink()),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildAlarm(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 2),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 3),
                ],
              ),
            ),
          ],
        );
        break;
      case 5:
        grid = Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(top: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Left Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 0),
                  buildAlarm(),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Middle Grand Price.
                CompetitionScreenHelper(
                    storeDraw: storeDraw, grandPriceIndex: 2),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 3),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 4),
                ],
              ),
            ),
          ],
        );
        break;
      case 6:
        grid = Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: horizontalGrandPriceSpaceces,
                  bottom: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Left Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 0),
                  buildAlarm(),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      alignmentGeometry: Alignment.centerRight,
                      storeDraw: storeDraw,
                      grandPriceIndex: 1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Left Grand Price.
                CompetitionScreenHelper(
                    storeDraw: storeDraw, grandPriceIndex: 2),
                const Expanded(child: SizedBox.shrink()),
                // Middle Right Grand Price.
                CompetitionScreenHelper(
                    storeDraw: storeDraw, grandPriceIndex: 3),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: horizontalGrandPriceSpaceces,
                  bottom: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 4),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 5),
                ],
              ),
            ),
          ],
        );
        break;
      case 7:
        grid = Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: horizontalGrandPriceSpaceces,
                  bottom: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Left Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 0),
                  buildAlarm(),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Left Grand Price.
                CompetitionScreenHelper(
                    storeDraw: storeDraw, grandPriceIndex: 2),
                // Middle Right Grand Price.
                CompetitionScreenHelper(
                    storeDraw: storeDraw, grandPriceIndex: 3),
                // Middle Grand Price.
                CompetitionScreenHelper(
                    storeDraw: storeDraw, grandPriceIndex: 4),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: horizontalGrandPriceSpaceces,
                  bottom: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 5),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 6),
                ],
              ),
            ),
          ],
        );
        break;
      default:
        grid = Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: horizontalGrandPriceSpaceces,
                  bottom: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Left Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 0),
                  // Top Middle Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 1),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 2),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Right Grand Price.
                CompetitionScreenHelper(
                    storeDraw: storeDraw, grandPriceIndex: 3),
                buildAlarm(),
                // Middle Left Grand Price.
                CompetitionScreenHelper(
                    storeDraw: storeDraw, grandPriceIndex: 4),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: horizontalGrandPriceSpaceces,
                  bottom: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 5),
                  // Middle Bottom Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 6),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: storeDraw, grandPriceIndex: 7),
                ],
              ),
            ),
          ],
        );
    }

    return grid;
  }

  Widget buildAlarm() => // Alarm
      Expanded(
        child: SizedBox(
          height: MyApplication.alarmIconFontSize,
          width: MyApplication.alarmIconFontSize,
          child: IconButton(
            onPressed: () => {
              // Add Alarm So That A User Will Be Informed When The Draw/Competition Begins.
              debug.log('Alarm Will Go On At ...')
            },
            icon: Icon(
              Icons.add_alarm,
              color: MyApplication.storesTextColor,
              size: MyApplication.alarmIconFontSize - 10,
            ),
          ),
        ),
      );
}
