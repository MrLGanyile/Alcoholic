import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

import '../../section_name.dart';

// Collection Name /stores/storeId/customers/customerId
class Customer extends MayBeFake {
  String customerId;
  String storeFK;
  String imageURL;
  String user3DigitToken;
  SectionName sectionName;

  Customer({
    required this.customerId,
    required this.storeFK,
    required this.imageURL,
    required this.user3DigitToken,
    required this.sectionName,
    isFake,
  }) : super(
          isFake: isFake,
        );

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();

    map.addAll({
      "Customer Id": customerId,
      'Store FK': storeFK,
      "Image URL": imageURL,
      "User 3 Digit Token": user3DigitToken,
      "Section Name": sectionName,
    });

    return map;
  }

  Customer fromJson(dynamic json) {
    return Customer(
        customerId: json["Customer Id"],
        storeFK: json['Store FK'],
        imageURL: json["Image URL"],
        user3DigitToken: json["User 3 Digit Token"],
        sectionName: json["Section Name"],
        isFake: json['Is Fake'] == 'Yes' ? true : false);
  }
}
