import 'package:fetch/common/widgets/top_bar/app_bar.dart';
import 'package:flutter/material.dart';
import '../common/design/color_pallette.dart';
import '../common/widgets/top_bar/back_button.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        titleText: 'About fetch',
        leadingWidget: BackWidget(),
      ),
      body: Padding(
        padding: EdgeInsets.all(64.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About the App',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Fetch is a small social project I recently worked on. Its purpose is to help us, dog owners, come together and make our and our dogs’ lives better.',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'If you have any requests, suggestions, or bugs to report, please feel free to use the feedback button or to reach out through my email:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'gilad.omesi@gmail.com.',
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(height: 16),
            Text(
              'We hope you enjoy using Fetch and find it helpful in connecting with other dog owners in our community. Your feedback is important to us as we continue to improve the app and make it as welcoming and useful as possible.',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
