// Collection Name /stores/storeId/store_draws/storeDrawId
import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';
import 'package:alcoholic/models/production/stores/store_draw_state.dart';

import '../../section_name.dart';

class StoreDraw extends MayBeFake {
  String storeDrawId;
  String storeFK;
  DateTime drawDateAndTime;
  double joiningFee;
  int numberOfGroupCompetitorsSoFar;
  bool isOpen;
  int numberOfGrandPrices;
  String storeName;
  String storeImageURL;
  SectionName sectionName;
  StoreDrawState storeDrawState; // new

  // Contains A Sub Collection Of Draw Grand Prices
  // Contains A Sub Collection Of Draw Competitors

  StoreDraw({
    required this.storeDrawId,
    required this.storeFK,
    required this.drawDateAndTime,
    required this.joiningFee,
    required this.numberOfGroupCompetitorsSoFar,
    this.isOpen = true,
    required this.numberOfGrandPrices,
    required this.storeName,
    required this.storeImageURL,
    required this.sectionName,
    this.storeDrawState = StoreDrawState.isComming,
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map.addAll({
      'storeDrawId': storeDrawId,
      'storeFK': storeFK,
      'drawDateAndTime': {
        'year': drawDateAndTime.year,
        'month': drawDateAndTime.month,
        'day': drawDateAndTime.day,
        'hour': drawDateAndTime.hour,
        'minute': drawDateAndTime.minute,
      },
      'joiningFee': joiningFee,
      'numberOfGrandPrices': numberOfGrandPrices,
      'numberOfGroupCompetitorsSoFar': numberOfGroupCompetitorsSoFar,
      'isOpen': isOpen,
      'storeName': storeName,
      'storeImageURL': storeImageURL,
      'sectionName': sectionName,
    });
    return map;
  }

  factory StoreDraw.fromJson(dynamic json) => StoreDraw(
      storeDrawId: json['storeDrawId'],
      storeFK: json['storeFK'],
      drawDateAndTime: DateTime(
        json['drawDateAndTime']['year'],
        json['drawDateAndTime']['month'],
        json['drawDateAndTime']['day'],
        json['drawDateAndTime']['hour'],
        json['drawDateAndTime']['minute'],
      ),
      joiningFee: json['joiningFee'],
      numberOfGrandPrices: json['numberOfGrandPrices'],
      numberOfGroupCompetitorsSoFar: json['numberOfGroupCompetitorsSoFar'],
      isOpen: json['isOpen'],
      storeName: json['storeName'],
      storeImageURL: json['storeImageURL'],
      sectionName: json['sectionName'],
      storeDrawState: json['storeDrawState'],
      isFake: json['isFake'] == 'Yes' ? true : false);
}
