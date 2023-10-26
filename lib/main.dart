import 'package:dogy_park/pages/park.dart';
import 'package:dogy_park/pages/signin/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dogy_park/pages/landing.dart';
import 'package:dogy_park/tools/session_manager.dart';
import 'package:dogy_park/design/color_pallette.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final sessionManager = SessionManager();

  MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Check if the user is signed in
    bool isSignedIn = widget.sessionManager.isSignedIn();

    // Determine the initial route based on the user's authentication status
    String initialRoute = isSignedIn ? '/' : '/welcome';

    // Set the initialRoute based on the user's authentication status
    // Navigator.pushReplacementNamed(context, initialRoute);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FetchFriends',
      theme: ThemeData(
        fontFamily: 'Fredoka', // Set the font family
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
      ),
      initialRoute: '/', // Set an initial route (you can change this)
      routes: {
        '/': (context) => const ParkPage(), // Set the initial route
        '/welcome': (context) => const LandingPage(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}
