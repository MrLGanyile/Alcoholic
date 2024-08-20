import 'dart:math';

import 'alcohol.dart';

class GrandPrice extends Comparable<GrandPrice>{

  String? imageLocation;
  String description;
  List<Alcohol> drinks;
  bool isPointed;
  String? grandPriceId;

  GrandPrice({
    required this.isPointed,
    this.imageLocation,
    required this.drinks,
    required this.description,
    this.grandPriceId,
  }){
    generateGrandPriceId();
  }

  Map<String,dynamic> toJson(){
    generateGrandPriceId();
    return {
      'Description': description,
      'Price': findApproximatePrice(),
      'Image Location': findImageLocation(),
      'Drinks' : drinks,
      'Is Pointed': isPointed,
      'Grand Price Id': grandPriceId,
    };
  }

  @override
  String toString(){
    return 'Description: $description Grand Price Id: $grandPriceId '
    'Image Location: $imageLocation Price: ${findApproximatePrice()} '
    'Is Pointed: $isPointed Drinks: ${drinks[0]}';
  }


  factory GrandPrice.fromJson(dynamic json){
    return GrandPrice(
      isPointed: json['Is Pointed'],
      imageLocation: json['Image Location'], 
      drinks: json['Drinks'], 
      description: json['Description'],
      grandPriceId: json['Grand Price Id'],
    );
  }

  void generateGrandPriceId(){

    String lettersAndNumbers = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

    String grandPriceId = '';

    for(int i = 0; i < 20;i++){
      Random random = Random();
      grandPriceId += lettersAndNumbers[random.nextInt(lettersAndNumbers.length)];
    }

    this.grandPriceId = grandPriceId;
  }

  bool contains(String alcoholName){
    for(Alcohol alcohol in drinks){
      if(alcohol.fullname.toLowerCase().contains(alcoholName.toLowerCase())){
        return true;
      }
    }
    return false;
  }

  String findImageLocation(){
    return imageLocation!=null?imageLocation!:drinks[0].imageLocation;
  }

  void addAlcohol(Alcohol alcohol){
    drinks.add(alcohol);
  }

  void removeAlcohol(int index){
    drinks.removeAt(index);
  }

  double findApproximatePrice(){

    double price = 0;
    for(Alcohol alcohol in drinks){
      price += 1;
    }
    return price;
  }

  bool equals(GrandPrice grandPrice){

    if(drinks.length != grandPrice.drinks.length){
      return false;
    }
    for(int index = 0; index <drinks.length;index++){
      if(drinks[index].compareTo(grandPrice.drinks[index]) != 0){
        return false;
      }
    }
    return true;
  }
  
  @override
  int compareTo(GrandPrice other) {
    return findApproximatePrice().compareTo(other.findApproximatePrice());
  }



}