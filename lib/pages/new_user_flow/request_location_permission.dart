import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/app_state/app_state_provider.dart';
import '../../providers/location_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_widget.dart';

class LocationPermissionPage extends StatelessWidget {
  const LocationPermissionPage({super.key});

  Future<void> requestLocationPermission(context) async {
    final LocationProvider locationProvider = LocationProvider();
    String request = await locationProvider.getLocation();

    if(request == "success") {
      final appProvider = Provider.of<AppStateProvider>(context, listen: false);
      await appProvider.validateUserDataAndState();
      GoRouter.of(context).go('/');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error requesting location permissions: $request'),
      ),
    );
  }

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
              headerText: 'The app needs access to your location to work.',
              subheaderText: '',
            ),
            const TextWidget(
              headerText: '',
              subheaderText:
                  'To help you find great parks near you and personalize your '
                  'experience, we need access to your location. '
                  'You can always change your mind and revoke access in the settings.'
                  '\n\n'
                  'Thank you for using our app!',
            ),
            CustomButton(
              text: 'Next',
              onPressed: () {
                requestLocationPermission(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
