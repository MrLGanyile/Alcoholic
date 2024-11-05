import 'package:alcoholic/models/Utilities/may_be_fake.dart';

// Collection Name /won_prices_summaries/wonPriceSummaryId/won_prices_comments/{commentId}
class WonPriceSummaryComment extends MayBeFake {
  String commentId;
  String wonPriceSummaryFK;
  String message;
  String creatorImageURL;
  String creatorUsername;
  String creatorFK;
  DateTime dateCreated;

  WonPriceSummaryComment({
    required this.commentId,
    required this.dateCreated,
    required this.wonPriceSummaryFK,
    required this.message,
    required this.creatorImageURL,
    required this.creatorUsername,
    required this.creatorFK,
    required isFake,
  }) : super(isFake: isFake);

  @override
  Map<String, dynamic> toJson() => {
        'commentId': commentId,
        'dateCreated': {
          'year': dateCreated.year,
          'month': dateCreated.month,
          'day': dateCreated.day,
          'hour': dateCreated.hour,
          'minute': dateCreated.minute,
        },
        'wonPriceSummaryFK': wonPriceSummaryFK,
        'message': message,
        'creatorImageURL': creatorImageURL,
        'creatorUsername': creatorUsername,
        'creatorFK': creatorFK,
        'isFake': isFake,
      };

  factory WonPriceSummaryComment.fromJson(dynamic json) {
    Map<String, dynamic> dateCreate =
        json['dateCreated'] as Map<String, dynamic>;
    return WonPriceSummaryComment(
        commentId: json['commentId'],
        dateCreated: DateTime(
          dateCreate['year']!,
          dateCreate['month']!,
          dateCreate['day']!,
          dateCreate['hour']!,
          dateCreate['minute']!,
        ),
        wonPriceSummaryFK: json['wonPriceSummaryFK'],
        message: json['message'],
        creatorImageURL: json['creatorImageURL'],
        creatorUsername: json['creatorUsername'],
        creatorFK: json['creatorFK'],
        isFake: json['isFake']);
  }
}
