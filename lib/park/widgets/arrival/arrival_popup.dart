import 'package:fetch/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../common/design/color_pallette.dart';

class ArrivalPopup extends StatefulWidget {
  final Function(DateTime, Duration) onConfirm;

  const ArrivalPopup({super.key, required this.onConfirm});

  @override
  State<ArrivalPopup> createState() => _ArrivalPopupState();
}

class _ArrivalPopupState extends State<ArrivalPopup> {
  DateTime _selectedDateTime = DateTime.now();
  Duration _selectedDuration = const Duration(minutes: 15);
  String error = '';

  void _onConfirm() {
    if (_selectedDateTime.isBefore(
        DateTime.now().subtract(const Duration(hours: 1)))) {
      setState(() {
        error = 'Arrival time cannot be more than 1 hour in the past';
      });
      return;
    }
    widget.onConfirm(_selectedDateTime, _selectedDuration);
  }

  void _onCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'When are you coming?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          // DateTime Picker Button
          CustomButton(
            onPressed: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDateTime,
                firstDate: DateTime.now().subtract(const Duration(hours: 1)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );

              if (pickedDate != null && mounted) {
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
                );

                if (pickedTime != null && mounted) {
                  setState(() {
                    _selectedDateTime = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                    error = '';
                  });
                }
              }
            },
            text: DateFormat.yMd().add_jm().format(_selectedDateTime),
          ),
          const SizedBox(height: 16.0),

          // Duration Toggle
          ToggleButtons(
            borderRadius: BorderRadius.circular(25),
            // Rounded corners
            borderWidth: 2,
            // Border width
            borderColor: AppColors.primaryColor,
            // Border color for unselected buttons
            selectedBorderColor: AppColors.primaryColor,
            // Border color for selected button
            fillColor: AppColors.primaryColor.withOpacity(0.75),
            // Background color for selected button
            selectedColor: Colors.white,
            // Text color for selected button
            color: AppColors.primaryColor,
            // Text color for unselected buttons
            isSelected: [
              _selectedDuration == const Duration(minutes: 15),
              _selectedDuration == const Duration(minutes: 30),
              _selectedDuration == const Duration(minutes: 45),
              _selectedDuration == const Duration(hours: 1),
            ],
            onPressed: (int index) {
              setState(() {
                switch (index) {
                  case 0:
                    _selectedDuration = const Duration(minutes: 15);
                    break;
                  case 1:
                    _selectedDuration = const Duration(minutes: 30);
                    break;
                  case 2:
                    _selectedDuration = const Duration(minutes: 45);
                    break;
                  case 3:
                    _selectedDuration = const Duration(hours: 1);
                    break;
                }
              });
            },
            children: const [
              Text('15m', style: TextStyle(fontSize: 20.0),),
              Text('30m', style: TextStyle(fontSize: 20.0),),
              Text('45m', style: TextStyle(fontSize: 20.0),),
              Text('1h', style: TextStyle(fontSize: 20.0),),
            ],
          ),

          const SizedBox(height: 16.0),

          // Error Message
          Visibility(
            visible: error.isNotEmpty,
            child: SizedBox(
              height: 20.0,
              child: Text(
                error,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(height: 16.0),

          // Confirm and Cancel Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: _onCancel,
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _onConfirm,
                child: const Text('See you there!'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
