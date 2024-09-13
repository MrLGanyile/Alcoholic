// Collection Name /stores/storeId/grand_prices_status/grandPriceStatusId
import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

class GrandPriceStatus extends MayBeFake {
  String grandPriceStatusId;
  String grandPriceDescription;
  String grandPriceImageURL;
  int noOfUsersWhoCouldHaveWonIt;

  GrandPriceStatus({
    required this.grandPriceStatusId,
    required this.grandPriceDescription,
    required this.grandPriceImageURL,
    required this.noOfUsersWhoCouldHaveWonIt,
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();

    map.addAll({
      'Grand Price Status Id': grandPriceStatusId,
      'Grand Price Description': grandPriceDescription,
      'grand Price Image URL': grandPriceImageURL,
      'No Of Users Who Could Have Won It': noOfUsersWhoCouldHaveWonIt,
    });
    return map;
  }

  GrandPriceStatus fromJson(dynamic json) {
    return GrandPriceStatus(
        grandPriceStatusId: grandPriceStatusId,
        grandPriceDescription: grandPriceDescription,
        grandPriceImageURL: grandPriceImageURL,
        noOfUsersWhoCouldHaveWonIt: noOfUsersWhoCouldHaveWonIt,
        isFake: json['Is Fake'] == 'Yes' ? true : false);
  }
}
