import 'package:dogy_park/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../widgets/back_button.dart';
import '../../widgets/inputs/email_input.dart';
import '../../widgets/inputs/password_input.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/text_widget.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  final ValueNotifier<String?> _loginErrorMessageNotifier =
      ValueNotifier<String?>(null);

  void _onLoginButtonPressed(context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    String msg = await authProvider.login(
        _emailController.text, _passwordController.text);

    if (msg != 'success') {
      // Set the loginErrorMessageNotifier value to the error message.
      _loginErrorMessageNotifier.value = msg;
    }
  }

  void _onForgotPasswordButtonPressed() {
    // TODO: Implement forgot password logic here.
  }

  void _onRegisterButtonPressed(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => RegisterPage()),
    // );

    GoRouter.of(context).pushReplacement('/register');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: 'Signin',
        leadingWidget: BackWidget()
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
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

            // Display the error message below the password input field.
            ValueListenableBuilder<String?>(
              valueListenable: _loginErrorMessageNotifier,
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
                text: 'Login',
                onPressed: () => {_onLoginButtonPressed(context)}),
            TextButton(
              onPressed: _onForgotPasswordButtonPressed,
              child: const Text('Forget password?'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () => _onRegisterButtonPressed(context),
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
