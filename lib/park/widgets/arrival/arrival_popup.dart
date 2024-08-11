import '../../../common/design/color_pallette.dart';
import 'package:flutter/material.dart';

class ArrivalPopup extends StatefulWidget {
  final Function() onButtonPressed;

  const ArrivalPopup({super.key, required this.onButtonPressed});

  @override
  State<ArrivalPopup> createState() => _ArrivalPopupState();
}

class _ArrivalPopupState extends State<ArrivalPopup> {
  final DateTime _arrivalTime = DateTime.now();
  int _arrivalDay = 0;
  String error = '';

  onButtonPressed() async {
    //TODO: handle logic for finding my park
    // final parks = await dataProvider.getParks();

    DateTime arrivalTime = _arrivalTime;
    arrivalTime = arrivalTime.add(Duration(days: _arrivalDay));
    if (arrivalTime.isBefore(DateTime.now())) {
      error = 'Arrival time must be in the future';
      return;
    }

    // ArrivalItem arrival = ArrivalItem(
    //   time: arrivalTime,
      // parkId: parks[0].id,
    // );

    // for (var dog in myDogs!) {
    //   dog.arrival = arrival;
    //   dataProvider.updateDog(dog);
    // }

    // Close popup based on widget callback
    setState(() {
      widget.onButtonPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'When will you arrive?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16.0),
          // Time picker spinner
          // TimePickerSpinner(
          //   time: _arrivalTime,
          //   is24HourMode: true,
          //   onTimeChange: (newTime) {
          //     setState(() {
          //       _arrivalTime = newTime;
          //     });
          //   },
          //   normalTextStyle: const TextStyle(
          //     fontSize: 28,
          //     color: AppColors.accentColor,
          //   ),
          //   highlightedTextStyle: const TextStyle(
          //     fontSize: 32,
          //     color: AppColors.primaryColor,
          //   ),
          //   alignment: Alignment.center,
          // ),
          const SizedBox(height: 16.0),

          DropdownButtonFormField<int>(
            value: _arrivalDay,
            decoration: const InputDecoration(
              labelText: 'Arrival Type',
            ),
            items: const [
              DropdownMenuItem(
                value: 0,
                child: Text('Coming today!'),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text('I\'ll arrive tomorrow'),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text('I\'ll arrive in 2 days'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _arrivalDay = value ?? 0;
              });
            },
          ),
          const SizedBox(height: 16.0),
          Visibility(
              visible: error.isNotEmpty,
              child: SizedBox(
                  height: 20.0,
                  child:
                      Text(error, style: const TextStyle(color: Colors.red)))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => widget.onButtonPressed(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => onButtonPressed(),
                child: const Text('Confirm'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
