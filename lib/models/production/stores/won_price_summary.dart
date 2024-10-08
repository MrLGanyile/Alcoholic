// Collection Name /won_prices_summaries/wonPriceSummaryId
import '../Utilities/may_be_fake.dart';

import '../../section_name.dart';

class WonPriceSummary extends MayBeFake {
  String wonPriceSummaryId;
  String storeFK;
  String winnerImageURL;
  String winnerUsername;
  String grandPriceDescription;

  String storeImageURL;
  String storeName;
  SectionName storeSection;
  DateTime wonDate;

  WonPriceSummary({
    required this.wonPriceSummaryId,
    required this.storeFK,
    required this.winnerImageURL,
    required this.winnerUsername,
    required this.grandPriceDescription,
    required this.storeImageURL,
    required this.storeName,
    required this.storeSection,
    required this.wonDate,
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map.addAll({
      'wonPriceSummaryId': wonPriceSummaryId,
      'storeFK': storeFK,
      'winnerImageURL': winnerImageURL,
      'winnerUsername': winnerUsername,
      'grandPriceDescription': grandPriceDescription,
      'storeImageURL': storeImageURL,
      'storeName': storeName,
      'storeSection': storeSection,
      'wonDate': wonDate,
    });
    return map;
  }

  factory WonPriceSummary.fromJson(dynamic json) => WonPriceSummary(
      wonPriceSummaryId: json['wonPriceSummaryId'],
      storeFK: json['storeFK'],
      winnerImageURL: json['winnerImageURL'],
      winnerUsername: json['winnerUsername'],
      grandPriceDescription: json['grandPriceDescription'],
      storeImageURL: json['storeImageURL'],
      storeName: json['storeName'],
      storeSection: json['storeSection'],
      wonDate: json['wonDate'],
      isFake: json['isFake'] == 'Yes' ? true : false);
}
