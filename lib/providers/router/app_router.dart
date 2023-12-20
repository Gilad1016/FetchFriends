import 'package:dogy_park/pages/new_user_flow/add_dog.dart';
import 'package:dogy_park/pages/boot.dart';
import 'package:dogy_park/pages/profile.dart';
import 'package:dogy_park/providers/router/routes_utils.dart';
import 'package:go_router/go_router.dart';

import '../../pages/new_user_flow/add_preferred_park.dart';
import '../../pages/new_user_flow/request_location_permission.dart';
import '../../pages/home.dart';
import '../../pages/auth/register.dart';
import '../../pages/auth/login.dart';
import '../../pages/error.dart';
import '../../pages/landing.dart';
import '../app_state/app_state_provider.dart';
import '../app_state/states_utils.dart';

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
        builder: (context, state) => const AddDogPage(),
      ),
      GoRoute(
        path: AppPage.profile.toPath,
        name: AppPage.profile.toName,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: AppPage.requestPermission.toPath,
        name: AppPage.requestPermission.toName,
        builder: (context, state) => const LocationPermissionPage(),
      ),
      GoRoute(
        path: AppPage.addPreferredPark.toPath,
        name: AppPage.addPreferredPark.toName,
        builder: (context, state) => const AddPreferredParkPage(),
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

        case AppState.noLocationPermission:
          return AppPage.requestPermission.toPath;

        case AppState.loggedInWithDogs:
          //TODO: after add parks is done change this to add parks
          if ((state.matchedLocation == AppPage.landing.toPath ||
              state.matchedLocation == AppPage.login.toPath ||
              state.matchedLocation == AppPage.register.toPath ||
              state.matchedLocation == AppPage.boot.toPath)) {
            return AppPage.parkHome.toPath;
          }

        case AppState.loggedInWithDogsAndSavedParks:
          if ((state.matchedLocation == AppPage.landing.toPath ||
              state.matchedLocation == AppPage.login.toPath ||
              state.matchedLocation == AppPage.register.toPath ||
              state.matchedLocation == AppPage.boot.toPath)) {
            return AppPage.parkHome.toPath;
          }
      }

      print("no surprises");
      return state.matchedLocation;
    },
  );
}
