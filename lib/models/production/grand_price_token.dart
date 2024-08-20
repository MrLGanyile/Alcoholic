/* Collection Name /competition/competitionId
/grand_prices_grids/grandPriceGridId
/grand_prices_tokens*/
import 'stores/draw_grand_price.dart';

class GrandPriceToken{

  String grandPriceTokenId;
  int tokenIndex;
  bool isPointed;
  String imageURL;
  String description;

GrandPriceToken({
    required this.grandPriceTokenId,
    required this.tokenIndex,
    required this.isPointed,
    required this.imageURL,
    required this.description,
  });

  Map<String, dynamic> toJson(){
    return {
      'Grand Price Token Id': grandPriceTokenId,
      'Token Index': tokenIndex,
      'Is Pointed': isPointed,
      'Grand Price Image URL': imageURL,
      'Description': description,
    };
  }

  factory GrandPriceToken.fromJson(dynamic json){
    return GrandPriceToken(
      grandPriceTokenId: json['Grand Price Token Id'],
      tokenIndex: json['Token Index'],
      isPointed: json['Is Pointed'],
      imageURL: json['Grand Price Image URL'],
      description: json['Description'],
    );
  }

  factory GrandPriceToken.fromDrawGrandPrice(DrawGrandPrice drawGrandPrice){
    
    return GrandPriceToken(
      grandPriceTokenId: drawGrandPrice.grandPriceId, 
      tokenIndex: drawGrandPrice.grandPriceIndex, 
      isPointed: false, 
      imageURL: drawGrandPrice.drinks.length==1?
      drawGrandPrice.drinks[0].imageLocation:
      'an image on assets representing more than one alcohol for a single grand price.',
      description: drawGrandPrice.description
    );
  }

}

