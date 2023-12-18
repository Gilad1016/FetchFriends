import 'package:dogy_park/models/dog_item.dart';
import 'package:dogy_park/providers/auth_provider.dart';
import 'package:dogy_park/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../design/color_pallette.dart';

class DogTile extends StatefulWidget {
  final DogItem dogItem;
  final Null Function() onPressed;

  const DogTile({
    required this.dogItem,
    required this.onPressed,
    super.key,
  });

  @override
  State<DogTile> createState() => _DogTileState(dogItem, onPressed);
}

class _DogTileState extends State<DogTile> {
  late final DataProvider dataProvider;
  late final AuthProvider authProvider;
  late final String? userToken;
  late final DogItem dogItem;
  late final Null Function() onPressed;

  _DogTileState(this.dogItem, this.onPressed);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onStartUp(context));
  }

  onStartUp(BuildContext context) async {
    dataProvider = Provider.of<DataProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: TextButton(
        onPressed: () => {}, // Update to your actual onPressed handler
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(
              color: AppColors.accentColor, // Border color
              width: 5, // Outline width
            ),
          ),
        ),
        child: Column(
          children: [
            (dogItem.imageUrl != null)
                ? CircleAvatar(
                    backgroundImage: NetworkImage(dogItem.imageUrl!),
                    minRadius: 100,
                    maxRadius: 100,
                  )
                : const SizedBox(width: 50), // Placeholder if no image
            const SizedBox(width: 10),
            Text(
              dogItem.name,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: AppColors.primaryColor, // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
