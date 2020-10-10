import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:microblogging/src/core/presenter/home/home_controller.dart';
import 'package:microblogging/src/modules/news/presenter/news_page.dart';
import 'package:microblogging/src/modules/posts/bindings/posts_binding.dart';
import 'package:microblogging/src/modules/posts/presenter/posts/posts_controller.dart';
import 'package:microblogging/src/modules/posts/presenter/posts/posts_page.dart';
import 'package:microblogging/src/shared/widgets/bars/custom_app_bar.dart';

class HomePage extends GetView<HomeController> {
  static const String ROUTE_NAME = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: _appBarWidget,
      body: GetBuilder<PostsController>(
        initState: (_) => PostsBinding().dependencies(),
        builder: (_) => PostsPage(),
      ),
      floatingActionButton: _floatingActionButton,
      drawer: _drawerWidget,
    );
  }

  Widget get _appBarWidget => CustomAppBar(
        leading: IconButton(
          padding: const EdgeInsets.only(top: 15.0),
          icon: Icon(
            Icons.menu,
            size: 30.0,
          ),
          onPressed: controller.openDrawer,
        ),
        height: 65.0,
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            'Microblogging',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: FlatButton(
              onPressed: () {
                Get.toNamed(NewsPage.ROUTE_NAME);
              },
              child: Text(
                'Latest News',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          )
        ],
      );

  Widget get _drawerWidget {
    final loggedUser = controller.loggedUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Card(
                  elevation: 2.0,
                  shape: CircleBorder(),
                  child: Container(
                    height: 80.0,
                    width: 80.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage('assets/images/profile.png'),
                        image: NetworkImage(loggedUser.photo),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    loggedUser.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                Text(loggedUser.email),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: controller.signout,
          ),
        ],
      ),
    );
  }

  Widget get _floatingActionButton => FloatingActionButton.extended(
        onPressed: controller.goToAddPostPage,
        label: Text(
          'Add Post',
        ),
        icon: Icon(
          Icons.add_comment,
          color: Colors.white,
        ),
      );
}
