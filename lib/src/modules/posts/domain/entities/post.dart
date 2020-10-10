import 'package:microblogging/src/modules/authentication/domain/entities/user.dart';
import 'package:microblogging/src/modules/posts/domain/entities/message.dart';

class Post {
  final int id;
  final User user;
  final Message message;

  Post({this.id, this.user, this.message});

  bool get isValidMessageContent => message != null && message.isValidContent;
  bool isPostOwner(String loggedUserEmail) =>
      user != null && user.email == loggedUserEmail;
}
