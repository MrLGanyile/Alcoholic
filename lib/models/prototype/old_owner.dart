import 'old_user.dart';

class Owner extends User{
  String fullName;
  String surname;
  String? imageLocation;
  var store;

  Owner({
    required username, 
    required cellNumber,
    required isMale,
    required sectionName,
    

    required this.fullName,
    required this.surname,
    required password,
    this.store,
    this.imageLocation,
  }):super(
      username:username, 
      password: password,
      cellNumber: cellNumber,
      isMale: isMale,
      sectionName: sectionName,
    );

  @override
  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = {
      'Full Name': fullName,
      'Surname': surname,
      'Store': store.toJson(),
      
    };
    map.addAll(retrievePortion());
    return map;
  }

  factory Owner.fromJson(dynamic json){
    return Owner(
      fullName: json['Full Name'], 
      surname: json['Surname'], 
      store: json['Store'],
      username: json['Username'],
      password: json['Password'],
      sectionName: json['Section Name'],
      cellNumber: json['Cell Number'],
      imageLocation: json['Image Location'],
      isMale: json['Gender']=='Male',
    );
  }

  @override 
  String toString(){
    return 'Fullname: $fullName Surname: $surname '
    'Username: $username Password: $password Section Name: '
    '$sectionName Cell Number: $cellNumber Image Location: '
    '$imageLocation isMale:$isMale';
  }

  @override
  bool isOnwer(){
    return true;
  }

  @override 
  String findImageLocation(){
    return imageLocation!;
  }
}