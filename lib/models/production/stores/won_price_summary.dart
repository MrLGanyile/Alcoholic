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
      'Won Price Summary Id': wonPriceSummaryId,
      'Store FK': storeFK,
      'Winner Image URL': winnerImageURL,
      'Winner Username': winnerUsername,
      'Grand Price Description': grandPriceDescription,
      'Store Image URL': storeImageURL,
      'Store Name': storeName,
      'Store Section': storeSection,
      'Won Date': wonDate,
    });
    return map;
  }

  factory WonPriceSummary.fromJson(dynamic json) => WonPriceSummary(
      wonPriceSummaryId: json['Won Price Summary Id'],
      storeFK: json['Store FK'],
      winnerImageURL: json['Winner Image URL'],
      winnerUsername: json['Winner Username'],
      grandPriceDescription: json['Grand Price Description'],
      storeImageURL: json['Store Image URL'],
      storeName: json['Store Name'],
      storeSection: json['Store Section'],
      wonDate: json['Won Date'],
      isFake: json['Is Fake'] == 'Yes' ? true : false);
}
