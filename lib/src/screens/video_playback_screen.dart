import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:youtube/src/models/video_model.dart';
import 'package:youtube/src/models/channel_model.dart';
import 'package:youtube/src/services/fetch_url_from_video_id.dart';

import '../utils/colours.dart';
import '../widgets/profile_avatar.dart';
import '../functions/calculate_time.dart';
import '../functions/calculate_views.dart';
import '../services/fetch_related_videos.dart';

import '../constants/rounded_button.dart';
import '../constants/image_error_cont.dart';
import '../constants/image_loading_cont.dart';
import '../components/video_player_components/interactive_component.dart';

class VideoPlaybackScreen extends StatefulWidget {
  final String userId;
  final VideoPreview video;
  final Channel channel;

  const VideoPlaybackScreen({
    super.key,
    required this.userId,
    required this.video,
    required this.channel,
  });

  @override
  State<VideoPlaybackScreen> createState() => _VideoPlaybackScreenState();
}

class _VideoPlaybackScreenState extends State<VideoPlaybackScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  late String videoUrl = '';
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    fetchUrl().then(
      (value) => _initializeVideoPlayer(),
    );
  }

  Future<void> fetchUrl() async {
    await getVideoUrl(widget.video.videoId).then(
      (value) => setState(
        () {
          videoUrl = value;
        },
      ),
    );
  }

  void _initializeVideoPlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.network(
        videoUrl,
      )
        ..addListener(
          () {
            setState(() {
              _chewieController = ChewieController(
                videoPlayerController: _videoPlayerController,
                aspectRatio: _isInitialized
                    ? _videoPlayerController.value.aspectRatio
                    : 16 / 9,

                // set the initial state
                errorBuilder: (context, errorMessage) {
                  return Center(
                    child: Text(
                      errorMessage,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              );
            });
          },
        )
        ..setLooping(
          true,
        )
        ..initialize().then(
          (value) {
            _chewieController.play();
            setState(
              () {
                _isInitialized = true;
              },
            );
          },
        );

      // set the initial state
    } catch (error) {
      debugPrint(
        error.toString(),
      );
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stack(
              //   children: [
              //     AspectRatio(
              //       aspectRatio: 16 / 9,
              //       child: Chewie(
              //         controller: _chewieController,
              //       ),
              //     ),
              //     Positioned(
              //       bottom: 0,
              //       left: 0,
              //       right: 0,
              //       child: VideoProgressIndicator(
              //         _videoPlayerController,
              //         allowScrubbing: true,
              //         padding: const EdgeInsets.all(8),
              //       ),
              //     ),
              //   ],
              // ),

              _isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: Chewie(
                        controller: _chewieController,
                      ),
                    )
                  : Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9, // Set your preferred ratio
                          child: CachedNetworkImage(
                            imageUrl: widget.video.thumbnail.thumbnailUrl,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                buildErrorContainer(),
                            placeholder: (context, url) =>
                                buildLoadingContainer(),
                          ),
                        ),
                        const Positioned.fill(
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                          )),
                        ),
                      ],
                    ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                  horizontal: size.width * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines:
                          2, // Allow the text to wrap to a second line if needed
                      overflow: TextOverflow
                          .ellipsis, // Add ellipsis to overflowed text

                      widget.video.title,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${formatViews(widget.video.viewsCount)} Views •  ${timeAgo(widget.video.publishedAt)}",
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Text(
                            'more..',
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileAvatar(
                      imgPath: widget.channel.profilePictureUrl,
                      radius: 21,
                    ), // Set the
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      widget.channel.title,
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      '${widget.channel.subscriberCount.toString()} sub',
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 40,
                      child: RoundedButton(
                        text: 'Subscribe',
                        press: () {},
                        color: const Color.fromARGB(255, 255, 255, 255),
                        textColor: kPrimaryDarkShade,
                        isborder: true,
                        margin: const EdgeInsets.all(2.0),
                        fontsize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                constraints: const BoxConstraints(maxHeight: 50),
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.01,
                  vertical: size.height * 0.01,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return InteractiveField(
                      likecount: widget.video.likesCount,
                    );
                  },
                ),
              ),
              const Divider(
                color: kPrimaryDarkColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                  vertical: size.height * 0.01,
                ),
                child: Text(
                  'Related videos : ',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              buildRealtedVideosWidget(size, widget.video.channelId),
            ],
          ),
        ),
      ),
    );
  }
}
