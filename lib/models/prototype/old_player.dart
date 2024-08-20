import 'old_user.dart';

class Player extends User{
  late String picPath;
  late String picName;

  Player({
    required cellNumber,
    required username,
    required password,
    required sectionName,
    required isMale,
    this.picPath = '',
    this.picName = '',
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
      'Pic Path': picPath,
      'Pic Name': picName,
      
    };
    map.addAll(retrievePortion());
    return map;
  }

  @override
  factory Player.fromJson(dynamic json){
    return Player(
      picPath: json['Pic Path'], 
      picName: json['Pic Name'], 
      username: json['Username'],
      password: json['Password'],
      sectionName: json['Section Name'],
      cellNumber: json['Cell Number'],
      isMale: json['Gender']=='Male',
    );
  }

  @override
  String toString(){
    return 'Username: $username Password: $password SectionName: $sectionName picName: $picName PicPath: $picPath CellNumber: $cellNumber \n';
  }

  @override 
  String findImageLocation(){
    return picPath + picName;
  }

  @override
  bool isOnwer(){
    return false;
  }
}