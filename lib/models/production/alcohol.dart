import 'global.dart';

// Collection Name /stores/storeId/store_alcohol/alcoholId
class Alcohol implements Comparable<Alcohol>{

  String alcoholId;
  String storeFK;
  String fullname;
  String volume;
  String alcoholPercent;
  String imageLocation;
  AlcoholType alcoholType;
  String? drawGrandPriceFK;


  Alcohol({
    required this.alcoholId,
    required this.storeFK,
    required this.fullname,
    required this.volume,
    required this.alcoholPercent,
    required this.imageLocation,
    required this.alcoholType,
    this.drawGrandPriceFK,
  });

  Map<String,dynamic> toJson(){
    return {
      'Alcohol Id': alcoholId,
      'Store FK': storeFK,
      'Full Name': fullname,
      'Volume': volume,
      'Alcohol Percent': alcoholPercent,
      'Image Location': imageLocation,
      'Type': alcoholType,
      'Draw Grand Price FK': drawGrandPriceFK,
    };
  }

  factory Alcohol.fromJson(dynamic json){
    
    return Alcohol(
      alcoholId: json['Alcohol Id'],
      storeFK: json['Store FK'],
      fullname: json['Full Name'], 
      volume: json['Volume'], 
      alcoholPercent: json['Alcohol Percent'],
      imageLocation: json['Image Location'],
      alcoholType: json['Type'],
      drawGrandPriceFK: json['Draw Grand Price FK']
    );
  }

  @override 
  String toString(){
    return 'Alcohol Type: $alcoholType Name: $fullname '
    'Volume: $volume Id: $alcoholId Percent: $alcoholPercent '
    'Image Location: $imageLocation';
  }
  
  @override
  int compareTo(Alcohol other) {
    return fullname.compareTo(other.fullname);
  }
}