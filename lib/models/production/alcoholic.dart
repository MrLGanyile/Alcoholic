// Collection Name /alcoholics/{alcoholicId}
class Alcoholic{
  String alcoholicId;
  String profileImageURL;
  String phoneNumber;
  String password;


  Alcoholic({
    required this.alcoholicId,
    required this.profileImageURL,
    required this.phoneNumber,
    required this.password,
  });

  Map<String,dynamic> toJson(){
    return {
      'Alcoholic Id': alcoholicId,
      'Profile Image URL': profileImageURL,
      'Password': password,
      'Phone Number': phoneNumber
    };
  }

  factory Alcoholic.fromJson(dynamic json)=>Alcoholic(
    alcoholicId: json['Alcoholic Id'], 
    profileImageURL: json['Profile Image URL'], 
    password: json['Password'], 
    phoneNumber: json['Phone Number'], 
  );
}