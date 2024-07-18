import 'package:flutter/material.dart';
import 'circular_back_component.dart';

import '../utils/styles.dart';
import '../utils/colours.dart';
import '../widgets/text_style.dart';
import '../functions/calculate_views.dart';

class InteractiveField extends StatelessWidget {
  final String likecount;

  const InteractiveField({
    super.key,
    required this.likecount,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        CircularField(
          widget: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.thumb_up_alt_outlined,
                size: 20,
                color: kPrimaryDarkColor,
              ),
              // Add spacing between icon and text
              SizedBox(
                width: size.width * 0.016,
              ),
              BuildText(
                text: formatViews(
                  likecount,
                ),
                fontSize: FontSizes.smallTextSize(context),
                fontWeight: FontWeight.bold,
                textStyle: StyleText.baseTextStyle_3,
              ),

              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: size.width * 0.016,
                ),
                width: 1.2,
                color: kPrimaryDarkColor, // Set the color of the line
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              const Icon(
                Icons.thumb_down_alt_outlined,
                size: 20,
                color: kPrimaryDarkColor,
              ),
            ],
          ),
        ),
        CircularField(
          widget: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.ios_share_outlined,
                size: 20,
                color: kPrimaryDarkColor,
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              BuildText(
                text: 'Share',
                fontSize: FontSizes.smallTextSize(context),
                fontWeight: FontWeight.bold,
                textStyle: StyleText.baseTextStyle_3,
              ),
            ],
          ),
        ),
        CircularField(
          widget: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.download_outlined,
                size: 20,
                color: kPrimaryDarkColor,
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              BuildText(
                text: 'Download',
                fontSize: FontSizes.smallTextSize(context),
                fontWeight: FontWeight.bold,
                textStyle: StyleText.baseTextStyle_3,
              ),
            ],
          ),
        ),
        CircularField(
          widget: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.bookmark_outline_outlined,
                size: 20,
                color: kPrimaryDarkColor,
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              BuildText(
                text: 'Save',
                fontSize: FontSizes.smallTextSize(context),
                fontWeight: FontWeight.bold,
                textStyle: StyleText.baseTextStyle_3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
