/* Collection Name /competition/competitionId
/grand_prices_grids/grandPriceGridId
/grand_prices_tokens*/

import 'package:alcoholic/models/Utilities/may_be_fake.dart';

// Competition & CompetitorGrid Have Similar IDs
import '../stores/draw_grand_price.dart';

class GrandPriceToken extends MayBeFake {
  String grandPriceTokenId;
  String grandPriceGridFK;
  int tokenIndex;
  bool isPointed;
  String imageURL;
  String description;

  GrandPriceToken({
    required this.grandPriceTokenId,
    required this.grandPriceGridFK,
    required this.tokenIndex,
    required this.isPointed,
    required this.imageURL,
    required this.description,
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map.addAll({
      'Grand Price Token Id': grandPriceTokenId,
      'Grand Price Grid FK': grandPriceGridFK,
      'Token Index': tokenIndex,
      'Is Pointed': isPointed,
      'Grand Price Image URL': imageURL,
      'Description': description,
    });
    return map;
  }

  factory GrandPriceToken.fromJson(dynamic json) {
    return GrandPriceToken(
        grandPriceTokenId: json['Grand Price Token Id'],
        grandPriceGridFK: json['Grand Price Grid FK'],
        tokenIndex: json['Token Index'],
        isPointed: json['Is Pointed'],
        imageURL: json['Grand Price Image URL'],
        description: json['Description'],
        isFake: json['Is Fake'] == 'Yes' ? true : false);
  }

  factory GrandPriceToken.fromDrawGrandPrice(DrawGrandPrice drawGrandPrice) {
    return GrandPriceToken(
        grandPriceTokenId: drawGrandPrice.grandPriceId,
        grandPriceGridFK: drawGrandPrice.storeDrawFK,
        tokenIndex: drawGrandPrice.grandPriceIndex,
        isPointed: false,
        imageURL: '',
        description: drawGrandPrice.description);
  }
}
