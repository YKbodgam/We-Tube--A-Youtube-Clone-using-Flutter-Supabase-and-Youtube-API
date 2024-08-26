import 'package:flutter/material.dart';

import '../../functions/calculate_date.dart';
import '../../functions/calculate_views.dart';

import 'package:youtube/src/models/video_model.dart';

import '../../utils/styles.dart';
import '../../widgets/text_style.dart';

class ShowDescriptionStats extends StatelessWidget {
  const ShowDescriptionStats({
    super.key,
    required this.size,
    required this.video,
  });

  final Size size;
  final VideoPreview video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BuildText(
                text: formatViews(video.likesCount),
                fontSize: FontSizes.mediumLargeTextSize(context),
                fontWeight: FontWeight.bold,
                textStyle: StyleText.baseTextStyle_1,
              ),
              BuildText(
                text: 'Likes',
                color: Colors.black.withOpacity(0.6),
                fontSize: FontSizes.mediumTextSize(context),
                fontWeight: FontWeight.bold,
                textStyle: StyleText.baseTextStyle_1,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BuildText(
                text: video.viewsCount,
                fontSize: FontSizes.mediumLargeTextSize(context),
                fontWeight: FontWeight.bold,
                textStyle: StyleText.baseTextStyle_1,
              ),
              BuildText(
                text: 'Views',
                color: Colors.black.withOpacity(0.6),
                fontSize: FontSizes.mediumTextSize(context),
                fontWeight: FontWeight.bold,
                textStyle: StyleText.baseTextStyle_1,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BuildText(
                text: formatDate(video.publishedAt)[0],
                fontSize: FontSizes.mediumLargeTextSize(context),
                fontWeight: FontWeight.bold,
                textStyle: StyleText.baseTextStyle_1,
              ),
              BuildText(
                text: formatDate(video.publishedAt)[1],
                color: Colors.black.withOpacity(0.6),
                fontSize: FontSizes.mediumTextSize(context),
                fontWeight: FontWeight.bold,
                textStyle: StyleText.baseTextStyle_1,
              ),
            ],
          )
        ],
      ),
    );
  }
}
