import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:youtube/src/models/video_model.dart';
import 'package:youtube/src/models/channel_model.dart';
import 'package:youtube/src/services/fetch_videos_channel.dart';
import 'package:youtube/src/services/fetch_url_from_video_id.dart';

import '../utils/styles.dart';
import '../utils/colours.dart';
import '../widgets/text_style.dart';
import '../functions/calculate_time.dart';
import '../functions/calculate_views.dart';

import '../widgets/image_error_cont.dart';
import '../widgets/image_loading_cont.dart';
import '../models/comments_model/comment_init.dart';
import '../models/thumbnail_model/thumbnail_card.dart';
import '../models/skeleton_model/thumbnail_loader.dart';
import '../models/video_player_model/channel_details.dart';
import '../models/description_model/description_sheet.dart';
import '../components/interactive_component.dart';

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
  late List<dynamic> video = [];
  bool _isInitialized = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchUrl().then(
      (value) => _initializeVideoPlayer(),
    );
    getNewerVideoIds();
  }

  Future<void> getNewerVideoIds() async {
    setState(
      () {
        loading = true;
      },
    );

    await fetchNewerVideoIds(
      widget.video.channelId,
    ).then(
      (value) {
        setState(
          () {
            video = value;
            loading = false;
          },
        );
      },
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
        body:
            // RefreshIndicator(
            //   onRefresh: getNewerVideoIds,
            //   child:
            SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    BuildText(
                      text: widget.video.title,
                      fontSize: FontSizes.mediumTextSize(context),
                      fontWeight: FontWeight.bold,
                      textStyle: StyleText.baseTextStyle_1,
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return DescriptionSheet(
                                video: widget.video, channel: widget.channel);
                          },
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BuildText(
                            text:
                                "${formatViews(widget.video.viewsCount)} Views •  ${timeAgo(widget.video.publishedAt)}",
                            color: Colors.black.withOpacity(0.6),
                            fontSize: FontSizes.smallTextSize(context),
                            fontWeight: FontWeight.bold,
                            textStyle: StyleText.baseTextStyle_2,
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          BuildText(
                            text: 'more..',
                            fontSize: FontSizes.mediumSmallTextSize(context),
                            fontWeight: FontWeight.bold,
                            textStyle: StyleText.baseTextStyle_2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ChannelDetails(
                size: size,
                channel: widget.channel,
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
              Visibility(
                visible: widget.video.comments.isNotEmpty,
                child: CommentPopular(
                  comments: widget.video.comments,
                  commentCount: widget.video.commentsCount,
                ),
              ),
              const Divider(
                color: kPrimaryDarkColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  vertical: size.height * 0.01,
                ),
                child: BuildText(
                  text: 'Related videos : ',
                  fontSize: FontSizes.mediumLargeTextSize(context),
                  fontWeight: FontWeight.bold,
                  textStyle: StyleText.baseTextStyle_3,
                ),
              ),
              loading
                  ? ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        // Generate loading skeleton cards based on the length of the list
                        video.length,
                        (index) => BuildSkeletonLoader(size: size),
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: video.length,
                      itemBuilder: (context, index) {
                        var item = video[index];

                        if (video.isEmpty) {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BuildText(
                                  text: 'No Videos found !',
                                  fontSize: FontSizes.mediumTextSize(context),
                                  fontWeight: FontWeight.bold,
                                  textStyle: StyleText.baseTextStyle_1,
                                ),
                                BuildText(
                                  text: 'Add some videos to your home page',
                                  fontSize: FontSizes.mediumTextSize(context),
                                  fontWeight: FontWeight.bold,
                                  textStyle: StyleText.baseTextStyle_1,
                                ),
                              ],
                            ),
                          );
                        }

                        return ThumbnailCard(
                          videoPreview: item,
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
    //     ),
    //   ),
    // );
  }
}
