import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/description_stats.dart';
import '../constants/description_tags.dart';
import '../constants/description_text.dart';
import '../constants/rounded_button.dart';
import '../utils/colours.dart';

import 'package:youtube/src/models/video_model.dart';
import 'package:youtube/src/models/channel_model.dart';

import 'profile_avatar.dart';

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
              Text(
                "Description",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  color: kPrimaryDarkShade,
                ),
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
          Text(
            maxLines: 3, // Allow the text to wrap to a second line if needed
            overflow: TextOverflow.ellipsis, // Add ellipsis to overflowed text

            video.title,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                    Text(
                      channel.title,
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '${channel.subscriberCount.toString()} sub',
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
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
                text: 'Videoa',
                press: () {},
                margin: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ),
              ),
              RoundedButton(
                text: 'Videoa',
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
