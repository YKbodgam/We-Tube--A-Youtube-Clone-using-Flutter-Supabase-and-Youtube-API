import 'package:flutter/material.dart';

import '../../utils/styles.dart';
import 'package:youtube/src/models/video_model.dart';

class ShowDescriptionText extends StatelessWidget {
  const ShowDescriptionText({
    super.key,
    required this.size,
    required this.video,
  });

  final Size size;
  final VideoPreview video;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.02,
      ),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Text(
        video.description,
        style: StyleText.baseTextStyle_2.copyWith(
          fontSize: FontSizes.mediumSmallTextSize(context),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
