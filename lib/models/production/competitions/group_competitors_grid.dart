/* Collection Name /competition/competitionId
/competitors_grids*/
import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

// Competition & CompetitorGrid Have Similar IDs
class GroupCompetitorsGrid extends MayBeFake {
  String competitorsGridId;
  String competitionFK;
  int numberOfCompetitors;
  int currentlyPointedTokenIndex;

  // The order in which participants were visited when this competition was live.
  // This property is used for the sake of viewing competitions which have already played.
  List<int> competitorsOrder;

  // Contain a sub collection of competition tokens.

  Duration duration;
  bool? hasStarted;
  bool? hasStopped;

  GroupCompetitorsGrid({
    required this.competitorsGridId,
    required this.competitionFK,
    required this.numberOfCompetitors,
    required this.currentlyPointedTokenIndex,
    required this.competitorsOrder,
    required this.duration,
    this.hasStarted = false,
    this.hasStopped = false,
    isFake,
  }) : super(isFake: isFake);

  factory GroupCompetitorsGrid.fromJson(dynamic json) {
    return GroupCompetitorsGrid(
        competitorsGridId: json['competitorsGridId'],
        competitionFK: json['competitionFK'],
        numberOfCompetitors: json['numberOfCompetitors'],
        currentlyPointedTokenIndex: json['currentlyPointedTokenIndex'],
        competitorsOrder: json['competitorsOrder'],
        duration: Duration(seconds: json['duration']),
        hasStarted: json['hasStarted'],
        hasStopped: json['hasStopped'],
        isFake: json['isFake'] == 'Yes' ? true : false);
  }
}
