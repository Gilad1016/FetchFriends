import 'package:feedback/feedback.dart';
import 'package:fetch/park/arrivals_provider.dart';
import 'package:fetch/park/park_provider.dart';
import 'package:fetch/phone_size_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'common/design/color_pallette.dart';
import 'common/providers/app_state/app_state_provider.dart';
import 'common/providers/router/app_router.dart';
import 'dog_management/dog_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const BetterFeedback(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ProxyProvider<AppStateProvider, AppRouter>(
          update: (_, appStateProvider, __) => AppRouter(appStateProvider),
        ),
        ChangeNotifierProvider(create: (_) => DogProvider()),
        ChangeNotifierProvider<ParkProvider>(create: (_) => ParkProvider()),
        ChangeNotifierProxyProvider<ParkProvider, ArrivalsProvider>(
          create: (_) => ArrivalsProvider(),
          update: (_, parkProvider, arrivalsProvider) {
            if (arrivalsProvider == null) {
              return ArrivalsProvider()
                ..parkProvider = parkProvider;
            }
            arrivalsProvider.parkProvider = parkProvider;
            arrivalsProvider.fetchArrivals();
            arrivalsProvider.subscribeToArrivals();
            return arrivalsProvider;
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          final GoRouter goRouter =
              Provider
                  .of<AppRouter>(context, listen: false)
                  .router;
          return PhoneSizeWrapper(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: "FetchFriends",
              routeInformationParser: goRouter.routeInformationParser,
              routeInformationProvider: goRouter.routeInformationProvider,
              routerDelegate: goRouter.routerDelegate,
              theme: ThemeData(
                fontFamily: 'Fredoka',
                primaryColor: AppColors.primaryColor,
                canvasColor: AppColors.backgroundColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
