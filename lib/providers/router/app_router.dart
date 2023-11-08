import 'package:dogy_park/pages/add_dog.dart';
import 'package:dogy_park/pages/boot.dart';
import 'package:dogy_park/providers/router/routes_utils.dart';
import 'package:go_router/go_router.dart';

import '../../pages/park.dart';
import '../../pages/auth/register.dart';
import '../../pages/auth/login.dart';
import '../../pages/error.dart';
import '../../pages/landing.dart';
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
      ),
      GoRoute(
        path: AppPage.addDog.toPath,
        name: AppPage.addDog.toName,
        builder: (context, state) => const AddDogPage(),
      )
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
    redirect: (context, state) {
      print("redirect");

      if (!appProvider.init) {
        return AppPage.boot.toPath;
      }

      if (!appProvider.loginState) {
        print("user is not logged in");
        if (state.matchedLocation != AppPage.landing.toPath &&
            state.matchedLocation != AppPage.login.toPath &&
            state.matchedLocation != AppPage.register.toPath) {
          return AppPage.landing.toPath;
        }
      } else {
        print("user is logged in");
        if (!appProvider.dogsLoaded) {
          return AppPage.addDog.toPath;
        }

        if (state.matchedLocation == AppPage.landing.toPath ||
            state.matchedLocation == AppPage.login.toPath ||
            state.matchedLocation == AppPage.register.toPath ||
            state.matchedLocation == AppPage.boot.toPath) {
          return AppPage.park.toPath;
        }
      }

      return state.matchedLocation;
    },
  );
}
