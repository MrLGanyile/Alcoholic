import 'package:alcoholic/controllers/competition_controller.dart';

import '../models/social/group.dart';
import 'package:alcoholic/models/section_name.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'single_group_widget.dart';
import 'dart:developer' as debug;

class GroupsScreen extends StatefulWidget {
  GroupsScreen({
    super.key,
  });

  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  CompetitionController competitionController =
      CompetitionController.competitionController;
  late Stream<List<Group>> groupsStream;
  late List<Group> allGroups;

  @override
  void initState() {
    super.initState();

    groupsStream = competitionController.readAllGroups();
  }

  @override
  Widget build(BuildContext context) => Container(
      height: 300,
      decoration: BoxDecoration(
        color: MyApplication.scaffoldColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: StreamBuilder<List<Group>>(
          stream: groupsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              allGroups = snapshot.data!;
              allGroups.sort();

              return ListView.builder(
                itemCount: allGroups.length,
                itemBuilder: ((context, index) {
                  return SingleGroupWidget(competitorsGroup: allGroups[index]);
                }),
              );
            } else if (snapshot.hasError) {
              debug.log("Error Fetching Data - ${snapshot.error}");
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }));
}
