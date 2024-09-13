// Collection Name /stores/storeId/store_draws/drawId/draw_competitors/drawCompetitorId

import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

class DrawCompetitor extends MayBeFake {
  String competitorId; // Not A User Id
  String imageURL;
  String storeDrawFK;
  String username;
  int competitorNumber;
  String alcoholic3DigitToken;

  DrawCompetitor({
    required this.competitorId,
    required this.imageURL,
    required this.username,
    required this.competitorNumber,
    required this.storeDrawFK,
    required this.alcoholic3DigitToken,
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();

    map.addAll({
      'Competitor Id': competitorId,
      'Image URL': imageURL,
      'Store Draw FK': storeDrawFK,
      'Username': username,
      'Competitor Number': competitorNumber,
      'Alcoholic 3 Digit Token': alcoholic3DigitToken,
    });
    return map;
  }

  factory DrawCompetitor.fromJson(dynamic json) {
    DrawCompetitor competitor = DrawCompetitor(
        imageURL: json['Image URL'],
        username: json['Username'],
        competitorId: json['Competitor Id'],
        storeDrawFK: json['Store Draw FK'],
        competitorNumber: json['Competitor Number'],
        alcoholic3DigitToken: json['Alcoholic 3 Digit Token'],
        isFake: json['Is Fake'] == 'Yes' ? true : false);

    return competitor;
  }
}
