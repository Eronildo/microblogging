import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microblogging/src/modules/posts/presenter/entities/post_editor_controller.dart';
import 'package:microblogging/src/shared/widgets/bars/custom_app_bar.dart';

class PostEditorWidget<T extends PostEditorController> extends GetView<T> {
  final String pageTitle;
  final submitButtonName;
  final String textFormFieldInitialValue;

  PostEditorWidget(
      {@required this.pageTitle,
      @required this.submitButtonName,
      this.textFormFieldInitialValue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget,
      body: _bodyWidget,
    );
  }

  Widget get _appBarWidget => CustomAppBar(
        title: Text(pageTitle),
        elevation: 1.0,
        actions: [
          Obx(
            () => FlatButton(
              onPressed: controller.isSubmitButtonEnabled
                  ? () {
                      controller.submit();
                    }
                  : null,
              child: Text(
                submitButtonName,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      );

  Widget get _bodyWidget => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: TextFormField(
          initialValue: textFormFieldInitialValue,
          maxLength: 280,
          autofocus: true,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "What's on your mind?",
            hintStyle: TextStyle(fontSize: 20.0),
            counterStyle: TextStyle(fontSize: 18.0),
          ),
          onChanged: controller.onChanged,
        ),
      );
}
