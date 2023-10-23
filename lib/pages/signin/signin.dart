import 'package:flutter/material.dart';
import '../../widgets/password_input.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/app_bar.dart';

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
    // TODO: Navigate to signup page here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Signin',
        onLeadingPressed: () {
          // Handle leading button press
          Navigator.pop(context); // Example: Navigate back
        },
        onActionPressed: () {
          // Handle action button press
          // For example, show a menu or perform an action
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Signin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 3.0),
                  ),
                ),
              ),
              PasswordInput(
                passwordController: _passwordController,
                onForgotPasswordButtonPressed: _onForgotPasswordButtonPressed,
              ),
              CustomButton(
                text: 'Signin', // Use your CustomButton widget
                onPressed: _onSigninButtonPressed,
              ),
              //add row widget
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
      ),
    );
  }
}
