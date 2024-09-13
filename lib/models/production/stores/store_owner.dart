// Collection Name /store_owners/storeOwnerId
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Utilities/user.dart';

class StoreOwner extends User {
  String fullname;
  String surname;
  String identityDocumentImageURL;
  bool? isAdmin;

  StoreOwner({
    required phoneNumber,
    required profileImageURL,
    required this.fullname,
    required this.surname,
    required this.identityDocumentImageURL,
    this.isAdmin = false,
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
      'Full Name': fullname,
      'Surname': surname,
      'Identity Document Image URL': identityDocumentImageURL,
      'Is Admin': isAdmin,
    });
    return map;
  }

  factory StoreOwner.fromJson(dynamic json) => StoreOwner(
      fullname: json['Full Name'],
      surname: json['Surname'],
      phoneNumber: json['Phone Number'],
      identityDocumentImageURL: json['Identity Document Image URL'],
      profileImageURL: json['Profile Image URL'],
      isAdmin: json['Is Admin'],
      isFake: json['Is Fake'] == 'Yes' ? true : false);

  static StoreOwner fromSnapshot(DocumentSnapshot documentSnapshot) {
    var json = documentSnapshot.data() as Map<String, dynamic>;

    return StoreOwner(
        fullname: json['Full Name'],
        surname: json['Surname'],
        phoneNumber: json['Phone Number'],
        identityDocumentImageURL: json['Identity Document Image URL'],
        profileImageURL: json['Profile Image URL'],
        isAdmin: json['Is Admin'],
        isFake: json['Is Fake'] == 'Yes' ? true : false);
  }
}
