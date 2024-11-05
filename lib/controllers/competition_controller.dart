import 'dart:io';

import 'package:alcoholic/models/social/won_price_summary_comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/section_name.dart';
import '../models/competitions/competition.dart';
import '../models/competitions/grand_price_token.dart';
import '../models/competitions/grand_prices_grid.dart';
import '../models/competitions/group_competitor_token.dart';
import '../models/competitions/group_competitors_grid.dart';
import '../models/competitions/won_price_summary.dart';
import '../models/social/group.dart';
import 'dart:developer' as debug;

class CompetitionController extends GetxController {
  static CompetitionController competitionController = Get.find();

  late Rx<File?> groupPickedFile;
  File? get groupImageFile => groupPickedFile.value;

  late Rx<File?> creatorPickedFile;
  File? get creatprImageFile => creatorPickedFile.value;

  /*======================Competitors Group[Start]======================== */
  void saveCompetitorsGroup(
      String groupName,
      File groupImage,
      SectionName groupSectionName,
      String groupSpecificArea,
      String groupCreatorPhoneNumber,
      File groupCreatorImage,
      String groupMembers,
      String groupCreateUsername) {}

  Future<Group?> findGroup(String competitorsGroupId) async {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('groups').doc(competitorsGroupId);

    DocumentSnapshot snapshot = await reference.get();

    if (snapshot.exists) {
      return Group.fromJson(snapshot.data()!);
    }

    return null;
  }

  Stream<List<Group>> readAllGroups() {
    Stream<List<Group>> stream = FirebaseFirestore.instance
        .collection('groups')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              Group group = Group.fromJson(doc.data());
              return group;
            }).toList());

    return stream;
  }

  void switchGroup(String? fromGroupId, String toGroupId) {
    if (fromGroupId != null) {
      FirebaseFirestore.instance
          .collection('competitors_groups')
          .doc(fromGroupId);
    }
  }

  /*======================Groups[End]======================== */

  /*=======================Won Price Summary [Start]===================== */
  Future<WonPriceSummary?> findWonPriceSummary(
      String storeFK, String competitionId) async {
    Future<QuerySnapshot> querySnapshot = FirebaseFirestore.instance
        .collection('stores')
        .doc(storeFK)
        .collection('won_prices_summaries')
        .where('wonPriceSummaryId', isEqualTo: competitionId)
        .get();

    querySnapshot.then((value) => value.docs.map((doc) {
          debug.log(doc.data().toString());
          return WonPriceSummary.fromJson(doc.data());
        }));

    return null;
  }

  Stream<List<WonPriceSummary>> readAllWonPriceSummaries() =>
      FirebaseFirestore.instance
          .collection('won_prices_summaries')
          .snapshots()
          .map((wonPriceSummariesSnapshot) =>
              wonPriceSummariesSnapshot.docs.map((wonPriceSummaryDoc) {
                WonPriceSummary wonPriceSummary =
                    WonPriceSummary.fromJson(wonPriceSummaryDoc.data());
                return wonPriceSummary;
              }).toList());

  /*=======================Won Price Summary [End]===================== */

  Stream<List<WonPriceSummaryComment>> readAllWonPriceComments(
          String wonPriceId) =>
      FirebaseFirestore.instance
          .collection("won_prices_summaries")
          .doc(wonPriceId)
          .collection("comments")
          .snapshots()
          .map((wonPriceCommentsSnapshot) => wonPriceCommentsSnapshot.docs
              .map((wonPriceCommentDoc) =>
                  WonPriceSummaryComment.fromJson(wonPriceCommentDoc.data()))
              .toList());

  /*=======================Competition [Start]===================== */

  Future<Competition?> findCompetition(String competitionId) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('competitions')
        .doc(competitionId);

    DocumentSnapshot snapshot = await reference.get();

    if (snapshot.exists) {
      return Competition.fromJson(snapshot.data()!);
    }

    return null;
  }
  /*=======================Competition [End]===================== */

  /*=======================Grand Price Grid [Start]===================== */

  Future<GrandPricesGrid?> findGrandPricesGrid(
      String competitionFK, String grandPricesGridId) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('competitions')
        .doc(competitionFK)
        .collection('grand_prices_grids')
        .doc(grandPricesGridId);

    DocumentSnapshot snapshot = await reference.get();

    if (snapshot.exists) {
      return GrandPricesGrid.fromJson(snapshot.data()!);
    }

    return null;
  }
  /*=======================Grand Price Grid [End]===================== */

  /*===================Grand Price Grid Token [Start]================= */

  Stream<List<GrandPriceToken>> readCompetitionGrandPricesTokens(
          String competitionFK, String grandPricesGridId) =>
      FirebaseFirestore.instance
          .collection('competitions')
          .doc(competitionFK)
          .collection('grand_prices_grids')
          .doc(grandPricesGridId)
          .collection('grand_prices_tokens')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => GrandPriceToken.fromJson(doc.data()))
              .toList());

  /*===================Grand Price Grid Token [End]================= */

  /*===================Competitors Grid [Start]================= */

  Future<GroupCompetitorsGrid?> findCompetitorsGrid(
      String competitionFK, String competitorGridId) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('competitions')
        .doc(competitionFK)
        .collection('competitors_grids')
        .doc(competitorGridId);

    DocumentSnapshot snapshot = await reference.get();

    if (snapshot.exists) {
      return GroupCompetitorsGrid.fromJson(snapshot.data()!);
    }

    return null;
  }
  /*===================Competitors Grid [End]================= */

  /*===================Competitors Grid Token[Start]================= */

  Stream<List<GroupCompetitorToken>> readCompetitionCompetitorsTokens(
          String competitionFK, String competitorsGridId) =>
      FirebaseFirestore.instance
          .collection('competitions')
          .doc(competitionFK)
          .collection('grand_prices_grids')
          .doc(competitorsGridId)
          .collection('grand_prices_tokens')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => GroupCompetitorToken.fromJson(doc.data()))
              .toList());
  /*===================Competitors Grid Token[End]================= */
}
