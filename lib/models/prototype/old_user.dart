import 'dart:math';

import '../section_name.dart';
import 'old_store.dart';

abstract class User{

  String username;
  String password;
  String cellNumber;
  String? userId;
  bool isMale;
  SectionName sectionName;

  List<Store> joinedStores;


  User({

    required this.username,
    required this.password,
    required this.cellNumber,
    required this.isMale,
    required this.sectionName,
    
    this.joinedStores = const[],
  }){
    generateUserId();
  }

  Map<String,dynamic> toJson();

  Map<String,dynamic> retrievePortion(){
    return {
      'User Id': userId,
      'Username': username,
      'Password': password,
      'Cell Number': cellNumber,
      'Section Name': sectionName,
      'Gender': isMale?'Male':'Female',
      'Joined Stores':joinedStores,
      'Image Location': findImageLocation(),
    };
  }

  void generateUserId(){

    if(this.userId != null){
      return;
    }

    String lettersAndNumbers = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

    String userId = '';

    for(int i = 0; i < 10;i++){
      Random random = Random();
      userId += lettersAndNumbers[random.nextInt(lettersAndNumbers.length)];
    }

    this.userId = userId;
    
  }


  String findImageLocation();
  bool isOnwer();

}