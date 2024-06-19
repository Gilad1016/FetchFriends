import 'package:Fetch/common/router/app_router.dart';
import 'package:Fetch/dog_management/dog_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'auth/auth_provider.dart';
import 'common/design/color_pallette.dart';
import 'common/providers/app_state/app_state_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({
    super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late AppStateProvider appProvider;
  late AuthProvider authProvider;
  late DogProvider dogProvider;

  @override
  void initState() {
    appProvider = AppStateProvider();
    authProvider = AuthProvider();
    dogProvider = DogProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateProvider>(create: (_) => appProvider),
        Provider<AppRouter>(create: (_) => AppRouter(appProvider)),
        Provider<AuthProvider>(create: (_) => authProvider),
        Provider<DogProvider>(create: (_) => dogProvider),
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
