import 'package:dogy_park/providers/router/routes_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class ErrorPage extends StatelessWidget {
  final String? error;
  const ErrorPage({
    super.key,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppPage.error.toTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error ?? ""),
            TextButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(AppPage.parkHome.toName);
              },
              child: const Text(
                  "Back to Home"
              ),
            ),
          ],
        ),
      ),
    );
  }
}