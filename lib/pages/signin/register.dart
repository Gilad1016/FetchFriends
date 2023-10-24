import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dogy_park/widgets/inputs/camera_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String dogName = '';
  String parentName = '';
  List<String> selectedOptions = [];
  int energyLevel = 1;

  late File? selectedImage = null;

  List<String> dogConditions = [
    'Healthy',
    'Allergies',
    'Joint Issues',
    'Digestive Problems',
    'Other',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform actions with the form data and image
    }
  }

  void _onImageSelected(File? image) {
    setState(() {
      selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CameraForm(selectedImage: selectedImage, onImageSelected: _onImageSelected),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Dog Name'),
                    onChanged: (value) {
                      setState(() {
                        dogName = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the dog\'s name.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Dog Owner's Name"),
                    onChanged: (value) {
                      setState(() {
                        parentName = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the dog owner's name.";
                      }
                      return null;
                    },
                  ),
                  Wrap(
                    spacing: 10,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            energyLevel = index + 1;
                          });
                        },
                        child: Icon(
                          Icons.sports_baseball,
                          color: energyLevel >= index + 1 ? const Color(0xffccff00) : Colors.grey,
                          size: 45,
                          // shadows: const <Shadow>[Shadow(
                          //     color: Colors.grey,
                          //     blurRadius: 25.0,
                          //     offset: Offset(5.0, 5.0)
                          // )],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: dogConditions.map((condition) {
                      return ChoiceChip(
                        label: Text(condition),
                        selected: selectedOptions.contains(condition),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedOptions.add(condition);
                            } else {
                              selectedOptions.remove(condition);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: RegisterPage()));
}
