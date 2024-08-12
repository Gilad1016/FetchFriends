import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'common/providers/router/routes_utils.dart';
import 'common/widgets/custom_button.dart';
import 'common/widgets/text_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 28, right: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const TextWidget(
              headerText: 'Hello!',
              subheaderText: 'Find out \'Who let the dogs out?\' \nand where?',
            ),
            CustomButton(
              text: 'Join app',
              onPressed: () {
                GoRouter.of(context).pushNamed(AppPage.addDog.toName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
