import 'package:alcoholic/models/Utilities/may_be_fake.dart';

import '../section_name.dart';

// All competitions should take the same amount of time to finish.
// Collection Name /competition/competitionId
class Competition extends MayBeFake {
  String? competitionId;
  String storeFK;
  String storeImageLocation;
  String storeName;
  SectionName storeSectionName;
  bool isLive;

  DateTime dateTime;
  double joiningFee;

  bool isOver;

  Competition({
    this.competitionId,
    required this.storeFK,
    required this.storeImageLocation,
    required this.storeName,
    required this.storeSectionName,
    this.isLive = false,
    required this.dateTime,
    required this.joiningFee,
    this.isOver = false,
    isFake,
  }) : super(isFake: isFake);

  factory Competition.fromJson(dynamic json) {
    return Competition(
        competitionId: json['competitionId'],
        storeFK: json['storeFK'],
        storeImageLocation: json['storeImageLocation'],
        storeName: json['storeName'],
        storeSectionName: json['storeSectionName'],
        isLive: json['isLive'],
        dateTime: json['dateTime'],
        joiningFee: json['joiningFee'],
        isOver: json['isOver'],
        isFake: json['isFake'] == 'Yes' ? true : false);
  }
}
