import 'package:dogy_park/pages/signin/signup.dart';
import 'package:flutter/material.dart';
import '../../widgets/inputs/email_input.dart';
import '../../widgets/inputs/password_input.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/text_widget.dart';

class SigninPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  SigninPage({super.key});

  void _onSigninButtonPressed() {
    // TODO: Implement sign-in logic here.
  }

  void _onForgotPasswordButtonPressed() {
    // TODO: Implement forgot password logic here.
  }

  void _onSignupButtonPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/');

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SignupPage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Signin',
        onLeadingPressed: () {
          // Handle leading button press
        },
        onActionPressed: () {
          // Handle action button press
          // For example, show a menu or perform an action
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const TextWidget(
              headerText: 'Hello!',
              subheaderText: 'Find out \'Who let the dogs out?\' \nand where?',
            ),
            EmailInput(
              controller: _emailController,
            ),
            PasswordInput(
              passwordController: _passwordController,
              hintText: 'Password',
            ),
            CustomButton(
              text: 'Signin', // Use your CustomButton widget
              onPressed: _onSigninButtonPressed,
            ),
            TextButton(
              onPressed: () => _onForgotPasswordButtonPressed(),
              child: const Text('Forget password?'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () => _onSignupButtonPressed(context),
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
