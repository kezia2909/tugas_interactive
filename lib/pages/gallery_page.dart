import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
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
  double currentValueLeft = 10000;
  int currentIndexLeft = 0;
  CarouselController _controllerLeft = CarouselController();
  double currentValueRight = 10000;
  int currentIndexRight = 0;
  CarouselController _controllerRight = CarouselController();
  bool isScrolling = false;
  bool isFirstTimeRight = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // left only
        CarouselSlider(
          carouselController: _controllerLeft,
          options: CarouselOptions(
            height: 200,
            onPageChanged: (index, reason) {
              print("CHANGE");
              currentIndexLeft = index;
              print("index : $index");
              print("reason : $reason");
              isScrolling = false;
              setState(() {});
            },
            onScrolled: (value) {
              print("Value : $value");
              print("current : $currentValueLeft");
              if (value! >= currentValueLeft) {
                _controllerLeft.jumpToPage(currentIndexLeft);
                currentValueLeft = value.ceilToDouble();
              } else {
                currentValueLeft = value;
              }
              print("Value 2: $value");
              print("current 2: $currentValueLeft");
            },
          ),
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
          carouselController: _controllerRight,
          options: CarouselOptions(
            height: 200,
            onPageChanged: (index, reason) {
              print("CHANGE");
              currentIndexRight = index;
              print("index : $index");
              print("reason : $reason");
              setState(() {});
            },
            onScrolled: (value) {
              print("Value : $value");
              print("current : $currentValueRight");
              if (value! <= currentValueRight) {
                _controllerRight.jumpToPage(currentIndexRight);
                currentValueRight = value.floorToDouble();
              } else {
                currentValueRight = value;
              }
              print("Value 2: $value");
              print("current 2: $currentValueRight");
            },
          ),
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
