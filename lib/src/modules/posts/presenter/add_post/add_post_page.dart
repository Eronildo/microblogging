import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microblogging/src/modules/posts/presenter/add_post/add_post_controller.dart';
import 'package:microblogging/src/shared/widgets/posts/editor/post_editor_widget.dart';

class AddPostPage extends GetView<AddPostController> {
  static const String ROUTE_NAME = '/addPost';

  @override
  Widget build(BuildContext context) {
    return PostEditorWidget<AddPostController>(
      pageTitle: 'Create Post',
      submitButtonName: 'POST',
    );
  }
}
