import 'package:flutter/material.dart';

class ImageGalleryWidget extends StatelessWidget {
  final String url;
  const ImageGalleryWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
            alignment: Alignment.center,
            image: NetworkImage(url),
            fit: BoxFit.cover),
      ),
    );
  }
}
