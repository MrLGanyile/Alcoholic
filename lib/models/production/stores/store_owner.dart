
// Collection Name /store_owners/storeOwnerId
class StoreOwner{

  String storeOwnerId;
  String fullname;
  String surname;
  String phoneNumber;
  String identityDocumentImageURL;
  String profileImageURL;

  StoreOwner({
    required this.storeOwnerId,
    required this.fullname,
    required this.surname,
    required this.phoneNumber,
    required this.identityDocumentImageURL,
    required this.profileImageURL,

  });

  Map<String,dynamic> toJson(){
    return {
      'Store Owner Id': storeOwnerId,
      'Full Name': fullname,
      'Surname': surname,
      'Phone Number': phoneNumber,
      'Identity Document Image URL':identityDocumentImageURL,
      'Profile Image URL': profileImageURL,
      
    };
  }

  factory StoreOwner.fromJson(dynamic json)=>StoreOwner(
    storeOwnerId: json['Store Owner Id'], 
    fullname: json['Full Name'], 
    surname: json['Surname'], 
    phoneNumber: json['Phone Number'], 
    identityDocumentImageURL: json['Identity Document Image URL'], 
    profileImageURL: json['Profile Image URL'], 
  );
}