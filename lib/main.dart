import 'package:dogy_park/pages/signin/signup.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/firebase.dart';
import 'package:dogy_park/pages/landing.dart';
import 'package:dogy_park/tools/session_manager.dart';
import 'package:dogy_park/design/color_pallette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final sessionManager = SessionManager();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FetchFriends',
      theme: ThemeData(
        fontFamily: 'Fredoka', // Set the font family
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        )
     ),
      initialRoute: 'welcome',
      routes: {
        '/welcome': (context) => const LandingPage(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}
