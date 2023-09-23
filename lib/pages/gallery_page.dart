import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<String> listOfItemsLeft = ["1", "2", "3", "4", "5"];
  List<String> listOfItemsRight = ["A", "B", "C", "D", "E"];
  List<String> listOfItemsBoth = ["A1", "B2", "C3", "D4", "E5"];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // left only
        CarouselSlider(
          options: CarouselOptions(height: 200),
          items: listOfItemsLeft.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Text(
                      'text $i',
                      style: TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        ),
        // right only
        CarouselSlider(
          options: CarouselOptions(height: 200),
          items: listOfItemsRight.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Text(
                      'text $i',
                      style: TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        ),
        // both side
        CarouselSlider(
          options: CarouselOptions(height: 200),
          items: listOfItemsBoth.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Text(
                      'text $i',
                      style: TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
