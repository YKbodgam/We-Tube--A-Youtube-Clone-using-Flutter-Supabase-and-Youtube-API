import 'package:flutter/material.dart';

import '../../utils/styles.dart';
import '../../utils/colours.dart';
import '../../widgets/text_style.dart';
import '../../widgets/profile_avatar.dart';
import '../../widgets/rounded_button.dart';

import 'package:youtube/src/models/channel_model.dart';

class ChannelDetails extends StatelessWidget {
  final Size size;
  final Channel channel;

  const ChannelDetails({
    super.key,
    required this.size,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileAvatar(
            imgPath: channel.profilePictureUrl,
            radius: 21,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildText(
                    text: channel.title,
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
            ),
          ),
          SizedBox(
            height: 40,
            child: RoundedButton(
              text: 'Subscribe',
              onPressed: () {},
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              textColor: kPrimaryDarkShade,
              isborder: true,
              fontsize: FontSizes.smallTextSize(context),
            ),
          ),
        ],
      ),
    );
  }
}
