import 'may_be_fake.dart';

abstract class User extends MayBeFake {
  String phoneNumber;
  String profileImageURL;

  User({
    required this.phoneNumber,
    required this.profileImageURL,
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map.addAll({
      'Phone Number': phoneNumber,
      'Profile Image URL': profileImageURL,
    });
    return map;
  }
}
