import 'package:flutter/material.dart';

class ParkPage extends StatelessWidget {
  const ParkPage({super.key});

  // Add a function to handle the logout action
  void _onLogoutPressed(BuildContext context) {
    // Perform the sign-out logic (e.g., using FirebaseAuth)
    // After successful sign-out, navigate to the landing page
    Navigator.pushReplacementNamed(context, '/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Park Page'),
        actions: <Widget>[
          // Add a logout button to the AppBar
          IconButton(
            icon: const Icon(Icons.logout), // You can use any logout icon you prefer
            onPressed: () {
              _onLogoutPressed(context);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to the Park page'),
      ),
    );
  }
}
