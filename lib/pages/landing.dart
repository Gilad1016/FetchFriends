import 'package:dogy_park/design/color_pallette.dart';
import 'package:dogy_park/pages/register.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.2,
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1),
            child: Image.asset(
              'assets/who-let-the-dogs-out-logo-zip-file/png/logo-no-background.png',
              width: MediaQuery.of(context).size.width * 0.8,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Center(
                child: Text(
                  'Your Text Here',
                  style: TextStyle(
                    fontSize: 24, // Customize the font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            // margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                // Replace this logic with your actual condition to check if a user item is stored
                bool isUserStored =
                    false; // Change this to true if the user is stored

                if (isUserStored) {
                  // Navigate to a different page since the user is stored
                  // Example: Navigator.pushNamed(context, '/userProfile');
                } else {
                  // Navigate to the register page since the user is not stored
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.white, // White background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(
                      color: AppColors.primaryColor,
                      width: 5 // Border color
                  ), // Outline color
                ),
              ),
              child: const Text(
                'Bark!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: AppColors.primaryColor, // Text color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
