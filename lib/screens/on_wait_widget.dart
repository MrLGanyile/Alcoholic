import 'package:alcoholic/models/Utilities/converter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as debug;

import '../../controllers/store_controller.dart';
import '../../main.dart';
import '../../models/stores/store_draw.dart';
import '../models/stores/draw_grand_price.dart';
import 'competition_screen_helper.dart';

class OnWaitWidget extends StatefulWidget {
  StoreDraw storeDraw;
  Duration remainingDuration;

  OnWaitWidget({
    Key? key,
    required this.storeDraw,
    required this.remainingDuration,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => OnWaitWidgetState();
}

class OnWaitWidgetState extends State<OnWaitWidget> {
  StoreController storeController = StoreController.storeController;
  Reference storageReference = FirebaseStorage.instance
      .refFromURL("gs://alcoholic-expressions.appspot.com/");
  late Stream<List<DrawGrandPrice>> drawGrandPricesStream;
  late List<DrawGrandPrice> drawGrandPrices;

  @override
  void initState() {
    super.initState();
    drawGrandPricesStream = storeController.findDrawGrandPrices(
        widget.storeDraw.storeFK, widget.storeDraw.storeDrawId);
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

  @override
  Widget build(BuildContext context) {
    int initialDuration = widget.remainingDuration.inSeconds;

    int minutes = initialDuration ~/ 60;
    int seconds = initialDuration % 60;

    // Sometimes the returned snapshot has empty data.
    return StreamBuilder(
      stream: drawGrandPricesStream,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          drawGrandPrices = snapshot.data as List<DrawGrandPrice>;

          return Column(
            children: [
              remainingTime(minutes, seconds),
              _buildGrandPrices(),
            ],
          );
        } else if (snapshot.hasError) {
          debug.log(
              'Error Fetching All Draw Grand Prices Data - ${snapshot.error}');
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  Widget _buildGrandPrices() {
    Widget grid;

    double horizontalGrandPriceSpaceces = 10;

    if (drawGrandPrices.isEmpty) {
      return const Center(
        child: Text("No Grand Prices Available"),
      );
    }

    switch (drawGrandPrices.length) {
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
                      grandPriceImageURL: drawGrandPrices[0].imageURL),
                  const Expanded(child: SizedBox.shrink()),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      grandPriceImageURL: drawGrandPrices[1].imageURL),
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
                      grandPriceImageURL: drawGrandPrices[2].imageURL),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      grandPriceImageURL: drawGrandPrices[3].imageURL),
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
                      grandPriceImageURL: drawGrandPrices[0].imageURL),
                  buildAlarm(),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      grandPriceImageURL: drawGrandPrices[1].imageURL),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Middle Grand Price.
                CompetitionScreenHelper(
                    grandPriceImageURL: drawGrandPrices[2].imageURL),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  CompetitionScreenHelper(
                      grandPriceImageURL: drawGrandPrices[3].imageURL),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      grandPriceImageURL: drawGrandPrices[4].imageURL),
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
                      grandPriceImageURL: drawGrandPrices[0].imageURL),
                  buildAlarm(),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      grandPriceImageURL: drawGrandPrices[1].imageURL),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Left Grand Price.
                CompetitionScreenHelper(
                    grandPriceImageURL: drawGrandPrices[2].imageURL),
                const Expanded(child: SizedBox.shrink()),
                // Middle Right Grand Price.
                CompetitionScreenHelper(
                    grandPriceImageURL: drawGrandPrices[3].imageURL),
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
                      grandPriceImageURL: drawGrandPrices[4].imageURL),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      grandPriceImageURL: drawGrandPrices[5].imageURL),
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
                      grandPriceImageURL: drawGrandPrices[0].imageURL),
                  buildAlarm(),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      grandPriceImageURL: drawGrandPrices[1].imageURL),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Left Grand Price.
                CompetitionScreenHelper(
                    grandPriceImageURL: drawGrandPrices[2].imageURL),
                // Middle Right Grand Price.
                CompetitionScreenHelper(
                    grandPriceImageURL: drawGrandPrices[3].imageURL),
                // Middle Grand Price.
                CompetitionScreenHelper(
                    grandPriceImageURL: drawGrandPrices[4].imageURL),
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
                      grandPriceImageURL: drawGrandPrices[5].imageURL),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      grandPriceImageURL: drawGrandPrices[6].imageURL),
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
                      grandPriceImageURL: drawGrandPrices[0].imageURL),
                  // Top Middle Grand Price.
                  CompetitionScreenHelper(
                      grandPriceImageURL: drawGrandPrices[1].imageURL),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      grandPriceImageURL: drawGrandPrices[2].imageURL),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Right Grand Price.
                CompetitionScreenHelper(
                    grandPriceImageURL: drawGrandPrices[3].imageURL),
                buildAlarm(),
                // Middle Left Grand Price.
                CompetitionScreenHelper(
                    grandPriceImageURL: drawGrandPrices[4].imageURL),
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
                      grandPriceImageURL: drawGrandPrices[5].imageURL),
                  // Middle Bottom Grand Price.
                  CompetitionScreenHelper(
                      grandPriceImageURL: drawGrandPrices[6].imageURL),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      grandPriceImageURL: drawGrandPrices[7].imageURL),
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
