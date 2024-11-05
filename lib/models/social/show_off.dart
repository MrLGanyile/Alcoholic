import 'package:alcoholic/models/Utilities/may_be_fake.dart';

abstract class ShowOff extends MayBeFake {
  String creatorId;
  String creatorUsername;
  String creatorImageURL;

  ShowOff({
    required this.creatorId,
    required this.creatorUsername,
    required this.creatorImageURL,
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();

    map.addAll({
      "Creator Id": creatorId,
      "Creator Username": creatorUsername,
      "Creator Image URL": creatorImageURL,
    });
    return map;
  }
}
