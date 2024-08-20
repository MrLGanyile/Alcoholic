import 'package:alcoholic/models/production/stores/won_price_summary.dart';
import 'package:alcoholic/models/section_name.dart';

import 'store_state.dart';

// Collection Name /stores/storeId
class Store{

  String storeId;
  String storeOwnerFK;
  String storeName;
  String imageURL;
  SectionName sectionName;
  StoreState storeState;
  WonPriceSummary? lastWonPrice;


  Store({
    required this.storeId,
    required this.storeOwnerFK,
    required this.storeName,
    required this.imageURL,
    required this.sectionName,
    this.storeState = StoreState.hasNoCompetition,
    this.lastWonPrice,
  });

    Map<String,dynamic> toJson(){
    return {
      'Store Name': storeName,
      'Store Owner FK': storeOwnerFK,
      'Store Image URL': imageURL,
      'Section Name': sectionName,
      'Store Id': storeId,
      'Store State': storeState,
      'Last Won Price Summary': lastWonPrice!.toJson(),
    };
  }

  factory Store.fromJson(dynamic json){
    return Store(
      storeId: json['Store Id'],
      storeOwnerFK: json['Store Owner FK'],
      storeName: json['Store Name'], 
      imageURL: json['Store Image URL'], 
      sectionName: json['Section Name'],
      storeState: json['Store State'],
      lastWonPrice: WonPriceSummary.fromJson(json['Last Won PriceSummary']),
    );
  }


  @override 
  String toString(){
    
    return 'Store Name: $storeName '
    'Section Name: $sectionName  '
    'Store Id: $storeId ';
  }
}