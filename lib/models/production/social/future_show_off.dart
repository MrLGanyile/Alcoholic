// Collection Name /storea/storeId/future_show_offs

import 'show_off.dart';

class FutureShowOff extends ShowOff {
  String whichDrinksAreRequired;
  String? whichDrinksAreRequiredAnswerAsText;
  String? whichDrinksAreRequiredAnswerAsImage;
  String? whichDrinksAreRequiredAnswerAsVoiceRecord;
  String? whichDrinksAreRequiredAnswerAsVideo;

  String whichDrinksAreAlreadyThere;
  String? whichDrinksAreAlreadyThereAnswerAsText;
  String? whichDrinksAreAlreadyThereAnswerAsImage;
  String? whichDrinksAreAlreadyThereAnswerAsVoiceRecord;
  String? whichDrinksAreAlreadyThereAnswerAsVideo;

  String whereIsTheEventHosted;
  String whereIsTheEventHostedAnswerAsText;
  String? whereIsTheEventHostedAnswerAsImage;
  String? whereIsTheEventHostedAnswerAsVideo;

  String whenIsTheEvent;
  String whenIsTheEventAnswerAsText;

  // Contains A Sub Collections Of Comments.

  FutureShowOff({
    creatorId,
    creatorUsername,
    creatorImageURL,
    this.whichDrinksAreRequired = "Which Drinks Are Required?",
    this.whichDrinksAreRequiredAnswerAsText,
    this.whichDrinksAreRequiredAnswerAsImage,
    this.whichDrinksAreRequiredAnswerAsVoiceRecord,
    this.whichDrinksAreRequiredAnswerAsVideo,
    this.whichDrinksAreAlreadyThere = "Which Drinks Are Already There?",
    this.whichDrinksAreAlreadyThereAnswerAsText,
    this.whichDrinksAreAlreadyThereAnswerAsImage,
    this.whichDrinksAreAlreadyThereAnswerAsVoiceRecord,
    this.whichDrinksAreAlreadyThereAnswerAsVideo,
    this.whereIsTheEventHosted = "Where Is The Event Hosted?",
    required this.whereIsTheEventHostedAnswerAsText,
    this.whereIsTheEventHostedAnswerAsImage,
    this.whereIsTheEventHostedAnswerAsVideo,
    this.whenIsTheEvent = "When Is The Event?",
    required this.whenIsTheEventAnswerAsText,
    isFake,
  }) : super(
            creatorId: creatorId,
            creatorUsername: creatorUsername,
            creatorImageURL: creatorImageURL,
            isFake: isFake);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map.addAll({
      "Question #1": whichDrinksAreRequired,
      "Answer #1/1": whichDrinksAreRequiredAnswerAsText,
      "Answer #1/2": whichDrinksAreRequiredAnswerAsImage,
      "Answer #1/3": whichDrinksAreRequiredAnswerAsVoiceRecord,
      "Answer #1/4": whichDrinksAreRequiredAnswerAsVideo,
      "Question #2": whichDrinksAreAlreadyThere,
      "Answer #2/1": whichDrinksAreAlreadyThereAnswerAsText,
      "Answer #2/2": whichDrinksAreAlreadyThereAnswerAsImage,
      "Answer #2/3": whichDrinksAreAlreadyThereAnswerAsVoiceRecord,
      "Answer #2/4": whichDrinksAreAlreadyThereAnswerAsVideo,
      "Question #3": whereIsTheEventHosted,
      "Answer #3/1": whereIsTheEventHostedAnswerAsText,
      "Answer #3/2": whereIsTheEventHostedAnswerAsImage,
      "Answer #3/3": whereIsTheEventHostedAnswerAsVideo,
      "Question #4": whenIsTheEvent,
      "Answer #4/1": whenIsTheEventAnswerAsText,
    });
    return map;
  }

  FutureShowOff fromJson(dynamic json) => FutureShowOff(
      whichDrinksAreRequired: json["Question #1"],
      whichDrinksAreRequiredAnswerAsText: json["Answer #1/1"],
      whichDrinksAreRequiredAnswerAsImage: json["Answer #1/2"],
      whichDrinksAreRequiredAnswerAsVoiceRecord: json["Answer #1/3"],
      whichDrinksAreRequiredAnswerAsVideo: json["Answer #1/4"],
      whichDrinksAreAlreadyThere: json["Question #2"],
      whichDrinksAreAlreadyThereAnswerAsText: json["Answer #2/1"],
      whichDrinksAreAlreadyThereAnswerAsImage: json["Answer #2/2"],
      whichDrinksAreAlreadyThereAnswerAsVoiceRecord: json["Answer #2/3"],
      whichDrinksAreAlreadyThereAnswerAsVideo: json["Answer #2/4"],
      whereIsTheEventHosted: json["Question #3"],
      whereIsTheEventHostedAnswerAsText: json["Answer #3/1"],
      whereIsTheEventHostedAnswerAsImage: json["Answer #3/2"],
      whereIsTheEventHostedAnswerAsVideo: json["Answer #3/3"],
      whenIsTheEvent: json["Question #4"],
      whenIsTheEventAnswerAsText: json["Answer #4/1"],
      isFake: json['Is Fake'] == 'Yes' ? true : false);
}
