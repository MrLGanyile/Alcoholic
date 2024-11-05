import 'package:alcoholic/models/Utilities/may_be_fake.dart';

import '../social/group.dart';

/* Collection Name /competition/competitionId
/competitors_grids/competitorsGridId
/competitor_tokens*/
class GroupCompetitorToken extends MayBeFake {
  String groupCompetitorTokenId;
  String groupCompetitorsGridFK;
  int tokenIndex;
  bool isPointed;
  Group group;

  GroupCompetitorToken({
    required this.groupCompetitorTokenId,
    required this.groupCompetitorsGridFK,
    required this.tokenIndex,
    required this.isPointed,
    required this.group,
    isFake,
  }) : super(isFake: isFake);

  factory GroupCompetitorToken.fromJson(dynamic json) {
    return GroupCompetitorToken(
        groupCompetitorTokenId: json['groupCompetitorTokenId'],
        groupCompetitorsGridFK: json['groupCompetitorsGridFK'],
        tokenIndex: json['tokenIndex'],
        isPointed: json['isPointed'],
        group: json['group'],
        isFake: json['Is Fake'] == 'Yes' ? true : false);
  }
}
