import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleText {
  //

  static TextStyle baseTextStyle_1 = GoogleFonts.montserrat(
    textStyle: const TextStyle(), // Base style properties if any
  );

  static TextStyle baseTextStyle_2 = GoogleFonts.nunito(
    textStyle: const TextStyle(),
  );

  static TextStyle baseTextStyle_3 = GoogleFonts.poppins(
    textStyle: const TextStyle(),
  );
}

class FontSizes {
  //

  static double veryLargeTextSize(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.07; // 28

  static double largeTextSize(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.06; // 24

  static double regularTextSize(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.05; // 20

  static double mediumLargeTextSize(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.045; // 18

  static double mediumTextSize(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.04; // 16

  static double mediumSmallTextSize(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.035; // 14

  static double smallTextSize(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.03; // 12
}
