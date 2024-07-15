import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/thumbnail_card.dart';
import '../components/shimmer_loader/thumbnail_loader.dart';
import 'package:youtube/src/services/fetch_videos_channel.dart';

Widget buildRealtedVideosWidget(Size size, String channelId) {
  // Build the realted videos

  return FutureBuilder(
    future: fetchNewerVideoIds(channelId),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Data has been fetched, now build the actual UI

        return BuildSkeletonLoader(size: size);
      } else if (snapshot.hasError) {
        // Handle error state
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData) {
        // Data has been fetched, but it is
        return Center(
          child: Text(
            'No Related Videos found ! \n Please try again',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      } else {
        // Data is still being fetched, show the skeleton loader

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var item = snapshot.data![index];

            return ThumbnailCard(
              videoPreview: item,
            );
          },
        );
      }
    },
  );
}
