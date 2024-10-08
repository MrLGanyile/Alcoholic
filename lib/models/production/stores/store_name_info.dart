// Collection Name /stores_names_info
import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

import '../../section_name.dart';
import '../Utilities/converter.dart';
import 'store_current_state.dart';

// {Collection Name - /stores_names_info}
class StoreNameInfo extends MayBeFake implements Comparable<StoreNameInfo> {
  String storeNameInfoId; // Must be the same as the storeId for some store.
  String storeName;
  String storeImageURL;
  SectionName sectionName;
  bool isOpened;

  StoreNameInfo({
    required this.storeNameInfoId,
    required this.storeName,
    required this.storeImageURL,
    required this.sectionName,
    this.isOpened = false,
    isFake,
  }) : super(isFake: isFake);

  String findStoreCurrentState(StoreCurrentState storeState) {
    switch (storeState) {
      case StoreCurrentState.hasNoCompetition:
        return 'Has No Competition';
      case StoreCurrentState.hasUpcommingCompetition:
        return 'Has Upcomming Competition';
      case StoreCurrentState.hasPlayingCompetition:
        return 'Has Playing Competition';
      default:
        return 'Has Playing Competition';
    }
    ;
  }

  factory StoreNameInfo.fromJson(dynamic json) {
    return StoreNameInfo(
        storeNameInfoId: json['storeNameInfoId'],
        storeName: json['storeName'],
        storeImageURL: json['storeImageURL'],
        sectionName: Converter.toSectionName(json['sectionName']),
        isOpened: false,
        isFake: json['isFake'] == 'Yes' ? true : false);
  }

  @override
  String toString() {
    return 'Store Name $storeName';
  }

  @override
  int compareTo(StoreNameInfo other) {
    return storeName.compareTo(other.storeName);
  }
}
