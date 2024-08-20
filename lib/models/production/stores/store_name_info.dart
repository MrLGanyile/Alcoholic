
// Collection Name /stores_names_info
import '../../section_name.dart';

class StoreNameInfo{
  String storeNameInfoId; // Must be the same as the storeId for some store.
  String storeFK;
  String storeName;
  String storeAddress;
  String storeImageURL;
  SectionName sectionName;
  bool isOpened;

  StoreNameInfo({
    required this.storeNameInfoId,
    required this.storeFK,
    required this.storeName,
    required this.storeAddress,
    required this.storeImageURL,
    required this.sectionName,
    this.isOpened = false,
  });

  Map<String, dynamic> toJson(){
    return {
      'Store Name Info Id': storeNameInfoId,
      'Store FK': storeFK,
      'Store Name': storeName,
      'Store Address': storeAddress,
      'Store Image URL': storeImageURL,
      'Section Name': sectionName,
      'Is Opened': isOpened,
    };
  }

  factory StoreNameInfo.fromJson(dynamic json){
    return StoreNameInfo(
      storeNameInfoId: json['Store Name Info Id'], 
      storeFK: json['Store FK'],
      storeName: json['Store Name'],
      storeAddress: json['Store Address'],
      storeImageURL: json['Store Image URL'],
      sectionName: json['Section Name'],
      isOpened: json['Is Opened'],
    );
  }

}

