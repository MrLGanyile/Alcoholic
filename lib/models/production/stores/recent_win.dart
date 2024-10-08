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

  factory RecentWin.fromJson(Map<String, dynamic> json) => RecentWin(
      recentWinId: json['recentWinId'],
      wonPriceSummaryFK: json['wonPriceSummaryFK'],
      winnerImageURL: json['winnerImageURL'],
      winnerUsername: json['winnerUsername'],
      isFake: json['isFake'] == 'Yes' ? true : false);
}
