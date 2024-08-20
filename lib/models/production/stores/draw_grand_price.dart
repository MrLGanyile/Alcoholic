import 'alcohol.dart';

// Collection Name /stores/storeId/store_draws/drawId/draw_grand_prices/drawGrandPriceId
class DrawGrandPrice{

  String grandPriceId;
  String storeDrawFK;
  String imageURL;
  String description;
  List<Alcohol> drinks;
  int grandPriceIndex;

  DrawGrandPrice({
    required this.grandPriceId,
    required this.storeDrawFK,
    required this.imageURL,
    required this.drinks,
    required this.description,
    required this.grandPriceIndex,
  });

  Map<String,dynamic> toJson(){
    return {
      'Grand Price Id': grandPriceId,
      'Store Draw FK': storeDrawFK,
      'Description': description,
      'Image URL': imageURL,
      'Drinks' : drinks,
      'Grand Price Index': grandPriceIndex,
    };
  }

  factory DrawGrandPrice.fromJson(dynamic json){
    return DrawGrandPrice(
      grandPriceId: json['Grand Price Id'],
      storeDrawFK: json['Store Draw FK'],
      description: json['Description'],
      imageURL: json['Image URL'], 
      drinks: json['Drinks'], 
      grandPriceIndex: json['Grand Price Index']
    );
  }

  @override
  String toString(){
    return 'Description: $description Grand Price Id: $grandPriceId '
    'Image Location: $imageURL Drinks: ${drinks[0]}';
  }
}