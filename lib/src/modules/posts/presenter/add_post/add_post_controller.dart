import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
import 'package:microblogging/src/app/app_service.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/domain/entities/message.dart';
import 'package:microblogging/src/modules/posts/domain/usecases/add_post.dart';
import 'package:microblogging/src/modules/posts/presenter/entities/post_editor_controller.dart';

class AddPostController extends GetxController implements PostEditorController {
  final AddPost addPost;

  final _isSubmitButtonEnabled = false.obs;
  String _postContent = '';

  AddPostController({@required this.addPost});

  @override
  bool get isSubmitButtonEnabled => _isSubmitButtonEnabled.value;
  @override
  set isSubmitButtonEnabled(value) => _isSubmitButtonEnabled.value = value;

  @override
  void onChanged(String value) {
    isSubmitButtonEnabled = value.isNotEmpty;
    _postContent = value;
  }

  @override
  void submit() async {
    final loggedUser = Get.find<AppService>().loggedUser;

    final result = await addPost(
      Post(
        user: loggedUser,
        message: Message(
          content: _postContent,
          createdDate: DateTime.now(),
        ),
      ),
    );
    result.fold(
      (l) => Get.rawSnackbar(message: l.message),
      (r) => Get.back(result: r),
    );
  }
}
