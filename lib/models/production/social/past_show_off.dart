// Collection Name /storea/storeId/past_show_offs

import 'show_off.dart';

class PastShowOff extends ShowOff {
  String whatWereYouDrinking;
  String? whatWereYouDrinkingAnswerAsImageOrVideoURL;

  String whereWereYou;
  String? whereWereYouAnswerAsText;
  String? whereWereYouAnswerAsVoiceRecord;

  String whoWereYouWith;
  String? whoWereYouWithAnswerAsText;
  String? whoWereYouWithAnswerAsVoiceRecord;
  String? whoWereYouWithAnswerAsImage;

  String whatHappened;
  String? whatHappenedAnswerAsText;
  String? whatHappenedAnswerAsVoiceRecord;
  String? whatHappenedAnswerAsVideo;

  // Contains A Sub Collections Of Comments.

  PastShowOff(
      {creatorId,
      creatorUsername,
      creatorImageURL,
      this.whatWereYouDrinking = "What Were You Drinking?",
      this.whatWereYouDrinkingAnswerAsImageOrVideoURL,
      this.whereWereYou = "Where Were You?",
      this.whereWereYouAnswerAsText,
      this.whereWereYouAnswerAsVoiceRecord,
      this.whoWereYouWith = "Who Were You With?",
      this.whoWereYouWithAnswerAsText,
      this.whoWereYouWithAnswerAsVoiceRecord,
      this.whoWereYouWithAnswerAsImage,
      this.whatHappened = "What Happened?",
      this.whatHappenedAnswerAsText,
      this.whatHappenedAnswerAsVoiceRecord,
      this.whatHappenedAnswerAsVideo,
      isFake})
      : super(
          creatorId: creatorId,
          creatorUsername: creatorUsername,
          creatorImageURL: creatorImageURL,
          isFake: isFake,
        );

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map.addAll({
      "Question #1": whatWereYouDrinking,
      "Answer #1/1": whatWereYouDrinkingAnswerAsImageOrVideoURL,
      "Question #2": whereWereYou,
      "Answer #2/1": whereWereYouAnswerAsText,
      "Answer #2/2": whereWereYouAnswerAsVoiceRecord,
      "Question #3": whoWereYouWith,
      "Answer #3/1": whoWereYouWithAnswerAsText,
      "Answer #3/2": whoWereYouWithAnswerAsVoiceRecord,
      "Answer #3/3": whoWereYouWithAnswerAsImage,
      "Question #4": whatHappened,
      "Answer #4/1": whatHappenedAnswerAsText,
      "Answer #4/2": whatHappenedAnswerAsVoiceRecord,
      "Answer #4/3": whatHappenedAnswerAsVideo,
    });
    return map;
  }

  PastShowOff fromJson(dynamic json) {
    return PastShowOff(
        whatWereYouDrinking: json["Question #1"],
        whatWereYouDrinkingAnswerAsImageOrVideoURL: json["Answer #1/1"],
        whereWereYou: json["Question #2"],
        whereWereYouAnswerAsText: json["Answer #2/1"],
        whereWereYouAnswerAsVoiceRecord: json["Answer #2/2"],
        whoWereYouWith: json["Question #3"],
        whoWereYouWithAnswerAsText: json["Answer #3/1"],
        whoWereYouWithAnswerAsVoiceRecord: json["Answer #3/2"],
        whoWereYouWithAnswerAsImage: json["Answer #3/3"],
        whatHappened: json["Question #4"],
        whatHappenedAnswerAsText: json["Answer #4/1"],
        whatHappenedAnswerAsVoiceRecord: json["Answer #4/2"],
        whatHappenedAnswerAsVideo: json["Answer #4/3"],
        isFake: json['Is Fake'] == 'Yes' ? true : false);
  }
}
