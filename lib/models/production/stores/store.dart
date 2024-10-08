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
      'storeName': storeName,
      'storeOwnerPhoneNumber': storeOwnerPhoneNumber,
      'storeImageURL': storeImageURL,
      'sectionName': sectionName,
      'lastWonPrice': lastWonPrice!.toJson(),
    });
    return map;
  }

  factory Store.fromJson(dynamic json) {
    return Store(
        storeOwnerPhoneNumber: json['storeOwnerPhoneNumber'],
        storeName: json['storeName'],
        storeImageURL: json['storeImageURL'],
        sectionName: json['sectionName'],
        lastWonPrice: WonPriceSummary.fromJson(json['lastWonPrice']),
        isFake: json['isFake'] == 'Yes' ? true : false);
  }

  @override
  String toString() {
    return 'Store Name: $storeName '
        'Section Name: $sectionName  ';
  }
}
