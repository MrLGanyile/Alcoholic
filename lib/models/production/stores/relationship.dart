// Collection Name /relationships/user3DigitToken
import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

class Relationship extends MayBeFake {
  String user3DigitToken;
  String userFK;
  List<String> joinedStoresFKs;

  Relationship({
    required this.userFK,
    required this.user3DigitToken,
    this.joinedStoresFKs = const [],
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map.addAll({
      'User FK': userFK,
      'User 3 Digit Token': user3DigitToken,
      'Joined Stores FKs': joinedStoresFKs,
    });
    return map;
  }

  factory Relationship.fromJson(Map<String, dynamic> json) {
    Relationship storeMember = Relationship(
        userFK: json['User FK'],
        user3DigitToken: json['User 3 Digit Token'],
        joinedStoresFKs: json['Joined Stores FKs'],
        isFake: json['Is Fake'] == 'Yes' ? true : false);

    return storeMember;
  }
}
