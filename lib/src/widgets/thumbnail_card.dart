import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'profile_avatar.dart';
import '../utils/colours.dart';
import '../functions/calculate_time.dart';
import '../functions/calculate_views.dart';
import '../screens/video_playback_screen.dart';

import '../constants/rounded_icon_button.dart';
import '../components/home_page_components/video_thumbnail.dart';

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
      color: kPrimaryLightShade.withOpacity(0.5),
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
                        Text(
                          maxLines:
                              2, // Allow the text to wrap to a second line if needed
                          overflow: TextOverflow
                              .ellipsis, // Add ellipsis to overflowed text

                          widget.videoPreview.title,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "$username   •   ${formatViews(
                            widget.videoPreview.viewsCount,
                          )} Views •  ${timeAgo(
                            widget.videoPreview.publishedAt,
                          )}",
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
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
