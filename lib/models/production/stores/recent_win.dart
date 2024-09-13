// Collection Name /recent_wins/recentWinId
import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

class RecentWin extends MayBeFake {
  String recentWinId;
  String wonPriceSummaryFK;
  String winnerImageURL;
  String winnerUsername;

  RecentWin({
    required this.recentWinId,
    required this.wonPriceSummaryFK,
    required this.winnerImageURL,
    required this.winnerUsername,
    isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();

    map.addAll({
      'Recent Win Id': recentWinId,
      'Won Price Summary FK': wonPriceSummaryFK,
      'Winner Image URL': winnerImageURL,
      'Winner Username': winnerUsername,
    });
    return map;
  }

  factory RecentWin.fromJson(Map<String, dynamic> json) => RecentWin(
      recentWinId: json['Recent Win Id'],
      wonPriceSummaryFK: json['Won Price Summary FK'],
      winnerImageURL: json['Winner Image URL'],
      winnerUsername: json['Winner Username'],
      isFake: json['Is Fake'] == 'Yes' ? true : false);
}
