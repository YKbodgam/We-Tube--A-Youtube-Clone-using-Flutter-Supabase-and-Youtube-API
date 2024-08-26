import 'package:flutter/material.dart';

import '../../utils/colours.dart';
import 'description_tags.dart';
import 'description_text.dart';
import 'description_stats.dart';
import '../../utils/styles.dart';
import '../../widgets/text_style.dart';
import '../../widgets/rounded_button.dart';

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
        vertical: size.height * 0.02,
        horizontal: size.width * 0.03,
      ), // Adjust the width as needed.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: RoundedButton(
                  height: 50,
                  text: 'Videos',
                  icon: Icons.video_library_outlined,
                  iconColor: Colors.white,
                  fontsize: FontSizes.mediumLargeTextSize(context),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              Expanded(
                child: RoundedButton(
                  height: 50,
                  text: 'About',
                  textColor: kPrimaryDarkShade,
                  backgroundColor: Colors.white,
                  icon: Icons.person_outline_outlined,
                  isborder: true,
                  fontsize: FontSizes.mediumLargeTextSize(context),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
