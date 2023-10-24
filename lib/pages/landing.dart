import 'package:dogy_park/design/color_pallette.dart';
import 'package:dogy_park/pages/signin/signin.dart';
import 'package:dogy_park/pages/signin/signup.dart';
import 'package:dogy_park/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:dogy_park/widgets/custom_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const TextWidget(
              headerText: 'Hello!',
              subheaderText: 'Find out \'who let the dogs out?\' \n and where?',
            ),
            CustomButton(
              text: 'SIGN IN',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SigninPage()),
                );
              },
            ),
            CustomButton(
              text: 'SIGN UP',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
