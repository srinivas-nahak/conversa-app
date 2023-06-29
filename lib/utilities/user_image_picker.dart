import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messaging_app/utilities/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({required this.onPickImage, super.key});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  Border? _errorImageBorder;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      // imageQuality: 70,
      maxWidth: 150,
    );

    // if (pickedImage == null) {
    //   return;
    // }

    setState(() {
      if (pickedImage == null) {
        _errorImageBorder = Border.all(
            color: Colors.redAccent,
            width: 1.5,
            strokeAlign: BorderSide.strokeAlignOutside);
        return;
      }

      _pickedImage = File(pickedImage.path);

      _errorImageBorder = null;

      //Passing the image file to the parent widget
      widget.onPickImage(_pickedImage!);
    });
  }

  // GestureDetector(
  // onTap: _pickImage,
  // child: CircleAvatar(
  // radius: 40.sp,
  // backgroundColor: kPrimaryColor.withOpacity(0.5),
  // foregroundImage:
  // _pickedImage != null ? FileImage(_pickedImage!) : null,
  // ),
  // ),

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 48.sp,
            width: 48.sp,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              border: _errorImageBorder,
              borderRadius: BorderRadius.circular(30.sp),
            ),
            clipBehavior: Clip.antiAlias,
            child: _pickedImage != null
                ? Image.file(
                    _pickedImage!,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/images/avatar_placeholder.png",
                    fit: BoxFit.cover,
                  ),
          ),
          Transform.translate(
            offset: const Offset(2.0, 2.0),
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: kButtonColor,
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 17,
                color: kScaffoldBgColor,
              ),
            ),
          ),

          // TextButton.icon(
          //   onPressed: _pickImage,
          //   icon: const Icon(
          //     Icons.create,
          //     color: kPrimaryColor,
          //   ),
          //   label: Text(
          //     "Add Image",
          //     style: kBodyTextStyle,
          //   ),
          // ),
        ],
      ),
    );
  }
}
