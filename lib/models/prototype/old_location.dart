
import 'old_store.dart';


class Location{
  String continent;
  String country;
  String provinceOrState;
  String cityOrVillage;
  String townshipOrSuburb;
  List<Store> stores;

  Location({
    this.continent = 'Africa',
    this.country = 'South Africa',
    this.provinceOrState = 'Kwa Zulu Natal',
    this.cityOrVillage = 'Durban',
    this.townshipOrSuburb = 'Umlazi',
    this.stores = const [],
  });

  Map<dynamic, String> toJson(){

    Map<String, dynamic> map = {};

    for(Store store in stores){
      map.addAll(store.toJson());
    }

    return {
      'Continent': continent,
      'Country': country,
      'Province/State': provinceOrState,
      'City/Village': cityOrVillage,
      'Township/Suburb': townshipOrSuburb,
      'Stores': map.toString(),
    };
  }

  factory Location.fromJson(dynamic json){
    
    return Location(
      continent: json['Continent'],
      country: json['Country'],
      provinceOrState: json['Province/State'],
      cityOrVillage: json['City/Village'],
      townshipOrSuburb: json['Township/Suburb'],
      stores: json['Stores'], // Change To A List.
    );
  }

}