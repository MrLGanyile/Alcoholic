import 'package:alcoholic/models/Utilities/converter.dart';
import 'package:alcoholic/models/Utilities/may_be_fake.dart';

import '../section_name.dart';

// All competitions should take the same amount of time to finish.
// Collection Name /competition/competitionId
class Competition extends MayBeFake {
  String? competitionId;
  String storeFK;
  int? grandPricePickingDuration;
  bool isLive;
  bool isOver;
  double joiningFee;
  int numberOfGrandPrices;

  SectionName competitionSectionName;

  DateTime dateTime;

  int? groupPickingDuration;

  Competition({
    this.competitionId,
    required this.storeFK,
    required this.competitionSectionName,
    this.isLive = false,
    required this.dateTime,
    required this.joiningFee,
    this.isOver = false,
    this.grandPricePickingDuration,
    this.groupPickingDuration,
    required this.numberOfGrandPrices,
    isFake,
  }) : super(isFake: isFake);

  factory Competition.fromJson(dynamic json) {
    return Competition(
      competitionId: json['competitionId'],
      storeFK: json['storeFK'],
      competitionSectionName:
          Converter.toSectionName(json['competitionSectionName']),
      isLive: json['isLive'],
      dateTime: DateTime(
        json['dateTime']['year'],
        json['dateTime']['month'],
        json['dateTime']['day'],
        json['dateTime']['hour'],
        json['dateTime']['minute'],
      ),
      joiningFee: json['joiningFee'],
      isOver: json['isOver'],
      isFake: json['isFake'] == 'Yes' ? true : false,
      grandPricePickingDuration: json['grandPricePickingDuration'],
      groupPickingDuration: json['groupPickingDuration'],
      numberOfGrandPrices: json["numberOfGrandPrices"],
    );
  }
}
