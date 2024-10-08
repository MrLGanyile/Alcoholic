/* Collection Name /competition/competitionId
/competitors_grids/competitorsGridId
/competitor_tokens*/
import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';
import 'package:alcoholic/models/production/stores/draw_group_competitor.dart';

import '../../section_name.dart';

class GroupCompetitorToken extends MayBeFake {
  String groupCompetitorTokenId;
  String groupCompetitorsGridFK;
  int tokenIndex;
  bool isPointed;

  String groupCompetitorImageURL;
  String groupName;
  String creatorUsername;
  String creatorId;
  SectionName groupSectionName;
  String groupSpecificLocation;

  List<String> groupMembers;

  GroupCompetitorToken({
    required this.creatorUsername,
    required this.creatorId,
    required this.groupSectionName,
    required this.groupSpecificLocation,
    required this.groupCompetitorTokenId,
    required this.groupCompetitorsGridFK,
    required this.tokenIndex,
    required this.isPointed,
    required this.groupCompetitorImageURL,
    required this.groupName,
    required this.groupMembers,
    isFake,
  }) : super(isFake: isFake);

  factory GroupCompetitorToken.fromJson(dynamic json) {
    return GroupCompetitorToken(
        creatorUsername: json['creatorUsername'],
        creatorId: json['creatorId'],
        groupSectionName: json['groupSectionName'],
        groupSpecificLocation: json['groupSpecificLocation'],
        groupCompetitorTokenId: json['groupCompetitorTokenId'],
        groupCompetitorsGridFK: json['groupCompetitorsGridFK'],
        tokenIndex: json['tokenIndex'],
        isPointed: json['isPointed'],
        groupCompetitorImageURL: json['groupCompetitorImageURL'],
        groupName: json['groupName'],
        groupMembers: json['groupMembers'],
        isFake: json['Is Fake'] == 'Yes' ? true : false);
  }

  factory GroupCompetitorToken.fromDrawCompetitor(
      DrawGroupCompetitor drawGroupCompetitor) {
    return GroupCompetitorToken(
        groupCompetitorTokenId: drawGroupCompetitor.groupCompetitorId,
        groupCompetitorsGridFK: drawGroupCompetitor.storeDrawFK,
        tokenIndex: drawGroupCompetitor.groupNumber,
        isPointed: false,
        creatorUsername: drawGroupCompetitor.creatorUsername,
        creatorId: drawGroupCompetitor.creatorId,
        groupSectionName: drawGroupCompetitor.groupSectionName,
        groupSpecificLocation: drawGroupCompetitor.groupSpecificLocation,
        groupCompetitorImageURL: drawGroupCompetitor.groupImageURL,
        groupName: drawGroupCompetitor.groupName,
        groupMembers: drawGroupCompetitor.groupMembers);
  }
}
