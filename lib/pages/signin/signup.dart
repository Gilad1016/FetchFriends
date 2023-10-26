import 'package:dogy_park/pages/signin/signin.dart';
import 'package:flutter/material.dart';
import '../../tools/firestore_provider.dart';
import '../../widgets/inputs/email_input.dart';
import '../../widgets/inputs/password_input.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/text_widget.dart';
import '../park.dart';

class SignupPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthProvider authProvider = AuthProvider();

  SignupPage({super.key});

  // Email format validator
  bool _isEmailValid(String email) {
    const emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    final regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  // Password length validator
  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  Future<void> _onSignupButtonPressed(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (!_isEmailValid(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email format'),
        ),
      );
    } else if (!_isPasswordValid(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 8 characters'),
        ),
      );
    } else if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
    } else {
      final user =
          await authProvider.registerWithEmailAndPassword(email, password);
      if (user != null) {
        // Registration successful, you can navigate to another page or show a success message
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ParkPage()),
        );

      } else {
        // Registration failed, handle the error (e.g., show an error message)
      }
    }
  }

  void _onForgotPasswordButtonPressed() {
    // TODO: Implement forgot password logic here.
  }

  void _onSigninButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SigninPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Signup',
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        onActionPressed: () {
          // Handle action button press (e.g., show a menu or perform an action)
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
              subheaderText: 'Find out \'who let the dogs out?\' \n and where?',
            ),
            EmailInput(
              controller: _emailController,
            ),
            PasswordInput(
              passwordController: _passwordController,
              hintText: 'Password',
            ),
            PasswordInput(
              passwordController: _confirmPasswordController,
              hintText: 'Confirm Password',
            ),
            CustomButton(
              text: 'Signup',
              onPressed: () => _onSignupButtonPressed(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () => _onSigninButtonPressed(context),
                  child: const Text('Sign in'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
