import 'package:alcoholic/controllers/competition_controller.dart';
import 'package:alcoholic/models/Utilities/read_only.dart';
import 'package:alcoholic/phone%20auth%20example/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrackingRemTimeWidget extends StatefulWidget {
  @override
  State createState() => TrackingRemTimeWidgetState();
}

class TrackingRemTimeWidgetState extends State<TrackingRemTimeWidget> {
  CompetitionController competitionController =
      CompetitionController.competitionController;

  String readOnlyId = "16-11-2024-11-55";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<DocumentSnapshot>(
        stream: competitionController.retrieveReadOnly(readOnlyId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ReadOnly readOnly = ReadOnly.fromJson(snapshot.data);
            int remainingTime = readOnly.remainingTime;
            return Center(
              child: Text(
                '$remainingTime',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            );
          } else if (snapshot.hasError) {
            log('Error fetching readOnly data ${snapshot.error}');
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
