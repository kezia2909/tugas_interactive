import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_utils.dart';
import 'package:flutter_application_1/widgets/image_gallery.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<String> listOfItemsLeft = [
    "https://i.pinimg.com/736x/e9/39/6e/e9396e2a31207a4afe5d3a552e845a1e.jpg",
    "https://i.pinimg.com/736x/3d/15/aa/3d15aacca9e6606b87bdd3a5b4e787f7.jpg",
    "https://www.pacificlicensing.com/sites/default/files/brand/WBB.jpg",
    "https://i.pinimg.com/736x/c5/ee/b0/c5eeb05ec0c00804e94c5c9d0050e595.jpg",
    "https://imageservice.sky.com/contentid/A5EK7jm4V1685AXJN2kWh/LAND_16_9?language=eng&output-format=jpg&output-quality=19&proposition=NOWTV&territory=GB&version=7811abef-b4c8-3540-b06b-da57b666c969",
    "https://media.tenor.com/NgtnDhMIlQYAAAAC/ouch-grizzly.gif",
    "https://cdn.wallpapersafari.com/36/73/XHA6xh.jpg"
  ];
  List<String> listOfItemsRight = [
    "https://cutewallpaper.org/21/ice-bear-we-bare-bears-wallpapers/Ice-Bear-Wallpapers-Top-Free-Ice-Bear-Backgrounds-.jpg",
    "https://wallpapercave.com/wp/wp3964691.jpg",
    "https://getwallpapers.com/wallpaper/full/2/6/1/63392.jpg",
    "https://getwallpapers.com/wallpaper/full/e/0/0/63531.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFJeuu6Wo8USsi-nbapkZg8vr0S-Mz5I28quv9FHIDTsuofeeEdm2yPVulGIorfiSrxow&usqp=CAU",
    "https://e0.pxfuel.com/wallpapers/621/563/desktop-wallpaper-we-bare-bears.jpg",
  ];
  List<String> listOfItemsBoth = [
    "https://wallpapercave.com/wp/wp1874732.jpg",
    "https://i.pinimg.com/1200x/23/84/5d/23845d15565dc32ac7d0666bf82a109d.jpg",
    "https://i.pinimg.com/564x/f0/13/0e/f0130e52e116fc9fc4063dc999513ca3.jpg",
    "https://cdn.pnghd.pics/data/233/foto-we-bare-bears-panda-27.png"
  ];
  double currentValueLeft = 10000;
  int currentIndexLeft = 0;
  CarouselController _controllerLeft = CarouselController();
  double currentValueRight = 10000;
  int currentIndexRight = 0;
  CarouselController _controllerRight = CarouselController();
  CarouselController _controllerBoth = CarouselController();
  bool isScrolling = false;
  bool isFirstTimeRight = true;

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
                  Expanded(
                    child: CarouselSlider(
                      carouselController: _controllerLeft,
                      options: CarouselOptions(
                        aspectRatio: 2,
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
                      items: listOfItemsLeft.map((url) {
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
                  Expanded(
                    child: CarouselSlider(
                      carouselController: _controllerRight,
                      options: CarouselOptions(
                        aspectRatio: 2.0,
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
                      items: listOfItemsRight.map((url) {
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
                  Expanded(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                      items: listOfItemsBoth.map((url) {
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
