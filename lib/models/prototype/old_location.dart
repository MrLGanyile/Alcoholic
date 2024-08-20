import '../graph theory/section_name.dart';
import '../graph theory/utilities.dart';
import 'old_store.dart';


class Location{
  String continent;
  String country;
  String provinceOrState;
  String cityOrVillage;
  String townshipOrSuburb;
  SectionName section;
  List<Store> stores;

  Location({
    this.continent = 'Africa',
    this.country = 'South Africa',
    this.provinceOrState = 'Kwa Zulu Natal',
    this.cityOrVillage = 'Durban',
    this.townshipOrSuburb = 'Umlazi',
    required this.section,
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
      'Section/Area': Utilities.asString(section), 
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
      section: json['Section/Area'],
      stores: json['Stores'], // Change To A List.
    );
  }

}