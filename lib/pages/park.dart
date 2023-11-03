import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class ParkPage extends StatelessWidget {
  const ParkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Park Page'),
        actions: <Widget>[
          // Add a logout button to the AppBar
          IconButton(
            icon: const Icon(Icons.logout),
            // You can use any logout icon you prefer
            onPressed: () {
              authProvider.logOut();
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
