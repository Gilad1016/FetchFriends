import 'package:dogy_park/widgets/arrival_button.dart';
import 'package:dogy_park/widgets/nav_bar_archive/nav_bar_button.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});
//TODO: fix the background covering entire screen
  //currently not used
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: false,
        floatingActionButton: const ArrivalButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NavBarButton(
                  text: '    🏠\n Home',
                  onPressed: () => Navigator.pushNamed(context, '/home')),
              NavBarButton(
                  text: '    🔍\n Search',
                  onPressed: () => Navigator.pushNamed(context, '/search')),
              NavBarButton(text: '', onPressed: () => ()),
            ],
          ),
        ));
  }
}
