// Collection Name /stores/storeId/store_draws/drawId/draw_competitors/drawCompetitorId
import 'dart:math';

class DrawCompetitor{
  
  String competitorId; // Not A User Id
  String userId;
  String imageURL;
  String storeDrawFK;
  late String? threeLetters;
  int competitorNumber;

  DrawCompetitor({
    required this.userId,
    required this.imageURL,
    this.threeLetters,  
    required this.competitorNumber,
    required this.competitorId,
    required this.storeDrawFK,

  });

  Map<String, dynamic> toJson(){
    return {
      'Competitor Id': competitorId,
      'User Id': userId,
      'Image URL': imageURL,
      'Store Draw FK':storeDrawFK,
      '3Letters': threeLetters,
      'Competitor Number': competitorNumber,
    };
  }

  factory DrawCompetitor.fromJson(dynamic json){
    
    DrawCompetitor competitor = DrawCompetitor(
    userId: json['User Id'], 
    imageURL: json['Image URL'],
    threeLetters: json['3Letters'],
    competitorId: json['Competitor Id'],
    storeDrawFK: json['Store Draw FK'],
    competitorNumber: json['Competitor Number']
    );

    return competitor;
  }

   void generateCompetitionId(){

    if(this.threeLetters==null){
      generateCompetitionId();
    }
    String lettersAndNumbers = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

    String threeLetters = '';

    for(int i = 0; i < 3;i++){
      Random random = Random();
      threeLetters += lettersAndNumbers[random.nextInt(lettersAndNumbers.length)];
    }

    this.threeLetters = threeLetters;
  }

}