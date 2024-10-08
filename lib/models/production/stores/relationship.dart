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

  factory Relationship.fromJson(Map<String, dynamic> json) {
    Relationship storeMember = Relationship(
        userFK: json['UuserFK'],
        user3DigitToken: json['user3DigitToken'],
        joinedStoresFKs: json['joinedStoresFKs'],
        isFake: json['isFake'] == 'Yes' ? true : false);

    return storeMember;
  }
}
