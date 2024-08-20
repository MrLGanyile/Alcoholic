
// Collection Name /competition/competitionId/grand_prices_grids
import 'package:alcoholic/models/production/stores/draw_grand_price.dart';

import 'grand_price_token.dart';

class GrandPricesGrid{

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
    
  });

  Map<String,dynamic> toJson(){
    return {
      'Grand Prices Grid Id': competitionPricesGridId,
      'Competition FK': competitionFK,
      'Number Of Grand Prices': numberOfGrandPrices,
      'Currently Pointed Token Index': currentlyPointedTokenIndex,
      'Grand Prices Order': grandPricesOrder,
      'Duration': duration,
      'Has Started': hasStarted,
      'Has Stopped': hasStopped,
    };
  }

  factory GrandPricesGrid.fromJson(dynamic json){
    return GrandPricesGrid(
      competitionPricesGridId: json['Grand Prices Grid Id'], 
      competitionFK: json['Competition FK'],
      numberOfGrandPrices: json['Number Of Grand Prices'], 
      currentlyPointedTokenIndex: json['Currently Pointed Token Index'],
      grandPricesOrder: json['Grand Prices Order'],
      duration: json['Duration'],
      hasStarted: json['Has Started'],
      hasStopped: json['Has Stopped'],
    );
  }

}