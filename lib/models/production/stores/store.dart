import 'package:alcoholic/models/production/stores/won_price_summary.dart';
import 'package:alcoholic/models/section_name.dart';
import '../Utilities/may_be_fake.dart';

// Collection Name /stores/storeId
class Store extends MayBeFake {
  String storeOwnerPhoneNumber;
  String storeName;
  String storeImageURL;
  SectionName sectionName;

  WonPriceSummary? lastWonPrice;

  Store({
    required this.storeOwnerPhoneNumber,
    required this.storeName,
    required this.storeImageURL,
    required this.sectionName,
    this.lastWonPrice,
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map.addAll({
      'Store Name': storeName,
      'Store Owner Phone Number': storeOwnerPhoneNumber,
      'Store Image URL': storeImageURL,
      'Section Name': sectionName,
      'Last Won Price Summary': lastWonPrice!.toJson(),
    });
    return map;
  }

  factory Store.fromJson(dynamic json) {
    return Store(
        storeOwnerPhoneNumber: json['Store Owner Phone Number'],
        storeName: json['Store Name'],
        storeImageURL: json['Store Image URL'],
        sectionName: json['Section Name'],
        lastWonPrice: WonPriceSummary.fromJson(json['Last Won PriceSummary']),
        isFake: json['Is Fake'] == 'Yes' ? true : false);
  }

  @override
  String toString() {
    return 'Store Name: $storeName '
        'Section Name: $sectionName  ';
  }
}
