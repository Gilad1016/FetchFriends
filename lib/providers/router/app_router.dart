import 'package:dogy_park/pages/boot.dart';
import 'package:dogy_park/providers/router/routes_utils.dart';
import 'package:go_router/go_router.dart';

import '../../pages/park.dart';
import '../../pages/auth/register.dart';
import '../../pages/auth/login.dart';
import '../../pages/error.dart';
import '../../pages/landing.dart';
import '../../pages/splash.dart';
import '../app_state_provider.dart';

class AppRouter {
  late final AppStateProvider appProvider;

  GoRouter get router => _goRouter;

  AppRouter(this.appProvider);

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: appProvider,
    // initialLocation: AppPage.boot.toPath,
    routes: <GoRoute>[
      GoRoute(
        path: AppPage.park.toPath,
        name: AppPage.park.toName,
        builder: (context, state) => const ParkPage(),
      ),
      GoRoute(
        path: AppPage.splash.toPath,
        name: AppPage.splash.toName,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppPage.login.toPath,
        name: AppPage.login.toName,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: AppPage.register.toPath,
        name: AppPage.register.toName,
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: AppPage.landing.toPath,
        name: AppPage.landing.toName,
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: AppPage.error.toPath,
        name: AppPage.error.toName,
        builder: (context, state) => ErrorPage(error: state.extra.toString()),
      ),
      GoRoute(
        path: AppPage.boot.toPath,
        name: AppPage.boot.toName,
        builder: (context, state) => const BootPage(),
      )
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
    redirect: (context, state) {
      print("redirect");
      // Redirect to boot if init is false
      if(!appProvider.init) {
        return AppPage.boot.toPath;
      }
      // Redirect to landing if login state is false and page is not landing or
      // login or register
      if (!appProvider.loginState &&
          (state.matchedLocation != AppPage.landing.toPath &&
              state.matchedLocation != AppPage.login.toPath &&
              state.matchedLocation != AppPage.register.toPath)) {
        return AppPage.landing.toPath;
      }

      // Redirect to Park if login state is true and page is landing or
      // login or register
      if (appProvider.loginState &&
          (state.matchedLocation == AppPage.landing.toPath ||
              state.matchedLocation == AppPage.login.toPath ||
              state.matchedLocation == AppPage.register.toPath ||
              state.matchedLocation == AppPage.boot.toPath)) {
        return AppPage.park.toPath;
      }

      //return page same as path
      return state.matchedLocation;
    },
  );
}
