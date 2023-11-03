import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraForm extends StatefulWidget {
  final File? selectedImage;
  final void Function(File? image) onImageSelected;

  const CameraForm({super.key, required this.selectedImage, required this.onImageSelected});

  @override
  CameraFormState createState() => CameraFormState(); // Change the class name here
}

class CameraFormState extends State<CameraForm> {
  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      widget.onImageSelected(image != null ? File(image.path) : null);
    });
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
        child: widget.selectedImage == null
            ? const Icon(
                Icons.add_a_photo,
                size: 60,
                color: Colors.grey,
              )
            : ClipOval(
                child: Image.file(
                  widget.selectedImage!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
