import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

// Collection Name /stores/storeId/store_draws/drawId/draw_grand_prices/drawGrandPriceId
class DrawGrandPrice extends MayBeFake {
  String grandPriceId;
  String storeDrawFK;
  String imageURL;
  String description;
  int grandPriceIndex;

  DrawGrandPrice({
    required this.grandPriceId,
    required this.storeDrawFK,
    required this.imageURL,
    required this.description,
    required this.grandPriceIndex,
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();

    map.addAll({
      'Grand Price Id': grandPriceId,
      'Store Draw FK': storeDrawFK,
      'Description': description,
      'Image URL': imageURL,
      'Grand Price Index': grandPriceIndex,
    });
    return map;
  }

  factory DrawGrandPrice.fromJson(dynamic json) {
    return DrawGrandPrice(
        grandPriceId: json['Grand Price Id'],
        storeDrawFK: json['Store Draw FK'],
        description: json['Description'],
        imageURL: json['Image URL'],
        grandPriceIndex: json['Grand Price Index'],
        isFake: json['Is Fake'] == 'Yes' ? true : false);
  }

  @override
  String toString() {
    return 'Description: $description Grand Price Id: $grandPriceId '
        'Image Location: $imageURL';
  }
}
