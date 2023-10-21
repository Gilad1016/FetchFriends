import 'package:flutter/material.dart';
import 'package:dogy_park/pages/landing.dart';
import 'package:dogy_park/pages/park.dart';
import 'package:dogy_park/tools/session_manager.dart';
import 'package:dogy_park/design/color_pallette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        primaryColor: AppColors.primaryColor, // Use primary color from the palette
        hintColor: AppColors.accentColor, // Use accent color from the palette
        fontFamily: 'Fredoka', // Set the font family

     ),
      home: FutureBuilder<String?>(
        // Check if user is logged in using FutureBuilder
        future: sessionManager.getAuthToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Future is still loading, show a loading screen
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            // Future has completed
            if (snapshot.hasData && snapshot.data != null) {
              // User is logged in, show ParksPage
              return const ParkPage(); // Replace with your actual ParksPage widget
            } else {
              // User is not logged in, show LandingPage
              return const LandingPage(); // Replace with your actual LandingPage widget
            }
          }
        },
      ),
    );
  }
}
