// Collection Name /alcoholics/{alcoholicId}
import 'package:alcoholic/models/Utilities/converter.dart';

import '../section_name.dart';
import 'user.dart';

// Usecase Name - Create Alcoholic Account
// Collection Name /alcoholics/alcoholicId
class Alcoholic extends User {
  SectionName sectionName;
  String username;

  Alcoholic({
    required phoneNumber,
    required profileImageURL,
    required this.sectionName,
    required this.username,
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
      'sectionName': Converter.asString(sectionName),
      'username': username,
    });

    return map;
  }

  factory Alcoholic.fromJson(dynamic json) => Alcoholic(
      profileImageURL: json['profileImageURL'],
      phoneNumber: json['phoneNumber'],
      sectionName: Converter.toSectionName(json['sectionName']),
      username: json['username'],
      isFake: json['isFake'] == 'Yes' ? true : false);
}
