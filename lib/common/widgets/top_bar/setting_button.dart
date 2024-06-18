import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../auth/auth_provider.dart';
import '../../design/color_pallette.dart';
import '../../router/routes_utils.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return PopupMenuButton(
      icon: const Icon(CupertinoIcons.ellipsis,
          size: 24, color: AppColors.secondaryColor),
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
            GoRouter.of(context).pushNamed(AppPage.profile.toName);
            break;
          case 2:
            authProvider.logOut();
            break;
        }
      },
    );
  }
}
