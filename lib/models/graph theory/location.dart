import 'dart:math';

import 'section_name.dart';
import 'utilities.dart';

class Location{

  String? locationId;
  SectionName sectionName;
  String townshipOrSurbub;
  String? gpsLocation;

  Location({
    this.locationId,
    required this.sectionName,
    this.townshipOrSurbub = 'Umlazi',
    this.gpsLocation,
  });

  Map<String, dynamic> toJson(){
    generateStoreId();
    return {
      'Location Id': locationId,
      'Section Name': Utilities.asString(sectionName),
      'Towhship Or Surbub': townshipOrSurbub,
      'GPS Location': gpsLocation,
    };
  }

  factory Location.fromJson(dynamic json){
    return Location(
      locationId: json['Location Id'],
      sectionName: json['Section Name'],
      townshipOrSurbub: json['Township Or Surbub'],
      gpsLocation: json['GPS Location']
    );
  }

  void generateStoreId(){

    if(this.locationId==null){
      return;
    }

    String lettersAndNumbers = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

    String locationId = '';

    for(int i = 0; i < 20;i++){
      Random random = Random();
      locationId += lettersAndNumbers[random.nextInt(lettersAndNumbers.length)];
    }

    this.locationId = locationId;
    
  }
  
}