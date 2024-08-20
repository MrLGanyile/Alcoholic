
// Collection Name /stores/storeId/store_draws/storeDrawId
class StoreDraw{

  String storeDrawId;
  String storeFK;
  DateTime drawDateAndTime;
  double joiningFee;
  int numberOfCompetitorsSoFar;
  bool isOpen;
  int numberOfGrandPrices;
  String storeName;
  String storeAddress;
  String storeImageURL;

  // Contains A Sub Collection Of Draw Grand Prices
  // Contains A Sub Collection Of Draw Competitors
  

  StoreDraw({
    required this.storeDrawId,
    required this.storeFK,
    required this.drawDateAndTime,
    required this.joiningFee,
    required this.numberOfCompetitorsSoFar,
    this.isOpen = true,
    required this.numberOfGrandPrices,

    required this.storeName,
    required this.storeAddress,
    required this.storeImageURL
  });

  Map<String, dynamic> toJson()=>{
    'Store Draw Id': storeDrawId,
    'Store FK': storeFK,
    'Draw Date & Time': drawDateAndTime,
    'Joining Fee': joiningFee,
    'Number Of Grand Prices': numberOfGrandPrices,
    'Number of Competitors So Far': numberOfCompetitorsSoFar,
    'Is Open': isOpen,
    'Store Name': storeName,
    'Store Address': storeAddress,
    'Store Image URL': storeImageURL,
  };

  factory StoreDraw.fromJson(dynamic  json)=>StoreDraw(
    storeDrawId: json['Store Draw Id'], 
    storeFK: json['Store FK'], 
    drawDateAndTime: json['Draw Date & Time'], 
    joiningFee: json['Joining Fee'], 
    numberOfGrandPrices: json['Number Of Grand Prices'],
    numberOfCompetitorsSoFar: json['Number of Competitors So Far'],
    isOpen: json['Is Open'],
    storeName: json['Store Name'],
    storeAddress: json['Store Address'],
    storeImageURL: json['Store Image URL'],
  );
}