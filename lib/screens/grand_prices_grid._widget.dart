import 'package:alcoholic/controllers/competition_controller.dart';
import 'package:alcoholic/models/competitions/grand_price_token.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'competition_screen_helper.dart';
import 'dart:developer' as debug;

class GrandPricesGridWidget extends StatefulWidget {
  String competitionId;
  int passedTime;

  GrandPricesGridWidget({
    required this.competitionId,
    required this.passedTime,
  });

  @override
  State createState() => GrandPricesGridWidgetState();
}

class GrandPricesGridWidgetState extends State<GrandPricesGridWidget> {
  CompetitionController competitionController =
      CompetitionController.competitionController;

  late Stream<List<GrandPriceToken>> grandPricesTokensStream;
  late List<GrandPriceToken> grandPricesTokens;

  @override
  void initState() {
    super.initState();

    grandPricesTokensStream = competitionController
        .readCompetitionGrandPricesTokens(widget.competitionId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<GrandPriceToken>>(
      stream: grandPricesTokensStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          grandPricesTokens = snapshot.data!;
          return _buildGrandPrices();
        } else if (snapshot.hasData) {
          debug.log('Error fetching grand prices tokens ${snapshot.error}');
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

  Widget _buildGrandPrices() {
    Widget grid;

    double horizontalGrandPriceSpaceces = 10;

    if (grandPricesTokens.isEmpty) {
      return const Center(
        child: Text("No Grand Prices Available"),
      );
    }

    switch (grandPricesTokens.length) {
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
                      isPointed: widget.passedTime % 4 == 0,
                      grandPriceImageURL: grandPricesTokens[0].imageURL),
                  const Expanded(child: SizedBox.shrink()),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 4 == 1,
                      grandPriceImageURL: grandPricesTokens[1].imageURL),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 4 == 2,
                      grandPriceImageURL: grandPricesTokens[2].imageURL),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 4 == 3,
                      grandPriceImageURL: grandPricesTokens[3].imageURL),
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
                      isPointed: widget.passedTime % 5 == 0,
                      grandPriceImageURL: grandPricesTokens[0].imageURL),

                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 5 == 1,
                      grandPriceImageURL: grandPricesTokens[1].imageURL),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Middle Grand Price.
                CompetitionScreenHelper(
                    isPointed: widget.passedTime % 5 == 2,
                    grandPriceImageURL: grandPricesTokens[2].imageURL),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 5 == 3,
                      grandPriceImageURL: grandPricesTokens[3].imageURL),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 5 == 4,
                      grandPriceImageURL: grandPricesTokens[4].imageURL),
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
                      isPointed: widget.passedTime % 6 == 0,
                      grandPriceImageURL: grandPricesTokens[0].imageURL),

                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 6 == 1,
                      grandPriceImageURL: grandPricesTokens[1].imageURL),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Left Grand Price.
                CompetitionScreenHelper(
                    isPointed: widget.passedTime % 6 == 2,
                    grandPriceImageURL: grandPricesTokens[2].imageURL),
                const Expanded(child: SizedBox.shrink()),
                // Middle Right Grand Price.
                CompetitionScreenHelper(
                    isPointed: widget.passedTime % 6 == 3,
                    grandPriceImageURL: grandPricesTokens[3].imageURL),
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
                      isPointed: widget.passedTime % 6 == 4,
                      grandPriceImageURL: grandPricesTokens[4].imageURL),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 6 == 5,
                      grandPriceImageURL: grandPricesTokens[5].imageURL),
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
                      isPointed: widget.passedTime % 7 == 0,
                      grandPriceImageURL: grandPricesTokens[0].imageURL),

                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 7 == 1,
                      grandPriceImageURL: grandPricesTokens[1].imageURL),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Left Grand Price.
                CompetitionScreenHelper(
                    isPointed: widget.passedTime % 7 == 2,
                    grandPriceImageURL: grandPricesTokens[2].imageURL),
                // Middle Right Grand Price.
                CompetitionScreenHelper(
                    isPointed: widget.passedTime % 7 == 3,
                    grandPriceImageURL: grandPricesTokens[3].imageURL),
                // Middle Grand Price.
                CompetitionScreenHelper(
                    isPointed: widget.passedTime % 7 == 4,
                    grandPriceImageURL: grandPricesTokens[4].imageURL),
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
                      isPointed: widget.passedTime % 7 == 5,
                      grandPriceImageURL: grandPricesTokens[5].imageURL),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 7 == 6,
                      grandPriceImageURL: grandPricesTokens[6].imageURL),
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
                      isPointed: widget.passedTime % 8 == 0,
                      grandPriceImageURL: grandPricesTokens[0].imageURL),
                  // Top Middle Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 8 == 1,
                      grandPriceImageURL: grandPricesTokens[1].imageURL),
                  // Top Right Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 8 == 2,
                      grandPriceImageURL: grandPricesTokens[2].imageURL),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Right Grand Price.
                CompetitionScreenHelper(
                    isPointed: widget.passedTime % 8 == 3,
                    grandPriceImageURL: grandPricesTokens[3].imageURL),

                // Middle Left Grand Price.
                CompetitionScreenHelper(
                    isPointed: widget.passedTime % 8 == 4,
                    grandPriceImageURL: grandPricesTokens[4].imageURL),
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
                      isPointed: widget.passedTime % 8 == 5,
                      grandPriceImageURL: grandPricesTokens[5].imageURL),
                  // Middle Bottom Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 8 == 6,
                      grandPriceImageURL: grandPricesTokens[6].imageURL),
                  // Bottom Right Grand Price.
                  CompetitionScreenHelper(
                      isPointed: widget.passedTime % 8 == 7,
                      grandPriceImageURL: grandPricesTokens[7].imageURL),
                ],
              ),
            ),
          ],
        );
    }

    return grid;
  }
}
