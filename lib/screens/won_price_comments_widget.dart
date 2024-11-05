import 'package:alcoholic/controllers/competition_controller.dart';

import 'package:flutter/material.dart';
import '../main.dart';
import '../models/social/won_price_summary_comment.dart';
import 'single_comment_widget.dart';
import 'dart:developer' as debug;

class WonPriceCommentsWidget extends StatefulWidget {
  String wonPriceSummaryId;
  WonPriceCommentsWidget({
    super.key,
    required this.wonPriceSummaryId,
  });

  @override
  _WonPriceCommentsWidgetState createState() => _WonPriceCommentsWidgetState();
}

class _WonPriceCommentsWidgetState extends State<WonPriceCommentsWidget> {
  List<WonPriceSummaryComment> comments = [];
  CompetitionController competitionController =
      CompetitionController.competitionController;
  late Stream<List<WonPriceSummaryComment>> commentsStream;

  @override
  void initState() {
    super.initState();
    comments.add(WonPriceSummaryComment(
      commentId: "comment_0",
      dateCreated: DateTime.now(),
      wonPriceSummaryFK: 'some_won_price_summary',
      message: "Instance StoreController has been created",
      creatorImageURL: "assets/users/alcoholics/15.jpg",
      creatorUsername: "Snathi",
      creatorFK: "+27635473645",
      isFake: true,
    ));
    comments.add(WonPriceSummaryComment(
      commentId: "comment_1",
      dateCreated: DateTime.now(),
      wonPriceSummaryFK: 'some_won_price_summary',
      message:
          "D/EGL_emulation(15411): app_time_stats: avg=44243.38ms min=44243.38ms max=44243.38ms count=1",
      creatorImageURL: "assets/users/alcoholics/16.jpg",
      creatorUsername: "Zwe",
      creatorFK: "+27635009845",
      isFake: true,
    ));
    comments.add(WonPriceSummaryComment(
      commentId: "comment_2",
      dateCreated: DateTime.now(),
      wonPriceSummaryFK: 'some_won_price_summary',
      message:
          "CompetitorsGroup' is from 'package:alcoholic/models/social/competitors_group.dart' ('lib/models/social/competitors_group.dart').",
      creatorImageURL: "assets/users/alcoholics/17.jpg",
      creatorUsername: "Nane",
      creatorFK: "+27765473645",
      isFake: true,
    ));

    commentsStream =
        competitionController.readAllWonPriceComments(widget.wonPriceSummaryId);
  }

  Widget createComments(BuildContext context) {
    return StreamBuilder<List<WonPriceSummaryComment>>(
      stream: commentsStream,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          comments = snapshot.data as List<WonPriceSummaryComment>;
          List<Widget> children = [];

          for (int i = 0; i < comments.length; i++) {
            children.add(SingleCommentWidget(comment: comments[i]));
          }

          return Column(children: children);
        } else if (snapshot.hasError) {
          debug.log("Error Fetching Won Price Comments - ${snapshot.error}");
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

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        color: MyApplication.scaffoldColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: createComments(context));
}
