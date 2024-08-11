import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraForm extends StatefulWidget {
  final String? selectedImage;
  final void Function(String? image) onImageSelected;

  const CameraForm(
      {super.key, required this.selectedImage, required this.onImageSelected});

  @override
  CameraFormState createState() => CameraFormState();
}

class CameraFormState extends State<CameraForm> {
  late final ImagePicker _picker;
  late String? _selectedImage = widget.selectedImage;

  CameraFormState() : _picker = ImagePicker();

  Future<void> _takePicture() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      _selectedImage = image?.path;
      if (image != null) {
        final File file = File(image.path);
        final String fileName = image.path.split('/').last;
        final String filePath = 'images/$fileName';
        final File newImage = await file.copy(filePath);
        setState(() {
          widget.onImageSelected(newImage.path);
        });
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _uploadPicture() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      _selectedImage = image?.path;
      if (image != null) {
        // final File file = File(image.path);
        final String fileName = image.path.split('/').last;
        final String filePath = 'images/$fileName';
        // final File newImage = await file.copy(filePath);
        setState(() {
          widget.onImageSelected(filePath);
        });
      }
    } catch (e) {
      print('Error uploading picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a Picture'),
                  onTap: () {
                    _takePicture();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    _uploadPicture();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
        child: _selectedImage == null
            ? const Icon(
                Icons.add_a_photo,
                size: 60,
                color: Colors.grey,
              )
            : ClipOval(
                child: Image.asset(
                  _selectedImage!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
