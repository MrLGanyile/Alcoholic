// Collection Name /alcoholics/{alcoholicId}
import 'package:alcoholic/models/production/Utilities/converter.dart';

import '../../section_name.dart';
import 'user.dart';

// Usecase Name - Create Alcoholic Account
// Collection Name /alcoholics/alcoholicId
class Alcoholic extends User {
  SectionName sectionName;

  Alcoholic({
    required phoneNumber,
    required profileImageURL,
    required this.sectionName,
    isFake,
  }) : super(
          phoneNumber: phoneNumber,
          profileImageURL: profileImageURL,
          isFake: isFake,
        );

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();

    map.addAll({
      'Section Name': Converter.asString(sectionName),
    });

    return map;
  }

  factory Alcoholic.fromJson(dynamic json) => Alcoholic(
      profileImageURL: json['Profile Image URL'],
      phoneNumber: json['Phone Number'],
      sectionName: Converter.toSectionName(json['Section Name']),
      isFake: json['Is Fake'] == 'Yes' ? true : false);
}
