import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/utils/color_utils.dart';
import 'package:flutter_application_1/widgets/image_gallery.dart';
import 'package:flutter_application_1/widgets/profile_gallery.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<String> listOfGrizzly = [];
  List<String> listOfIcebear = [];
  List<String> listOfPanda = [];

  double currentValueLeft = 10000;
  int currentIndexLeft = 0;
  CarouselController _controllerLeft = CarouselController();
  double currentValueRight = 10000;
  int currentIndexRight = 0;
  CarouselController _controllerRight = CarouselController();
  CarouselController _controllerBoth = CarouselController();
  bool isScrolling = false;
  bool isFirstTimeRight = true;
  double aspectRatio = 3 / 1;
  double viewFraction = 1 / 3;

  Future<void> loadAssets() async {
    final assetsGrizz = await getImageAssets("grizz");
    final assetsIcebear = await getImageAssets("icebear");
    final assetsPanda = await getImageAssets("panda");
    setState(() {
      listOfGrizzly = assetsGrizz;
      listOfIcebear = assetsIcebear;
      listOfPanda = assetsPanda;
    });
  }

  Future<List<String>> getImageAssets(String folder) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final manifestMap = json.decode(manifestContent);
    final imageAssets = manifestMap.keys
        .where((String key) =>
            key.startsWith('assets/images/$folder/') &&
            (key.endsWith('.jpg') ||
                key.endsWith('.jpeg') ||
                key.endsWith('.png') ||
                key.endsWith('.gif')))
        .toList();
    return imageAssets;
  }

  @override
  void initState() {
    super.initState();
    loadAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorTheme(colorAccent),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // left only
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 8),
              color: colorTheme(colorGrizzly),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ProfileGalleryWidget(
                      name: "Grizz",
                    ),
                  ),
                  Expanded(
                    child: CarouselSlider(
                      carouselController: _controllerLeft,
                      options: CarouselOptions(
                        aspectRatio: aspectRatio,
                        viewportFraction: viewFraction,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          currentIndexLeft = index;

                          isScrolling = false;
                          setState(() {});
                        },
                        onScrolled: (value) {
                          if (value! >= currentValueLeft) {
                            _controllerLeft.jumpToPage(currentIndexLeft);
                            currentValueLeft = value.ceilToDouble();
                          } else {
                            currentValueLeft = value;
                          }
                        },
                      ),
                      items: listOfGrizzly.map((url) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ImageGalleryWidget(
                              url: url,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Center(child: Text("swipe to right >>")),
                ],
              ),
            ),
          ),
          // right only

          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 8),
              color: colorTheme(colorIcebear),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ProfileGalleryWidget(
                      name: "Ice Bear",
                    ),
                  ),
                  Expanded(
                    child: CarouselSlider(
                      carouselController: _controllerRight,
                      options: CarouselOptions(
                        aspectRatio: aspectRatio,
                        viewportFraction: viewFraction,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          currentIndexRight = index;

                          setState(() {});
                        },
                        onScrolled: (value) {
                          if (value! <= currentValueRight) {
                            _controllerRight.jumpToPage(currentIndexRight);
                            currentValueRight = value.floorToDouble();
                          } else {
                            currentValueRight = value;
                          }
                        },
                      ),
                      items: listOfIcebear.map((url) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ImageGalleryWidget(
                              url: url,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Center(child: Text("<< swipe to left")),
                ],
              ),
            ),
          ),

          // both side
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 8),
              color: colorTheme(colorPanda),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ProfileGalleryWidget(
                      name: "Panda",
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     CircleAvatar(
                  //       radius: MediaQuery.of(context).size.width / 15,
                  //       backgroundImage:
                  //           AssetImage('assets/images/grizz_profile.jpg'),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Text("Panda"),
                  //   ],
                  // ),
                  Expanded(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: aspectRatio,
                        viewportFraction: viewFraction,
                        enlargeCenterPage: true,
                      ),
                      items: listOfPanda.map((url) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ImageGalleryWidget(
                              url: url,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Center(child: Text("<< swipe left or right >>"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
