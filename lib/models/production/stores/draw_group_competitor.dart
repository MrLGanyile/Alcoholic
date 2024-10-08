import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

import '../../section_name.dart';

// Collection Name /stores/storeId/store_draws/drawId/draw_groups_competitors/drawGroupCompetitorId
class DrawGroupCompetitor extends MayBeFake {
  String groupCompetitorId; // Not A User Id
  String storeDrawFK;

  String groupImageURL;
  String creatorUsername;
  String creatorId;

  String groupName; // Abaphathi Bemali
  int groupNumber; // 4
  SectionName groupSectionName;
  String groupSpecificLocation; // For Example Ringini
  List<String> groupMembers; // Group Members Phone Numbers.

  DrawGroupCompetitor({
    required this.groupCompetitorId,
    required this.storeDrawFK,
    required this.groupImageURL,
    required this.creatorUsername,
    required this.creatorId,
    required this.groupName,
    required this.groupNumber,
    required this.groupSectionName,
    required this.groupSpecificLocation,
    this.groupMembers = const [],
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();

    map.addAll({
      'groupCompetitorId': groupCompetitorId,
      'storeDrawFK': storeDrawFK,
      'groupImageURL': groupImageURL,
      'creatorUsername': creatorUsername,
      'creatorId': creatorId,
      'groupNumber': groupNumber,
      'groupName': groupName,
      'groupSectionName': groupSectionName,
      'groupSpecificLocation': groupSpecificLocation,
      'groupMembers': groupMembers,
    });
    return map;
  }

  factory DrawGroupCompetitor.fromJson(dynamic json) {
    DrawGroupCompetitor competitor = DrawGroupCompetitor(
        groupCompetitorId: json['groupCompetitorId'],
        storeDrawFK: json['storeDrawFK'],
        groupImageURL: json['groupImageURL'],
        creatorUsername: json['creatorUsername'],
        creatorId: json['creatorId'],
        groupName: json['groupName'],
        groupNumber: json['groupNumber'],
        groupSectionName: json['groupSectionName'],
        groupSpecificLocation: json['groupSpecificLocation'],
        groupMembers: json['groupMembers'],
        isFake: json['Is Fake'] == 'Yes' ? true : false);

    return competitor;
  }
}
