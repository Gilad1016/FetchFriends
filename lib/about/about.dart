import 'package:fetch/common/widgets/top_bar/app_bar.dart';
import 'package:flutter/material.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 32 ,vertical: 48),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fetch is a small social project I recently worked on. Its purpose is to help us, dog owners, come together and make our and our dogs’ lives better.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'If you have any requests, suggestions, or bugs to report, please feel free to use the feedback button or to reach out through my email:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'gilad.omesi@gmail.com.',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'We hope you enjoy using Fetch and find it helpful in connecting with other dog owners in our community. Your feedback is important to us as we continue to improve the app and make it as welcoming and useful as possible.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
    );
  }
}
