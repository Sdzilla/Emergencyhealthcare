import 'package:auto_route/auto_route_annotations.dart';
import 'package:emergencyhealthcare/ui/views/home/home_view.dart';
import 'package:emergencyhealthcare/ui/views/login/login_view.dart';
import 'package:emergencyhealthcare/ui/views/search/search_view.dart';
import 'package:emergencyhealthcare/ui/views/signup/signup_view.dart';
import 'package:emergencyhealthcare/ui/views/splash/splash_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: HomeView),
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: SearchView),
  ],
)
class $Router {}
