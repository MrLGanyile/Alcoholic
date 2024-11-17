import '../Utilities/converter.dart';
import 'package:alcoholic/models/section_name.dart';
import '../Utilities/may_be_fake.dart';

// Collection Name /stores/storeId
class Store extends MayBeFake {
  String storeOwnerPhoneNumber;
  String storeName;
  String storeImageURL;
  SectionName sectionName;
  String storeArea;

  Store({
    required this.storeOwnerPhoneNumber,
    required this.storeName,
    required this.storeImageURL,
    required this.sectionName,
    required this.storeArea,
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
      'storeArea': storeArea,
    });
    return map;
  }

  factory Store.fromJson(dynamic json) {
    return Store(
        storeOwnerPhoneNumber: json['storeOwnerPhoneNumber'],
        storeName: json['storeName'],
        storeImageURL: json['storeImageURL'],
        sectionName: Converter.toSectionName(json['sectionName']),
        storeArea: json['storeArea'],
        isFake: json['isFake'] == 'Yes' ? true : false);
  }

  @override
  String toString() {
    return 'Store Name: $storeName '
        'Section Name: $sectionName  ';
  }
}
