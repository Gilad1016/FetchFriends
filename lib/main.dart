import 'dart:async';

import 'package:Fetch/common/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/auth_provider.dart';
// import 'backend_service/backend_service.dart';
import 'common/design/color_pallette.dart';
import 'common/providers/app_state/app_state_provider.dart';
import 'common/providers/app_state/states_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({
    super.key,
    required this.sharedPreferences,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late AppStateProvider appProvider;
  late AuthProvider authProvider;
  // late BackendService backendService;

  late StreamSubscription<AppState> authSubscription;

  @override
  void initState() {
    appProvider = AppStateProvider(widget.sharedPreferences);
    authProvider = AuthProvider();
    authSubscription = authProvider.onAuthStateChange.listen(onAuthStateChange);
    authProvider.refresh();
    super.initState();
  }

  void onAuthStateChange(AppState login) {
    if (login == AppState.unauthenticated) {
      appProvider.state = AppState.unauthenticated;
      return;
    }

    if (login == AppState.loggedIn) {
      appProvider.validateUserDataAndState();
    }
  }

  @override
  void dispose() {
    authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateProvider>(create: (_) => appProvider),
        Provider<AppRouter>(create: (_) => AppRouter(appProvider)),
        Provider<AuthProvider>(create: (_) => authProvider),
        // Provider<BackendService>(create: (_) => backendService),
      ],
      child: Builder(
        builder: (context) {
          final GoRouter goRouter =
              Provider.of<AppRouter>(context, listen: false).router;
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: "FetchFriends",
            routeInformationParser: goRouter.routeInformationParser,
            routeInformationProvider: goRouter.routeInformationProvider,
            routerDelegate: goRouter.routerDelegate,
            theme: ThemeData(
              fontFamily: 'Fredoka',
              primaryColor: AppColors.primaryColor,
              canvasColor: AppColors.backgroundColor,
              // colorScheme: ColorScheme.fromSeed(
              //   seedColor: AppColors.primaryColor,
              // ),
            ),
          );
        },
      ),
    );
  }
}
