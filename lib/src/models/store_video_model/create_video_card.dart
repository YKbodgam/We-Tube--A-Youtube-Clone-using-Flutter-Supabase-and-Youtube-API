import 'package:flutter/material.dart';

import 'create_video_img.dart';
import '../../utils/styles.dart';
import '../../utils/colours.dart';
import '../../widgets/text_style.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/rounded_button.dart';
import '../../functions/calculate_time.dart';
import '../../functions/calculate_views.dart';

import 'package:youtube/src/models/video_model.dart';
import 'package:youtube/src/models/thumbnail_model.dart';
import 'package:youtube/src/services/fetch_video_details.dart';
import 'package:youtube/src/services/fetch_video_id_from_url.dart';

class NewVideoCard extends StatefulWidget {
  const NewVideoCard({super.key});

  @override
  State<NewVideoCard> createState() => _NewVideoCardState();
}

class _NewVideoCardState extends State<NewVideoCard> {
  bool loading = false;
  bool isInitialized = false;
  bool isTextFocused = false;

  late VideoPreview video = VideoPreview(
      '', '', ThumbnailPreview('', ''), '', '', '', [], '', '', '');

  final _formKey = GlobalKey<FormState>();
  final urlController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        isTextFocused = _focusNode.hasFocus;
      });
    });
  }

  void btnPressed() async {
    FocusScope.of(context).unfocus();
    //Setting State of Loader
    setState(() {
      loading = true;
    });

    //Validatory
    if (_formKey.currentState!.validate()) {
      try {
        // We will get Video ID from the URL
        String? videoId = extractVideoId(
          urlController.text.toString(),
        );

        // After we get the video ID from the URL we will fetch the video details
        if (videoId != null) {
          video = await fetchVideoDetails(videoId);

          // Once we get the video details we will update the video list
          setState(
            () {
              loading = false;
              isInitialized = true;
            },
          );
        }

        // Exception will be thrown if the form Here
      } catch (e) {
        setState(
          () {
            loading = false;
          },
        );
      }
    } else {
      setState(
        () {
          loading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
        horizontal: size.width * 0.04,
      ), // Adjust the width as needed.
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Visibility(
              visible: isInitialized,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  VideoThumbnailImg(
                    imgPath: video.thumbnail.thumbnailUrl,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02,
                      horizontal: size.width * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BuildText(
                          text: video.title,
                          fontSize: FontSizes.mediumLargeTextSize(context),
                          fontWeight: FontWeight.bold,
                          textStyle: StyleText.baseTextStyle_1,
                        ),
                        BuildText(
                          text: "${formatViews(
                            video.viewsCount,
                          )} Views •  ${timeAgo(
                            video.publishedAt,
                          )}",
                          color: Colors.black.withOpacity(0.6),
                          fontSize: FontSizes.mediumSmallTextSize(context),
                          fontWeight: FontWeight.bold,
                          textStyle: StyleText.baseTextStyle_2,
                        ),
                      ],
                    ),
                  ),
                  RoundedButton(
                    loading: loading,
                    text: 'Add Video',
                    onPressed: () => Navigator.pop(context, video),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !isInitialized,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextField(
                    borderRadius: 15,
                    controller: urlController,
                    onChanged: (value) {},
                    focusNode: _focusNode,
                    backgroundColor: kPrimaryLightColor,
                    prefixIcon: Icons.search_outlined,
                    focusedBorderColor: kPrimaryDarkColor,
                    hintText: 'Video URL',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid URL ! fetched from Youtube";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  RoundedButton(
                    loading: loading,
                    text: 'Continue',
                    onPressed: btnPressed,
                  ),
                  isTextFocused
                      ? const SizedBox(
                          height: 210,
                        )
                      : const SizedBox(
                          height: 0,
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
