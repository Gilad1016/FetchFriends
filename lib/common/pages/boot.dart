import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state/app_state_provider.dart';

class BootPage extends StatefulWidget {
  const BootPage({super.key});

  @override
  State<BootPage> createState() => _BootPageState();
}

class _BootPageState extends State<BootPage> {
  late AppStateProvider _appProvider;

  void onStartUp() async {
    //WAIT 1 SECOND
    final wait = Future.delayed(const Duration(seconds: 1));
    // TODO: REMOVE WAIT
    await _appProvider.validateUserDataAndState();
    await wait;
  }

  @override
  void initState() {
    super.initState();
    _appProvider = Provider.of<AppStateProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) => onStartUp());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
