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
  double currentValueLeft = 10000;
  int currentIndexLeft = 0;
  CarouselController _controllerLeft = CarouselController();
  double currentValueRight = 10000;
  int currentIndexRight = 0;
  CarouselController _controllerRight = CarouselController();

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
              currentIndexLeft = index;
              print("index : $index");
              print("reason : $reason");
            },
            onScrolled: (value) {
              print("LEFT");
              print("value : $value");
              if (value! >= currentValueLeft) {
                print("yes");
                _controllerLeft.jumpToPage(currentIndexLeft);
              } else {
                currentValueLeft = value.floorToDouble();
                print("currentValueLeft : $currentValueLeft");
                print("currentIndexLeft : $currentIndexLeft");
              }
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
              currentIndexRight = index;
              print("index : $index");
              print("reason : $reason");
            },
            onScrolled: (value) {
              print("Right");
              print("value : $value");
              print("currentValueRight : $currentValueRight");

              if (value! <= currentValueRight) {
                print("yes");
                _controllerRight.jumpToPage(currentIndexRight);
              } else {
                currentValueRight = value;
                print("currentValueRight : $currentValueRight");
                print("currentIndexRight : $currentIndexRight");
              }
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
