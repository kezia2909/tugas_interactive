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
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            height: 200,
            onPageChanged: (index, reason) {
              currentIndexRight = index;
              print("index : $index");
              print("reason : $reason");
            },
            onScrolled: (value) {
              print(
                  "Right=====================================================");
              print("value : $value");
              print("currentValueRight : $currentValueRight");
              print("SCROLL? $isScrolling");
              if (!isScrolling) {
                if (value! > currentValueRight) {
                  isScrolling = true;
                  isFirstTimeRight = false;
                  print(">>>>");
                } else {
                  print("JUMP");
                  isScrolling = false;
                  if (isFirstTimeRight) {
                    currentValueRight = value;
                  }
                  _controllerRight.jumpToPage(currentIndexRight);
                }
              } else {
                // if (value == currentValueRight + 1) {
                //   print("HAHA");
                //   isScrolling = false;
                //   currentValueRight = value!;
                // } else {
                //   print("HOHO");
                //   isScrolling = false;
                // }
                print("LHO");
                if (value! > currentValueRight) {
                  print("LAH");
                  isScrolling = false;
                  _controllerRight.jumpToPage(currentIndexRight);
                  // currentValueRight++;
                }
              }
              setState(() {});
              print("SCROLL2? $isScrolling");
              print("currentValueRight2 : $currentValueRight");
              print("current index : $currentIndexRight");
              // if (value! <= currentValueRight) {
              //   print("yes");
              //   if (isScrolling) {
              //     print("WRONG");
              //     currentValueRight = value.floorToDouble();
              //     print("masuk : $currentValueRight");
              //   } else {
              //     print("STOP : $currentValueRight");
              //     _controllerRight.jumpToPage(currentIndexRight);
              //   }
              //   isScrolling = false;
              // } else {
              //   print("SCROLLL");
              //   isScrolling = true;
              //   currentValueRight = value;
              //   print("currentValueRight : $currentValueRight");
              //   print("currentIndexRight : $currentIndexRight");
              // }
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
                    )
                    // GestureDetector(
                    //   onHorizontalDragStart: (details) {
                    //     print("DRAG");
                    //     print("drag start : $details");
                    //   },
                    //   onHorizontalDragDown: (details) {
                    //     print("DRAG");
                    //     print("drag down : $details");
                    //   },
                    //   onHorizontalDragEnd: (details) {
                    //     print("DRAG");
                    //     print("drag end : $details");
                    //   },
                    //   onHorizontalDragCancel: () {
                    //     print("DRAG");
                    //     print("drag cancel");
                    //   },
                    //   onHorizontalDragUpdate: (details) {
                    //     print("DRAG");
                    //     print("drag update : $details");
                    //   },
                    //   child: Container(
                    //       width: MediaQuery.of(context).size.width,
                    //       margin: EdgeInsets.symmetric(horizontal: 5.0),
                    //       decoration: BoxDecoration(color: Colors.amber),
                    //       child: Text(
                    //         'text $i',
                    //         style: TextStyle(fontSize: 16.0),
                    //       )),
                    );
              },
            );
          }).toList(),
        ),
        // // both side
        // CarouselSlider(
        //   options: CarouselOptions(height: 200),
        //   items: listOfItemsBoth.map((i) {
        //     return Builder(
        //       builder: (BuildContext context) {
        //         return Container(
        //             width: MediaQuery.of(context).size.width,
        //             margin: EdgeInsets.symmetric(horizontal: 5.0),
        //             decoration: BoxDecoration(color: Colors.amber),
        //             child: Text(
        //               'text $i',
        //               style: TextStyle(fontSize: 16.0),
        //             ));
        //       },
        //     );
        //   }).toList(),
        // ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listOfItemsBoth.length,
            itemBuilder: (context, index) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Text(
                    'text ${listOfItemsBoth[index]}',
                    style: TextStyle(fontSize: 16.0),
                  ));
            },
          ),
        )
        // GestureDetector(
        //   onHorizontalDragStart: (details) {
        //     print("drag start");
        //     setState(() {
        //       isScrolling = true;
        //     });
        //   },
        //   onHorizontalDragEnd: (details) {
        //     print("drag end");
        //     setState(() {
        //       isScrolling = true;
        //     });
        //   },
        //   onHorizontalDragCancel: () {
        //     print("drag Cancel");
        //   },
        // )
      ],
    );
  }
}
