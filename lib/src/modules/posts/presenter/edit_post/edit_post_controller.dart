import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
import 'package:microblogging/src/modules/posts/presenter/entities/post_editor_controller.dart';
import 'package:microblogging/src/modules/posts/domain/entities/message.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/domain/usecases/edit_post.dart';

class EditPostController extends GetxController
    implements PostEditorController {
  final EditPost editPost;
  final _isSubmitButtonEnabled = false.obs;

  Post _post;
  String _postContent = '';
  String _initialContent = '';

  EditPostController({@required this.editPost});

  @override
  void onInit() {
    _setPost(Get.arguments);
    super.onInit();
  }

  @override
  bool get isSubmitButtonEnabled => _isSubmitButtonEnabled.value;
  @override
  set isSubmitButtonEnabled(value) => _isSubmitButtonEnabled.value = value;

  String get initialContent => _initialContent;

  void _setPost(value) {
    _post = value;
    _initialContent = _post.message.content;
  }

  @override
  void onChanged(String value) {
    isSubmitButtonEnabled = value.isNotEmpty && value != _initialContent;
    _postContent = value;
  }

  @override
  void submit() async {
    final result = await editPost(
      Post(
        id: _post.id,
        user: _post.user,
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
