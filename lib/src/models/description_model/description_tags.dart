import 'package:flutter/material.dart';

import 'package:youtube/src/models/video_model.dart';

import '../../utils/styles.dart';
import '../../widgets/text_style.dart';

class UsedVideoTags extends StatelessWidget {
  const UsedVideoTags({
    super.key,
    required this.size,
    required this.video,
  });

  final Size size;
  final VideoPreview video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.01),
      child: video.tags.isNotEmpty
          ? Wrap(
              spacing: 8.0, // Adjust spacing between hashtags as needed
              children: video.tags
                  .where((hashtag) => hashtag.isNotEmpty)
                  .map((hashtag) {
                return BuildText(
                  text: "#$hashtag",
                  color: Colors.blue.withOpacity(0.6),
                  fontSize: FontSizes.mediumSmallTextSize(context),
                  fontWeight: FontWeight.bold,
                  textStyle: StyleText.baseTextStyle_1,
                );
              }).toList(),
            )
          : const Spacer(),
    );
  }
}
