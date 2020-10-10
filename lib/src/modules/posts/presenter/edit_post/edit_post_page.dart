import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microblogging/src/modules/posts/presenter/edit_post/edit_post_controller.dart';
import 'package:microblogging/src/shared/widgets/posts/editor/post_editor_widget.dart';

class EditPostPage extends GetView<EditPostController> {
  static const String ROUTE_NAME = '/editPost';

  @override
  Widget build(BuildContext context) {
    return PostEditorWidget<EditPostController>(
      pageTitle: 'Edit Post',
      submitButtonName: 'SAVE',
      textFormFieldInitialValue: controller.initialContent,
    );
  }
}
