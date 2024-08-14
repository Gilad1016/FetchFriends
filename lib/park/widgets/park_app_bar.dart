import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/design/color_pallette.dart';
import '../park_provider.dart';

class ParkAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ParkAppBar({super.key});

  @override
  State<ParkAppBar> createState() => _ParkAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ParkAppBarState extends State<ParkAppBar> {
  late ParkProvider _parkProvider;

  @override
  Widget build(BuildContext context) {
    _parkProvider = Provider.of<ParkProvider>(context);

    return AppBar(
      title: Text(
        _parkProvider.currentPark.name,
        style: const TextStyle(
          color: AppColors.primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          _parkProvider.previousPark();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            _parkProvider.nextPark();
          },
        ),
      ],
    );
  }
}
