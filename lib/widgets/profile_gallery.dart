import 'package:flutter/material.dart';

class ProfileGalleryWidget extends StatelessWidget {
  final String name;
  ProfileGalleryWidget({super.key, required this.name});
  double fraction = 15;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    if (deviceHeight > deviceWidth) {
      fraction = 15;
    } else {
      fraction = 30;
    }
    return Row(
      children: [
        CircleAvatar(
          radius: MediaQuery.of(context).size.width / fraction,
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
