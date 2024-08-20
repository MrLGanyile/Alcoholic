import 'old_grand_price.dart';
import 'dart:math';

import 'old_player.dart';
import 'old_user.dart';

// Converted Into The Right Form.
class Competition extends Comparable<Competition>{
  DateTime dateTime;
  int maxNoOfGrandPrices;
  List<GrandPrice> grandPrices;
  User? winner;
  List<Player> competitors;
  double joiningFee;
  String? competitionId;
  Duration? duration;
  String storeFK;

  Competition({
    required this.joiningFee,
    required this.dateTime,
    required this.maxNoOfGrandPrices,
    required this.storeFK,
    this.grandPrices = const[],
    this.winner,
    this.competitors = const[],
    this.duration,

  }){
    generateCompetitionId();
  }

  Map<String,dynamic> toJson(){
    generateCompetitionId();
    return {
      'Special Date': dateTime.toString(),
      'Joining Fee': joiningFee,
      'No Of Prices': maxNoOfGrandPrices,
      'Grand Prices': grandPrices,
      'Winner': winner!.toJson(),
      'Competitors': competitors,
      'Competitor Id': competitionId,
      'Duration': duration,
      'Store FK': storeFK,
      
    };
  }

  factory Competition.fromJson(dynamic json){
    return Competition(
      dateTime: json['Special Date'], 
      maxNoOfGrandPrices: json['No Of Prices'], 
      grandPrices: json['Grand Prices'],
      winner: json['Winner'],
      competitors: json['Competitors'],
      joiningFee: json['Joining Fee'],
      duration: json['Duration'],
      storeFK: json['Store FK'],
    );
  }

  @override 
  String toString(){
    String description =  'Joining Fee: $joiningFee Max No Of Prices: $maxNoOfGrandPrices '
    'Duration: $duration Competitors [ ';

    for(Player player in competitors){
      description += '${player.picName} ';
    }

    description += '] Winner: $winner Date: $dateTime Grand Prices: [ ';

    for(GrandPrice grandPrice in grandPrices){
      description += '${grandPrice.description} ';
    }
    description += ' ]';

    return description;
  }

  void generateCompetitionId(){

    String lettersAndNumbers = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

    String competitionId = '';

    for(int i = 0; i < 20;i++){
      Random random = Random();
      competitionId += lettersAndNumbers[random.nextInt(lettersAndNumbers.length)];
    }

    this.competitionId = competitionId;
  }

  bool contains(String cellNumber){
    for(User user in competitors){
      if(user.cellNumber==cellNumber){
        return true;
      }
    }
    return false;
  }

  @override 
  int compareTo(Competition other){
    return dateTime.compareTo(other.dateTime);
  } 
}