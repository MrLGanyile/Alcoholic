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
      'fullname': fullname,
      'surname': surname,
      'identityDocumentImageURL': identityDocumentImageURL,
      'isAdmin': isAdmin,
    });
    return map;
  }

  factory StoreOwner.fromJson(dynamic json) => StoreOwner(
      fullname: json['fullname'],
      surname: json['surname'],
      phoneNumber: json['phoneNumber'],
      identityDocumentImageURL: json['identityDocumentImageURL'],
      profileImageURL: json['profileImageURL'],
      isAdmin: json['isAdmin'],
      isFake: json['isFake'] == 'Yes' ? true : false);

  static StoreOwner fromSnapshot(DocumentSnapshot documentSnapshot) {
    var json = documentSnapshot.data() as Map<String, dynamic>;

    return StoreOwner(
        fullname: json['fullname'],
        surname: json['surname'],
        phoneNumber: json['phoneNumber'],
        identityDocumentImageURL: json['identityDocumentImageURL'],
        profileImageURL: json['profileImageURL'],
        isAdmin: json['isAdmin'],
        isFake: json['isFake'] == 'Yes' ? true : false);
  }
}
