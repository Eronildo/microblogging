import 'package:microblogging/src/modules/posts/domain/entities/post.dart';

abstract class SortPostsChronologically {
  void call(List<Post> posts);
}

class SortPostsChronologicallyImpl implements SortPostsChronologically {
  @override
  void call(List<Post> posts) {
    posts
        .sort((a, b) => b.message.createdDate.compareTo(a.message.createdDate));
  }
}
