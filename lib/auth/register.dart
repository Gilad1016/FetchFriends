import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../common/widgets/custom_button.dart';
import '../common/widgets/inputs/custom_input.dart';
import '../common/widgets/text_widget.dart';
import '../common/widgets/top_bar/app_bar.dart';
import '../common/widgets/top_bar/back_button.dart';
import 'auth_provider.dart';

class RegisterPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  RegisterPage({super.key});

  final ValueNotifier<String?> _registerErrorMessageNotifier =
      ValueNotifier<String?>(null);

  void _onRegisterButtonPressed(BuildContext context) async {
    if (_passwordController.text != _confirmPasswordController.text) {
      _registerErrorMessageNotifier.value = 'Passwords do not match';
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.register(
        _emailController.text, _passwordController.text, _confirmPasswordController.text);
    String msg = "success"; //TODO: Implement registration logic here.
    if (msg != 'success') {
      // Set the loginErrorMessageNotifier value to the error message.
      _registerErrorMessageNotifier.value = msg;
    }
  }

  void _onForgotPasswordButtonPressed() {
    // TODO: Implement forgot password logic here.
  }

  void _onLoginButtonPressed(BuildContext context) {
    GoRouter.of(context).pushReplacement('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(titleText: 'Signup', leadingWidget: BackWidget()),
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
            CustomInputText(
              labelText: 'Email',
              hintText: 'Enter your email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email),
            ),
            CustomInputText(
              labelText: 'Password',
              hintText: 'Enter your password',
              controller: _passwordController,
              obscureText: true,
              prefixIcon: const Icon(Icons.lock),
            ),
            CustomInputText(
              labelText: 'Confirm Password',
              hintText: 'Confirm your password',
              controller: _confirmPasswordController,
              obscureText: true,
              prefixIcon: const Icon(Icons.lock),
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
