import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state/app_state_provider.dart';
import '../providers/app_state/states_utils.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  Future<void> onStartUp(BuildContext context) async {
    final appStateProvider = Provider.of<AppStateProvider>(context, listen: false);
    try {
      await appStateProvider.revalidateUserState();
    } catch (e) {
      appStateProvider.state = AppState.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Adding post-frame callback to ensure onStartUp runs after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onStartUp(context);
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
