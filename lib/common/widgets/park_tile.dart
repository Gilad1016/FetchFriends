import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../park/park_item.dart';
import '../design/color_pallette.dart';

class ParkTile extends StatelessWidget {
  final ParkItem parkItem;
  final void Function(ParkItem) onSavePark;

  const ParkTile({
    super.key,
    required this.parkItem,
    required this.onSavePark,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(parkItem.name),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(
          width: 5.0,
          color: AppColors.primaryColor,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      titleTextStyle: const TextStyle(
        color: AppColors.secondaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => _launchMapsUrl(parkItem.mapsURL, context),
            style: TextButton.styleFrom(
              shape: const CircleBorder(
                side: BorderSide(
                  width: 5.0,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            child: const Text(
              '📍',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          TextButton(
            onPressed: () => onSavePark(parkItem),
            style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  side: BorderSide(
                    width: 5.0,
                    color: AppColors.secondaryColor,
                  )),
            ),
            child: const Text(
              '🤍 save',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchMapsUrl(Uri url, context) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to open $url'),
        ),
      );
    }
  }
}
