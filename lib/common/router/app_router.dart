import 'package:Fetch/common/router/routes_utils.dart';
import 'package:go_router/go_router.dart';

import '../../dog_management/dog_mng.dart';
import '../../park/home.dart';
import '../../auth/register.dart';
import '../../auth/login.dart';
import '../../landing.dart';
import '../pages/boot.dart';
import '../pages/error.dart';
import '../providers/app_state/app_state_provider.dart';
import '../providers/app_state/states_utils.dart';

class AppRouter {
  late final AppStateProvider appProvider;

  GoRouter get router => _goRouter;

  AppRouter(this.appProvider);

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: appProvider,
    // initialLocation: AppPage.boot.toPath,
    routes: <GoRoute>[
      GoRoute(
        path: AppPage.parkHome.toPath,
        name: AppPage.parkHome.toName,
        builder: (context, state) => const ParkHomePage(),
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
        builder: (context, state) => const DogMngPage(),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
    redirect: (context, state) {
      print("redirect");
      print("state: ${appProvider.state}");
      print("matchedLocation: ${state.matchedLocation}");

      switch (appProvider.state) {
        case AppState.init:
          return AppPage.boot.toPath;

        case AppState.unauthenticated:
          if ((state.matchedLocation != AppPage.landing.toPath) &&
              (state.matchedLocation != AppPage.login.toPath) &&
              (state.matchedLocation != AppPage.register.toPath)) {
            return AppPage.landing.toPath;
          }
        case AppState.loggedIn:
          return AppPage.addDog.toPath;

        // case AppState.noLocationPermission:
        //   return AppPage.requestPermission.toPath;

        case AppState.loggedInWithDogs:
          // return AppPage.addPreferredPark.toPath;
        // //TODO: after add parks is done change this to add parks
          if ((state.matchedLocation == AppPage.landing.toPath ||
              state.matchedLocation == AppPage.login.toPath ||
              state.matchedLocation == AppPage.register.toPath ||
              state.matchedLocation == AppPage.boot.toPath)) {
            return AppPage.parkHome.toPath;
          }

        // case AppState.loggedInWithDogsAndSavedParks:
        //   if ((state.matchedLocation == AppPage.landing.toPath ||
        //       state.matchedLocation == AppPage.login.toPath ||
        //       state.matchedLocation == AppPage.register.toPath ||
        //       state.matchedLocation == AppPage.boot.toPath)) {
        //     return AppPage.parkHome.toPath;
        //   }
      }

      return state.matchedLocation;
    },
  );
}
