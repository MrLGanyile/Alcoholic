import 'package:alcoholic/models/Utilities/may_be_fake.dart';

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
      'grandPriceId': grandPriceId,
      'toreDrawFK': storeDrawFK,
      'description': description,
      'imageURL': imageURL,
      'grandPriceIndex': grandPriceIndex,
      'isFake': "No",
    });
    return map;
  }

  factory DrawGrandPrice.fromJson(dynamic json) {
    return DrawGrandPrice(
        grandPriceId: json['grandPriceId'],
        storeDrawFK: json['storeDrawFK'],
        description: json['description'],
        imageURL: json['imageURL'],
        grandPriceIndex: json['grandPriceIndex'],
        isFake: json['isFake'] == 'Yes' ? true : false);
  }

  @override
  String toString() {
    return 'Description: $description Grand Price Id: $grandPriceId '
        'Image Location: $imageURL';
  }
}
