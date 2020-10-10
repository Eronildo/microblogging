import 'package:flutter/material.dart';
import 'package:microblogging/src/modules/posts/domain/entities/post.dart';
import 'package:microblogging/src/modules/posts/presenter/entities/post_option.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final String postPlaceHolderImageAssetPath;
  final List<PostOption> options;

  final _maxPostHeight = 250.0;

  const PostWidget(
      {Key key,
      @required this.post,
      this.postPlaceHolderImageAssetPath = 'assets/images/profile.png',
      this.options})
      : super(key: key);

  get _isOptionsButtonEnable => options != null && options.length > 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12, width: 0.5)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _userPhotoWidget,
                    _userNameAndPostDateWidget,
                    Visibility(
                      visible: _isOptionsButtonEnable,
                      child: _getOptionsButton,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: _maxPostHeight,
                    minWidth: double.maxFinite,
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      post.message.content,
                      style: TextStyle(
                        fontSize: 18.0,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _userPhotoWidget => Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Card(
          elevation: 1.0,
          shape: CircleBorder(),
          child: Container(
            width: 50.0,
            height: 50.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage(
                  postPlaceHolderImageAssetPath,
                ),
                image: NetworkImage(
                  post.user.photo,
                ),
              ),
            ),
          ),
        ),
      );

  Widget get _userNameAndPostDateWidget => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                post.user.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              post.message.formattedDate,
              style: TextStyle(
                // fontSize: 18.0,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      );

  Widget get _getOptionsButton => SizedBox(
        width: 30.0,
        height: 30.0,
        child: PopupMenuButton(
            padding: EdgeInsets.all(0.0),
            icon: Icon(Icons.more_horiz),
            onSelected: (PostOption option) {
              option.onPressed();
            },
            itemBuilder: (BuildContext context) => options
                .map(
                  (option) => PopupMenuItem<PostOption>(
                    value: option,
                    child: Row(
                      children: [
                        Icon(
                          option.iconData,
                          color: Colors.black45,
                        ),
                        SizedBox(width: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            option.name,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList()),
      );
}
