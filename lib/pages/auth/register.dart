import 'package:dogy_park/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/inputs/email_input.dart';
import '../../widgets/inputs/password_input.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/text_widget.dart';

class RegisterPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  RegisterPage({super.key});

  final ValueNotifier<String?> _registerErrorMessageNotifier =
  ValueNotifier<String?>(null);

  Future<void> _onRegisterButtonPressed(BuildContext context) async {
    if (_passwordController.text != _confirmPasswordController.text) {
      _registerErrorMessageNotifier.value = 'Passwords do not match';
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    String msg = await authProvider.register(
        _emailController.text, _passwordController.text);

    if (msg != 'success') {
      // Set the loginErrorMessageNotifier value to the error message.
      _registerErrorMessageNotifier.value = msg;
    }
  }

  void _onForgotPasswordButtonPressed() {
    // TODO: Implement forgot password logic here.
  }

  void _onLoginButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Signup',
        onLeadingPressed: () {
          Navigator.pushReplacementNamed(context, '/landing');
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
            ValueListenableBuilder<String?>(
              valueListenable: _registerErrorMessageNotifier,
              builder: (context, value, child) {
                if (value != null) {
                  return Text(
                    value,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  );
                } else {
                  return Container();
                }
              },
            ),
            CustomButton(
              text: 'Register',
              onPressed: () => _onRegisterButtonPressed(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () => _onLoginButtonPressed(context),
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
