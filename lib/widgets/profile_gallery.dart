import 'package:flutter/material.dart';

class ProfileGalleryWidget extends StatelessWidget {
  final String name;
  const ProfileGalleryWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: MediaQuery.of(context).size.width / 15,
          backgroundImage: AssetImage(
              'assets/images/${name.replaceAll(RegExp(r' '), '').toLowerCase()}_profile.jpg'),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
