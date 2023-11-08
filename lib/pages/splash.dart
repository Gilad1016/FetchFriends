import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ super.key });

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AppStateProvider _appProvider;

  @override
  void initState() {
    _appProvider = Provider.of<AppStateProvider>(context, listen: false);
    // onStartUp();
    super.initState();
  }

  void onStartUp() async {
    await _appProvider.onAppStart();
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