import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:youtube/src/models/video_model.dart';

class UsedVideoTags extends StatelessWidget {
  const UsedVideoTags({
    super.key,
    required this.size,
    required this.video,
  });

  final Size size;
  final VideoPreview video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.01),
      child: video.tags.isNotEmpty
          ? Wrap(
              spacing: 8.0, // Adjust spacing between hashtags as needed
              children: video.tags
                  .where((hashtag) => hashtag.isNotEmpty)
                  .map((hashtag) {
                return Text(
                  "#$hashtag",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.withOpacity(0.8),
                    ),
                  ),
                );
              }).toList(),
            )
          : const Spacer(),
    );
  }
}
