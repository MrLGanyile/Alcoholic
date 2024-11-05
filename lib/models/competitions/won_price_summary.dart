import 'dart:math';

import '../Utilities/converter.dart';
import '../Utilities/may_be_fake.dart';

import '../section_name.dart';
import 'dart:developer' as debug;

// Collection Name /won_prices_summaries/wonPriceSummaryId
class WonPriceSummary extends MayBeFake {
  String wonPriceSummaryId; // Same as the storeDrawId & competitionId

  String storeFK;
  String storeImageURL;
  String storeName;
  SectionName storeSection;
  String storeArea;

  String wonGrandPriceImageURL;
  String groupCreatorPhoneNumber;
  String groupCreatorUsername;
  String groupCreatorImageURL;
  String groupName;
  SectionName groupSectionName;
  String groupSpecificLocation;
  List<String> groupMembers;

  String grandPriceDescription;

  DateTime wonDate;

  WonPriceSummary({
    required this.wonPriceSummaryId,
    required this.storeFK,
    required this.storeImageURL,
    required this.storeName,
    required this.storeSection,
    required this.storeArea,
    required this.groupCreatorPhoneNumber,
    required this.groupCreatorUsername,
    required this.groupCreatorImageURL,
    required this.groupName,
    required this.groupSectionName,
    required this.groupSpecificLocation,
    required this.groupMembers,
    required this.grandPriceDescription,
    required this.wonGrandPriceImageURL,
    required this.wonDate,
    isFake,
  }) : super(isFake: isFake);

  factory WonPriceSummary.fromJson(dynamic json) {
    debug.log(json['wonDate'].toString());
    return WonPriceSummary(
        wonPriceSummaryId: json['wonPriceSummaryId'],
        storeFK: json['storeFK'],
        storeImageURL: json['storeImageURL'],
        storeName: json['storeName'],
        storeSection: Converter.toSectionName(json['storeSection']),
        storeArea: json['storeArea'],
        groupCreatorPhoneNumber: json['groupCreatorPhoneNumber'],
        groupCreatorImageURL: json['groupCreatorImageURL'],
        groupCreatorUsername: json['groupCreatorUsername'],
        groupName: json['groupName'],
        groupSectionName: Converter.toSectionName(json['groupSectionName']),
        groupSpecificLocation: json['groupSpecificLocation'],
        groupMembers: getGroupMembers(json['groupMembers']),
        grandPriceDescription: json['grandPriceDescription'],
        wonGrandPriceImageURL: json['wonGrandPriceImageURL'],
        wonDate: DateTime(
          json['wonDate']['year'],
          json['wonDate']['month'],
          json['wonDate']['day'],
          json['wonDate']['hour'],
          json['wonDate']['minute'],
        ),
        isFake: json['isFake'] == 'Yes' ? true : false);
  }
}

List<String> getGroupMembers(List<dynamic> groupMembers) {
  List<String> members = [];

  for (int i = 0; i < groupMembers.length; i++) {
    members.add(groupMembers[i] as String);
  }

  return members;
}
