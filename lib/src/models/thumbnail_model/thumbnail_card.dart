import 'package:flutter/material.dart';

import 'thumbnail_image.dart';
import '../../utils/styles.dart';
import '../../widgets/text_style.dart';
import '../../widgets/profile_avatar.dart';

import '../../functions/calculate_time.dart';
import '../../functions/calculate_views.dart';
import '../../screens/video_playback_screen.dart';
import '../../widgets/rounded_icon_button.dart';

import 'package:youtube/src/models/video_model.dart';
import 'package:youtube/src/models/channel_model.dart';
import 'package:youtube/src/services/fetch_channel_details.dart';

class ThumbnailCard extends StatefulWidget {
  final VideoPreview videoPreview;

  const ThumbnailCard({
    super.key,
    required this.videoPreview,
  });

  @override
  State<ThumbnailCard> createState() => _ThumbnailCardState();
}

class _ThumbnailCardState extends State<ThumbnailCard> {
  late String imgPath = '';
  late String username = '';

  late Channel channel;

  @override
  void initState() {
    super.initState();
    getChannelDetails(widget.videoPreview.channelId);
  }

  Future<void> getChannelDetails(String channelId) async {
    try {
      await fetchChannelDetails(channelId).then(
        (value) {
          setState(
            () {
              channel = value;
              username = value.title;
              imgPath = value.profilePictureUrl;
            },
          );
        },
      );
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.02,
      ),
      elevation: 5, // Set the elevation to 0 to remove Card's default shadow
      color: const Color.fromARGB(255, 255, 155, 155),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(14), // Adjust the border radius as needed
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlaybackScreen(
              userId: '',
              video: widget.videoPreview,
              channel: channel,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildThumbnailContainer(
              size,
              widget.videoPreview.thumbnail.thumbnailUrl,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.02,
                horizontal: size.width * 0.03,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileAvatar(
                    imgPath: imgPath,
                    radius: 22.5,
                  ), // Set the
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BuildText(
                          text: widget.videoPreview.title,
                          fontSize: FontSizes.mediumTextSize(context),
                          fontWeight: FontWeight.bold,
                          textStyle: StyleText.baseTextStyle_1,
                        ),
                        BuildText(
                          text: "$username  •  ${formatViews(
                            widget.videoPreview.viewsCount,
                          )} Views  •  ${timeAgo(
                            widget.videoPreview.publishedAt,
                          )}",
                          color: Colors.black.withOpacity(0.6),
                          fontSize: FontSizes.smallTextSize(context),
                          fontWeight: FontWeight.bold,
                          textStyle: StyleText.baseTextStyle_2,
                        ),
                      ],
                    ),
                  ),
                  const RoundedIconButton(
                    icon: Icons.more_vert_outlined,
                    iconSize: 25,
                    iconColor: Colors.black,
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
