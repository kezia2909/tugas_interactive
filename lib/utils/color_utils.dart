import 'package:flutter/material.dart';

hexStringToColor(String hexColor, double opacityValue) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16)).withOpacity(opacityValue);
}

String colorGrizzly = "grizzly";
String colorPanda = "panda";
String colorIcebear = "icebear";
String colorWhite = "white";
String colorBlack = "black";
String colorAccent = "accent";

String hexGrizzly = "FFE0AC";
String hexPanda = "FFACB7";
String hexIcebear = "6886C5";
String hexWhite = "F3F3F3";
String hexBlack = "0C0C0C";
String hexAccent = "787878";

colorTheme(String type, {double opacity = 1.0}) {
  if (type == colorGrizzly) {
    return hexStringToColor(hexGrizzly, opacity);
  } else if (type == colorPanda) {
    return hexStringToColor(hexPanda, opacity);
  } else if (type == colorIcebear) {
    return hexStringToColor(hexIcebear, opacity);
  } else if (type == colorWhite) {
    return hexStringToColor(hexWhite, opacity);
  } else if (type == colorBlack) {
    return hexStringToColor(hexBlack, opacity);
  } else if (type == colorAccent) {
    return hexStringToColor(hexAccent, opacity);
  }
}
