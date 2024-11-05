// Collection Name /stores/storeId/grand_prices_status/grandPriceStatusId
import 'package:alcoholic/models/Utilities/may_be_fake.dart';

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

  GrandPriceStatus fromJson(dynamic json) {
    return GrandPriceStatus(
        grandPriceStatusId: json['grandPriceStatusId'],
        grandPriceDescription: json['grandPriceDescription'],
        grandPriceImageURL: json['grandPriceImageURL'],
        noOfUsersWhoCouldHaveWonIt: json['noOfUsersWhoCouldHaveWonIt'],
        isFake: json['isFake'] == 'Yes' ? true : false);
  }
}
