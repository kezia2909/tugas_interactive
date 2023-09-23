import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

String colorGrizzly = "grizzly";
String colorPanda = "panda";
String colorIcebear = "icebear";
String colorBackground = "background";

String hexGrizzly = "FFE0AC";
String hexPanda = "FFACB7";
String hexIcebear = "6886C5";
String hexBackground = "F9F9F9";

colorTheme(String type) {
  if (type == colorGrizzly) {
    return hexStringToColor(hexGrizzly);
  } else if (type == colorPanda) {
    return hexStringToColor(hexPanda);
  } else if (type == colorIcebear) {
    return hexStringToColor(hexIcebear);
  } else if (type == colorBackground) {
    return hexStringToColor(hexBackground);
  }
}
