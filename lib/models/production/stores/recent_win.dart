// Collection Name /recent_wins/recentWinId
class RecentWin{

  String recentWinId;
  String wonPriceSummaryFK;
  String winnerImageURL;
  String grandPriceImageURL;


  RecentWin({
    required this.recentWinId,
    required this.wonPriceSummaryFK,
    required this.winnerImageURL,
    required this.grandPriceImageURL,
  });


  Map<String, dynamic> toJson()=>{
    'Recent Win Id': recentWinId,
    'Won Price Summary FK': wonPriceSummaryFK,
    'Winner Image URL': winnerImageURL,
    'Grand Price Image URL': grandPriceImageURL,
  };

  factory RecentWin.fromJson(Map<String, dynamic> json)=>RecentWin(
    recentWinId: json['Recent Win Id'], 
    wonPriceSummaryFK: json['Won Price Summary FK'], 
    winnerImageURL: json['Winner Image URL'], 
    grandPriceImageURL: json['Grand Price Image URL']
  );
}