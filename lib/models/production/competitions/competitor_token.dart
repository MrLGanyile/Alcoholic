/* Collection Name /competition/competitionId
/competitors_grids/competitorsGridId
/competitor_tokens*/
import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';
import 'package:alcoholic/models/production/stores/draw_competitor.dart';

// Competition & CompetitorGrid Have Similar IDs
class CompetitorToken extends MayBeFake {
  String competitorTokenId;
  String competitorsGridFK;
  int tokenIndex;
  bool isPointed;
  String competitionCompetitorImageLocation;
  String username;

  CompetitorToken({
    required this.competitorTokenId,
    required this.competitorsGridFK,
    required this.tokenIndex,
    required this.isPointed,
    required this.competitionCompetitorImageLocation,
    required this.username,
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map.addAll({
      'Competitor Token Id': competitorTokenId,
      'Competitors Grid FK': competitorsGridFK,
      'Token Index': tokenIndex,
      'Is Pointed': isPointed,
      'Competitor Image Location': competitionCompetitorImageLocation,
      'User Name': username,
    });
    return map;
  }

  factory CompetitorToken.fromJson(dynamic json) {
    return CompetitorToken(
        competitorTokenId: json['Competitor Token Id'],
        competitorsGridFK: json['Competitor Grid FK'],
        tokenIndex: json['Token Index'],
        isPointed: json['Is Pointed'],
        competitionCompetitorImageLocation: json['Competitor Image Location'],
        username: json['User Name'],
        isFake: json['Is Fake'] == 'Yes' ? true : false);
  }

  factory CompetitorToken.fromDrawCompetitor(DrawCompetitor drawCompetitor) {
    return CompetitorToken(
      competitorTokenId: drawCompetitor.competitorId,
      competitorsGridFK: drawCompetitor.storeDrawFK,
      tokenIndex: drawCompetitor.competitorNumber,
      isPointed: false,
      competitionCompetitorImageLocation: drawCompetitor.imageURL,
      username: drawCompetitor.username,
    );
  }
}
