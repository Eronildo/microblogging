import 'package:get/get.dart';
import 'package:microblogging/src/core/bindings/home_binding.dart';
import 'package:microblogging/src/core/presenter/home/home_page.dart';
import 'package:microblogging/src/core/presenter/initial_page.dart';
import 'package:microblogging/src/core/presenter/loading_page.dart';
import 'package:microblogging/src/core/presenter/splash_page.dart';
import 'package:microblogging/src/modules/authentication/bindings/forgot_password_binding.dart';
import 'package:microblogging/src/modules/authentication/bindings/login_binding.dart';
import 'package:microblogging/src/modules/authentication/bindings/signup_binding.dart';
import 'package:microblogging/src/modules/authentication/presenter/forgot_password/forgot_password_page.dart';
import 'package:microblogging/src/modules/authentication/presenter/login/login_page.dart';
import 'package:microblogging/src/modules/authentication/presenter/signup/signup_page.dart';
import 'package:microblogging/src/modules/news/bindings/news_binding.dart';
import 'package:microblogging/src/modules/news/presenter/news_page.dart';
import 'package:microblogging/src/modules/posts/bindings/add_post_binding.dart';
import 'package:microblogging/src/modules/posts/bindings/edit_post_binding.dart';
import 'package:microblogging/src/modules/posts/presenter/add_post/add_post_page.dart';
import 'package:microblogging/src/modules/posts/presenter/edit_post/edit_post_page.dart';

class AppRoutes {
  static String get initialRoute => SplashPage.ROUTE_NAME;
  static List<GetPage> get pages => [
        GetPage(name: SplashPage.ROUTE_NAME, page: () => SplashPage()),
        GetPage(name: InitialPage.ROUTE_NAME, page: () => InitialPage()),
        GetPage(name: LoadingPage.ROUTE_NAME, page: () => LoadingPage()),
        GetPage(
            name: LoginPage.ROUTE_NAME,
            page: () => LoginPage(),
            binding: LoginBinding()),
        GetPage(
            name: ForgotPasswordPage.ROUTE_NAME,
            page: () => ForgotPasswordPage(),
            binding: ForgotPasswordBinding()),
        GetPage(
            name: SignupPage.ROUTE_NAME,
            page: () => SignupPage(),
            binding: SignupBinding()),
        GetPage(
            name: HomePage.ROUTE_NAME,
            page: () => HomePage(),
            binding: HomeBinding()),
        GetPage(
            name: NewsPage.ROUTE_NAME,
            page: () => NewsPage(),
            binding: NewsBinding()),
        GetPage(
            name: AddPostPage.ROUTE_NAME,
            page: () => AddPostPage(),
            binding: AddPostBinding()),
        GetPage(
            name: EditPostPage.ROUTE_NAME,
            page: () => EditPostPage(),
            binding: EditPostBinding()),
      ];
}
