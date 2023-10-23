import 'package:dogy_park/design/color_pallette.dart';
import 'package:dogy_park/pages/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:dogy_park/widgets/custom_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
              right: MediaQuery.of(context).size.width * 0.1,
            ),
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
            child: CustomButton(
              text: 'Bark!',
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
                      builder: (context) => SigninPage(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
