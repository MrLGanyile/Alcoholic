// Collection Name /won_prices_summaries/wonPriceSummaryId
class WonPriceSummary{

  String wonPriceSummaryId;
  String storeFK;
  String winnerImageURL;
  String winnerUsername;
  String grandPriceDescription;

  String storeImageURL;
  String storeName;
  String storeAddress;
  DateTime wonDate;
  bool isMale;

  WonPriceSummary({
    required this.wonPriceSummaryId,
    required this.storeFK,
    required this.winnerImageURL,
    required this.winnerUsername,
    required this.grandPriceDescription,
    required this.storeImageURL,
    required this.storeName,
    required this.storeAddress,
    required this.wonDate,
    required this.isMale,
  });

  Map<String, dynamic> toJson()=>{
    'Won Price Summary Id': wonPriceSummaryId,
    'Store FK': storeFK,
    'Winner Image URL': winnerImageURL,
    'Winner Username': winnerUsername,
    'Grand Price Description': grandPriceDescription,
    'Store Image URL': storeImageURL,
    'Store Name': storeName,
    'Store Address': storeAddress,
    'Won Date': wonDate,
    'Is Male': isMale,
  };

  factory WonPriceSummary.fromJson(dynamic json)=>WonPriceSummary(
    wonPriceSummaryId: json['Won Price Summary Id'], 
    storeFK: json['Store FK'],
    winnerImageURL: json['Winner Image URL'], 
    winnerUsername: json['Winner Username'], 
    grandPriceDescription: json['Grand Price Description'], 
    storeImageURL: json['Store Image URL'], 
    storeName: json['Store Name'], 
    storeAddress: json['Store Address'], 
    wonDate: json['Won Date'],
    isMale: json['Is Male']
  );

}