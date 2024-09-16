import 'dart:developer' as debug;
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/production/stores/store_draw.dart';
import 'store_info_widget.dart';
import 'competition_screen_helper.dart';

class OnWaitWidget extends StoreInfoWidget {
  StoreDraw storeDraw;

  OnWaitWidget({
    super.key,
    required this.storeDraw,
    required storeId,
    required storeName,
    required sectionName,
    required storeImageURL,
  }) : super(
          storeId: storeId,
          storeName: storeName,
          storeImageURL: storeImageURL,
          sectionName: sectionName,
        );

  @override
  State createState() => OnWaitWidgetState();

  Widget remainingTime(DateTime specialDate) {
    DateTime justNow = DateTime.now();
    int newHours = specialDate.hour,
        newMinutes = specialDate.minute,
        newSeconds = specialDate.second;

    if (specialDate.second >= justNow.second) {
      newSeconds = specialDate.second - justNow.second;
    } else {
      if (specialDate.minute > 0) {
        newMinutes--;
      } else {
        newHours--;
        newMinutes = 59;
      }
      newSeconds = specialDate.second + 60 - justNow.second;
    }

    DateTime newDate = DateTime(
      specialDate.year,
      specialDate.month,
      specialDate.day,
      newHours - justNow.hour,
      newMinutes - justNow.minute,
      newSeconds - justNow.second,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Remaining Time',
            style: TextStyle(
                fontSize: MyApplication.infoTextFontSize,
                color: MyApplication.storeInfoTextColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
          Text(
            '${newDate.hour}:${newDate.minute}:${newDate.second}',
            style: TextStyle(
                fontSize: MyApplication.infoTextFontSize,
                color: MyApplication.storeInfoTextColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }
}

class OnWaitWidgetState extends State<OnWaitWidget> {
  @override
  Widget build(BuildContext context) {
    Column detailsColumn = widget.retrieveStoreDetails(context);

    detailsColumn.children
        .add(widget.remainingTime(widget.storeDraw.drawDateAndTime));

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: widget.retrieveStoreImage(context),
        ),
        detailsColumn,
        _buildGrandPrices(),
      ]),
    );
  }

  Widget _buildGrandPrices() {
    Widget grid;

    double horizontalGrandPriceSpaceces = 10;

    switch (widget.storeDraw.numberOfCompetitorsSoFar) {
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
                      storeDraw: widget.storeDraw, grandPriceIndex: 0),
                  const Expanded(child: SizedBox.shrink()),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: widget.storeDraw, grandPriceIndex: 1),
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
                      storeDraw: widget.storeDraw, grandPriceIndex: 2),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: widget.storeDraw, grandPriceIndex: 3),
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
                      storeDraw: widget.storeDraw, grandPriceIndex: 0),
                  buildAlarm(),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: widget.storeDraw, grandPriceIndex: 1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Middle Grand Price.
                CompetitionScreenHelper(
                    storeDraw: widget.storeDraw, grandPriceIndex: 2),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: widget.storeDraw, grandPriceIndex: 3),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: widget.storeDraw, grandPriceIndex: 4),
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
                      storeDraw: widget.storeDraw, grandPriceIndex: 0),
                  buildAlarm(),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      alignmentGeometry: Alignment.centerRight,
                      storeDraw: widget.storeDraw,
                      grandPriceIndex: 1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Left Grand Price.
                CompetitionScreenHelper(
                    storeDraw: widget.storeDraw, grandPriceIndex: 2),
                const Expanded(child: SizedBox.shrink()),
                // Middle Right Grand Price.
                CompetitionScreenHelper(
                    storeDraw: widget.storeDraw, grandPriceIndex: 3),
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
                      storeDraw: widget.storeDraw, grandPriceIndex: 4),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: widget.storeDraw, grandPriceIndex: 5),
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
                      storeDraw: widget.storeDraw, grandPriceIndex: 0),
                  buildAlarm(),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: widget.storeDraw, grandPriceIndex: 1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Left Grand Price.
                CompetitionScreenHelper(
                    storeDraw: widget.storeDraw, grandPriceIndex: 2),
                // Middle Right Grand Price.
                CompetitionScreenHelper(
                    storeDraw: widget.storeDraw, grandPriceIndex: 3),
                // Middle Grand Price.
                CompetitionScreenHelper(
                    storeDraw: widget.storeDraw, grandPriceIndex: 4),
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
                      storeDraw: widget.storeDraw, grandPriceIndex: 5),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: widget.storeDraw, grandPriceIndex: 6),
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
                      storeDraw: widget.storeDraw, grandPriceIndex: 0),
                  // Top Middle Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: widget.storeDraw, grandPriceIndex: 1),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: widget.storeDraw, grandPriceIndex: 2),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Right Grand Price.
                CompetitionScreenHelper(
                    storeDraw: widget.storeDraw, grandPriceIndex: 3),
                buildAlarm(),
                // Middle Left Grand Price.
                CompetitionScreenHelper(
                    storeDraw: widget.storeDraw, grandPriceIndex: 4),
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
                      storeDraw: widget.storeDraw, grandPriceIndex: 5),
                  // Middle Bottom Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: widget.storeDraw, grandPriceIndex: 6),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      storeDraw: widget.storeDraw, grandPriceIndex: 7),
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
              size: MyApplication.alarmIconFontSize - 5,
            ),
          ),
        ),
      );
}
