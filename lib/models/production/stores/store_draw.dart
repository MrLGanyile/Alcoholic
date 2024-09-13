// Collection Name /stores/storeId/store_draws/storeDrawId
import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

import '../../section_name.dart';

class StoreDraw extends MayBeFake {
  String storeDrawId;
  String storeFK;
  DateTime drawDateAndTime;
  double joiningFee;
  int numberOfCompetitorsSoFar;
  bool isOpen;
  int numberOfGrandPrices;
  String storeName;
  String storeImageURL;
  SectionName sectionName;

  // Contains A Sub Collection Of Draw Grand Prices
  // Contains A Sub Collection Of Draw Competitors

  StoreDraw({
    required this.storeDrawId,
    required this.storeFK,
    required this.drawDateAndTime,
    required this.joiningFee,
    required this.numberOfCompetitorsSoFar,
    this.isOpen = true,
    required this.numberOfGrandPrices,
    required this.storeName,
    required this.storeImageURL,
    required this.sectionName,
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map.addAll({
      'Store Draw Id': storeDrawId,
      'Store FK': storeFK,
      'Draw Date & Time': drawDateAndTime,
      'Joining Fee': joiningFee,
      'Number Of Grand Prices': numberOfGrandPrices,
      'Number of Competitors So Far': numberOfCompetitorsSoFar,
      'Is Open': isOpen,
      'Store Name': storeName,
      'Store Image URL': storeImageURL,
      'Section Name': sectionName,
    });
    return map;
  }

  factory StoreDraw.fromJson(dynamic json) => StoreDraw(
      storeDrawId: json['Store Draw Id'],
      storeFK: json['Store FK'],
      drawDateAndTime: json['Draw Date & Time'],
      joiningFee: json['Joining Fee'],
      numberOfGrandPrices: json['Number Of Grand Prices'],
      numberOfCompetitorsSoFar: json['Number of Competitors So Far'],
      isOpen: json['Is Open'],
      storeName: json['Store Name'],
      storeImageURL: json['Store Image URL'],
      sectionName: json['Section Name'],
      isFake: json['Is Fake'] == 'Yes' ? true : false);
}
