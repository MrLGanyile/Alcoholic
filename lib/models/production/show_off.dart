// Collection Name /show_offs/showOffId
class ShowOff{

  String showOffId;
  String recordedVideoURL;
  DateTime dateCreated;
  String whereWereYou;
  String whoWereYouWith;
  String whatHappened;
  String? whatMusicWereYouListeningTo;

  ShowOff({
    required this.showOffId,
    required this.recordedVideoURL,
    required this.dateCreated,
    required this.whereWereYou,
    required this.whoWereYouWith,
    required this.whatHappened,
    required this.whatMusicWereYouListeningTo,
  });

  Map<String, dynamic> toJson()=>{
    'Show Off Id': showOffId,
    'Recorded Video URL': recordedVideoURL,
    'Date Created': dateCreated,
    'Where Were You': whereWereYou,
    'Who Were You With': whoWereYouWith,
    'What Happened': whatHappened,
    'What Music Were You Listening To': whatMusicWereYouListeningTo,
  };

  factory ShowOff.fromJson(Map<String, dynamic> json)=>ShowOff(
    showOffId: json['Show Off Id'], 
    recordedVideoURL: json['Recorded Video URL'], 
    dateCreated: json['Date Created'], 
    whereWereYou: json['Where Were You'], 
    whoWereYouWith: json['Who Were You With'], 
    whatHappened: json['What Happened'], 
    whatMusicWereYouListeningTo: json['What Music Were You Listening To']
  );
}