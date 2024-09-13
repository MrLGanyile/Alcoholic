import 'package:alcoholic/models/production/Utilities/may_be_fake.dart';

class Comment extends MayBeFake {
  String commentId;
  String showOffFK;
  String message;
  String userImageURL;
  String username;

  Comment({
    required this.commentId,
    required this.showOffFK,
    required this.message,
    required this.userImageURL,
    required this.username,
    isFake,
  }) : super(isFake: isFake);
}
