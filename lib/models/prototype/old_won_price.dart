import 'dart:math';

import 'old_competition.dart';
import 'old_grand_price.dart';
import 'old_store.dart';

class WonPrice{
  Competition competition;
  Store store;
  GrandPrice grandPrice;
  
  
  String? wonPriceId;

  WonPrice({
    required this.grandPrice,
    required this.store,
    required this.competition,
    
    this.wonPriceId,
  }){
    generateWonPriceId();
  }

  Map<String,dynamic> toJson(){
    return {
      'Grand Price': grandPrice.toJson(),
      'Store': store.toJson(),
      'Competition': competition.toJson(),
      'Won Price Id': wonPriceId!,

    };
  }

  factory WonPrice.fromJson(dynamic json){
    return WonPrice(
      grandPrice: json['Grand Price'], 
      store: json['Store'], 
      competition: json['Competition'], 
      wonPriceId: json['Won Price Id']
    );
  }

  @override 
  String toString(){
    return 'Won Price Id: $wonPriceId Store: [$store] Competition: [$competition] Grand Price: [$grandPrice] ';
  }

  void generateWonPriceId(){

    if(this.wonPriceId != null){
      return;
    }

    String lettersAndNumbers = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

    String wonPriceId = '';

    for(int i = 0; i < 10;i++){
      Random random = Random();
      wonPriceId += lettersAndNumbers[random.nextInt(lettersAndNumbers.length)];
    }

    this.wonPriceId = wonPriceId;
    
  }

  
}