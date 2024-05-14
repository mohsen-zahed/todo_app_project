import 'package:flutter/material.dart';

class MediaQueries {
  double getWidthMediaQuery(BuildContext context, [double width = 1]) {
    return MediaQuery.of(context).size.width * width;
  }

  double getHeightMediaQuery(BuildContext context, [double height = 1]) {
    return MediaQuery.of(context).size.height * height;
  }
}

final mediaQueries = MediaQueries();
