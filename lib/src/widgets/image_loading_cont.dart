import 'package:flutter/material.dart';
import '../utils/colours.dart';

Widget buildLoadingContainer() {
  return const Center(
    child: CircularProgressIndicator(
      strokeWidth: 3.0,
      color: kPrimaryDarkShade,
      valueColor: AlwaysStoppedAnimation<Color>(
        kPrimaryDarkShade,
      ),
    ),
  );
}
