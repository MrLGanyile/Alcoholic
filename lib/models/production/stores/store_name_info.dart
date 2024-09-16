// Collection Name /stores_names_info
import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

import '../../section_name.dart';
import 'store_state.dart';

// {Collection Name - /stores_names_info}
class StoreNameInfo extends MayBeFake {
  String storeNameInfoId; // Must be the same as the storeId for some store.
  String storeName;
  String storeImageURL;
  SectionName sectionName;
  bool isOpened;
  StoreState storeState; // Will be usefull later.

  // Contains A Sub Collection Of /store_members

  StoreNameInfo({
    required this.storeNameInfoId,
    required this.storeName,
    required this.storeImageURL,
    required this.sectionName,
    this.isOpened = false,
    this.storeState = StoreState.hasNoCompetition,
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map.addAll({
      'Store Name Info Id': storeNameInfoId,
      'Store Name': storeName,
      'Store Image URL': storeImageURL,
      'Section Name': sectionName,
      'Is Opened': isOpened,
      'Store State': findStoreState(storeState),
    });
    return map;
  }

  String findStoreState(StoreState storeState) {
    switch (storeState) {
      case StoreState.hasNoCompetition:
        return 'Has No Competition';
      case StoreState.hasUpcommingCompetition:
        return 'Has Upcomming Competition';
      case StoreState.hasPlayingCompetition:
        return 'Has Playing Competition';
      default:
        return 'Has Playing Competition';
    }
    ;
  }

  factory StoreNameInfo.fromJson(dynamic json) {
    return StoreNameInfo(
        storeNameInfoId: json['Store Name Info Id'],
        storeName: json['Store Name'],
        storeImageURL: json['Store Image URL'],
        sectionName: json['Section Name'],
        isOpened: json['Is Opened'],
        storeState: json['Store State'],
        isFake: json['Is Fake'] == 'Yes' ? true : false);
  }
}
