// Collection Name /stores/storeId/store_draws/storeDrawId
import 'package:alcoholic/models/Utilities/may_be_fake.dart';
import 'package:alcoholic/models/stores/store_draw_state.dart';

import '../Utilities/converter.dart';
import '../section_name.dart';

class StoreDraw extends MayBeFake {
  String storeDrawId;
  String storeFK;
  DateTime drawDateAndTime;

  bool isOpen;
  int numberOfGrandPrices;
  String storeName;
  String storeImageURL;
  SectionName sectionName;
  StoreDrawState? storeDrawState;

  // Contains A Sub Collection Of Draw Grand Prices
  // Contains A Sub Collection Of Draw Competitors

  StoreDraw({
    required this.storeDrawId,
    required this.storeFK,
    required this.drawDateAndTime,
    this.isOpen = true,
    required this.numberOfGrandPrices,
    required this.storeName,
    required this.storeImageURL,
    required this.sectionName,
    this.storeDrawState = StoreDrawState.notConvertedToCompetition,
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
      'numberOfGrandPrices': numberOfGrandPrices,
      'isOpen': isOpen,
      'storeName': storeName,
      'storeImageURL': storeImageURL,
      'sectionName': sectionName,
      'storeDrawState': Converter.fromStoreDrawStateToString(storeDrawState!),
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
      numberOfGrandPrices: json['numberOfGrandPrices'],
      isOpen: json['isOpen'],
      storeName: json['storeName'],
      storeImageURL: json['storeImageURL'],
      sectionName: Converter.toSectionName(json['sectionName']),
      storeDrawState: Converter.toStoreDrawState(json['storeDrawState']),
      isFake: json['isFake'] == 'Yes' ? true : false);
}
