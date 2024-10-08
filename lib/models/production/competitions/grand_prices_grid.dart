// Collection Name /competition/competitionId/grand_prices_grids

import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

// Competition & CompetitorGrid Have Similar IDs
class GrandPricesGrid extends MayBeFake {
  String competitionPricesGridId;
  String competitionFK;
  int numberOfGrandPrices;
  int currentlyPointedTokenIndex;

  // The order in which grand prices were visited when this competition was live.
  // This property is used for the sake of viewing competitons which have already played.
  List<int> grandPricesOrder;

  // Contain a sub collection of grand prices tokens.

  Duration duration;
  bool? hasStarted;
  bool? hasStopped;

  GrandPricesGrid({
    required this.competitionPricesGridId,
    required this.competitionFK,
    required this.numberOfGrandPrices,
    required this.currentlyPointedTokenIndex,
    required this.grandPricesOrder,
    required this.duration,
    this.hasStarted = false,
    this.hasStopped = false,
    isFake,
  }) : super(isFake: isFake);

  factory GrandPricesGrid.fromJson(dynamic json) {
    return GrandPricesGrid(
        competitionPricesGridId: json['competitionPricesGridId'],
        competitionFK: json['competitionFK'],
        numberOfGrandPrices: json['numberOfGrandPrices'],
        currentlyPointedTokenIndex: json['currentlyPointedTokenIndex'],
        grandPricesOrder: json['grandPricesOrder'],
        duration: Duration(seconds: json['duration']),
        hasStarted: json['hasStarted'],
        hasStopped: json['hasStopped'],
        isFake: json['isFake'] == 'Yes' ? true : false);
  }
}
