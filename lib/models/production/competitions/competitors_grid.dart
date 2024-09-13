/* Collection Name /competition/competitionId
/competitors_grids*/
import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

class CompetitorsGrid extends MayBeFake {
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

  CompetitorsGrid({
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

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map.addAll({
      'Competitors Grid Id': competitorsGridId,
      'Competition FK': competitionFK,
      'Number Of Competitors': numberOfCompetitors,
      'Currently Pointed Token Index': currentlyPointedTokenIndex,
      'Competitors Order': competitorsOrder,
      'Duration': duration,
      'Has Started': hasStarted,
      'Has Stopped': hasStopped,
    });
    return map;
  }

  factory CompetitorsGrid.fromJson(dynamic json) {
    return CompetitorsGrid(
        competitorsGridId: json['Competitors Grid Id'],
        competitionFK: json['Competition FK'],
        numberOfCompetitors: json['Number Of Competitors'],
        currentlyPointedTokenIndex: json['Currently Pointed Token Index'],
        competitorsOrder: json['Competitors Order'],
        duration: json['Duration'],
        hasStarted: json['Has Started'],
        hasStopped: json['Has Stopped'],
        isFake: json['Is Fake'] == 'Yes' ? true : false);
  }
}
