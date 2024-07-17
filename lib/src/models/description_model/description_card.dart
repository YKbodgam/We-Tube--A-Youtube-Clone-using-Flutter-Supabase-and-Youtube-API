import 'package:flutter/material.dart';

import 'description_tags.dart';
import 'description_text.dart';
import 'description_stats.dart';
import '../../utils/styles.dart';
import '../../utils/colours.dart';
import '../../widgets/text_style.dart';
import '../../constants/rounded_button.dart';

import 'package:youtube/src/models/video_model.dart';
import 'package:youtube/src/models/channel_model.dart';

import '../../widgets/profile_avatar.dart';

class DescriptionCard extends StatelessWidget {
  final VideoPreview video;
  final Channel channel;

  const DescriptionCard({
    super.key,
    required this.video,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.03,
      ), // Adjust the width as needed.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              BuildText(
                text: "Description",
                color: kPrimaryDarkShade,
                // fontSize: 24,
                fontSize: FontSizes.veryLargeTextSize(context),
                fontWeight: FontWeight.bold,
                textStyle: StyleText.baseTextStyle_2,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.close_outlined,
                  color: kPrimaryDarkShade,
                ),
                onPressed: () {
                  Navigator.pop(context, null); // Close the dialog.
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02,
            ),
            child: Container(
              height: 1.0, // Set the height of the line
              color: kPrimaryDarkShade, // Set the color of the line
            ),
          ),
          BuildText(
            text: video.title,
            // fontSize: 24,
            fontSize: FontSizes.regularTextSize(context),
            fontWeight: FontWeight.bold,
            textStyle: StyleText.baseTextStyle_2,
          ),
          ShowDescriptionStats(size: size, video: video),
          video.description.isNotEmpty
              ? ShowDescriptionText(size: size, video: video)
              : const Spacer(),
          UsedVideoTags(size: size, video: video),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.02,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileAvatar(
                  imgPath: channel.profilePictureUrl,
                  radius: 21,
                ), // Set the
                SizedBox(
                  width: size.width * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildText(
                      text: channel.title,
                      color: Colors.black,
                      fontSize: FontSizes.mediumLargeTextSize(context),
                      fontWeight: FontWeight.bold,
                      textStyle: StyleText.baseTextStyle_2,
                    ),
                    BuildText(
                      text: '${channel.subscriberCount.toString()} sub',
                      color: Colors.black.withOpacity(0.6),
                      fontSize: FontSizes.mediumSmallTextSize(context),
                      fontWeight: FontWeight.bold,
                      textStyle: StyleText.baseTextStyle_2,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundedButton(
                text: 'Videos',
                press: () {},
                margin: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ),
              ),
              RoundedButton(
                text: 'Videos',
                press: () {},
                margin: EdgeInsets.symmetric(
                  vertical: size.height * 0,
                  horizontal: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
