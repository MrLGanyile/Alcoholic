/* Collection Name /competition/competitionId
/competitors_grids/competitorsGridId
/competitor_tokens*/
import 'package:alcoholic/models/production/stores/draw_competitor.dart';

class CompetitorToken{

  String competitorTokenId;
  String? competitorsGridFK;
  int tokenIndex;
  bool isPointed;
  String competitionCompetitorImageLocation;
  String generatedUsername;
  

  CompetitorToken({
    required this.competitorTokenId,
    this.competitorsGridFK,
    required this.tokenIndex,
    required this.isPointed,
    required this.competitionCompetitorImageLocation,
    required this.generatedUsername,
  });

  Map<String, dynamic> toJson(){
    return {
      'Competitor Token Id': competitorTokenId,
      'Competitors Grid FK': competitorsGridFK,
      'Token Index': tokenIndex,
      'Is Pointed': isPointed,
      'Competitor Image Location': competitionCompetitorImageLocation,
      'User Name [Generated]': generatedUsername,
    };
  }

  factory CompetitorToken.fromJson(dynamic json){
    return CompetitorToken(
      competitorTokenId: json['Competitor Token Id'],
      competitorsGridFK: json['Competitor Grid FK'],
      tokenIndex: json['Token Index'],
      isPointed: json['Is Pointed'],
      competitionCompetitorImageLocation: json['Competitor Image Location'],
      generatedUsername: json['User Name [Generated]']
    );
  }

  factory CompetitorToken.fromDrawCompetitor(DrawCompetitor drawCompetitor){
    
    return CompetitorToken(
      competitorTokenId: drawCompetitor.competitorId, 
      tokenIndex: drawCompetitor.competitorNumber, 
      isPointed: false, 
      competitionCompetitorImageLocation: drawCompetitor.imageURL, 
      generatedUsername: drawCompetitor.threeLetters!
    );
  }

}