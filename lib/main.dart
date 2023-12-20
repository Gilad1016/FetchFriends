import 'dart:async';

import 'package:dogy_park/providers/app_state/states_utils.dart';
import 'package:dogy_park/providers/data_provider.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'design/color_pallette.dart';
import 'firebase_options.dart';
import 'package:dogy_park/providers/app_state/app_state_provider.dart';
import 'package:dogy_park/providers/auth_provider.dart';
import 'package:dogy_park/providers/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider: AndroidProvider.debug);
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
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppStateProvider appProvider;
  late AuthProvider authProvider;
  late DataProvider dataProvider;

  late StreamSubscription<AppState> authSubscription;

  @override
  void initState() {
    dataProvider = DataProvider();
    appProvider = AppStateProvider(widget.sharedPreferences, dataProvider);
    authProvider = AuthProvider();
    authSubscription = authProvider.onAuthStateChange.listen(onAuthStateChange);

    super.initState();
  }

  void onAuthStateChange(AppState login) {
    print("onAuthStateChange: $login");
    if (login == AppState.unauthenticated) {
      appProvider.state = AppState.unauthenticated;
      return;
    }

    if (login == AppState.loggedIn) {
      appProvider.onAppStart();
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
        Provider<DataProvider>(create: (_) => dataProvider),
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
