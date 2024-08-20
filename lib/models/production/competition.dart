import 'competitors_grid.dart';
import 'grand_prices_grid.dart';
import '../section_name.dart';

// Collection Name /competition/competitionId
class Competition{

  String? competitionId;
  String storeFK;
  String storeImageLocation;
  String storeName;
  SectionName storeSectionName;
  bool isLive;
  
  DateTime dateTime;
  double joiningFee;

  bool isOver;

  GrandPricesGrid grandPricesGrid;
  CompetitorsGrid competitorsGrid;

  Competition({
    this.competitionId,
    required this.storeFK,
    required this.storeImageLocation,
    required this.storeName,
    required this.storeSectionName,
    this.isLive = false,
    required this.grandPricesGrid,
    required this.competitorsGrid,
    required this.dateTime,
    required this.joiningFee,
    this.isOver = false,
  });

  Map<String, dynamic> toJson(){
    
    return {
      'Competition Id': competitionId,
      'Store FK': storeFK,
      'Store Image Location': storeImageLocation,
      'Store Name': storeName,
      'Store Section Name': storeSectionName,
      'Is Live': isLive,
      'Date Time': dateTime,
      'Joining Fee': joiningFee,
      'Is Over': isOver,
      'Grand Prices Grid': grandPricesGrid.toJson(),
      'Competitors Grid': competitorsGrid.toJson(),
    };
  }

  factory Competition.fromJson(dynamic json){
    return Competition(
      competitionId: json['Competition Id'], 
      storeFK: json['Store FK'],
      storeImageLocation: json['Store Image Location'], 
      storeName: json['Store Name'], 
      storeSectionName: json['Store Section Name'], 
      grandPricesGrid: GrandPricesGrid.fromJson(json['Grand Prices Grid']),
      competitorsGrid: CompetitorsGrid.fromJson(json['Competitors Grid']),
      isLive: json['Is Live'],
      dateTime: json['Date Time'],
      joiningFee: json['Joining Fee'],
      isOver: json['Is Over'],
    );
  }
}