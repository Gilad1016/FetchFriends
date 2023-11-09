import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return PopupMenuButton(
      icon: const Icon(
        CupertinoIcons.ellipsis,
        size: 20,
        color: Colors.black,
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text(
            '🐶 Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text(
            '👋 Logout',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            //TODO: create profile page and navigate to it
            break;
          case 2:
            authProvider.logOut();
            break;
        }
      },
    );
  }
}
