import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../widgets/image_error_cont.dart';
import '../../widgets/image_loading_cont.dart';

class VideoThumbnailImg extends StatelessWidget {
  final String imgPath;

  const VideoThumbnailImg({
    super.key,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: AspectRatio(
          aspectRatio: 16 / 9, // Adjust the aspect ratio based on your design
          child: CachedNetworkImage(
            imageUrl: imgPath,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => buildErrorContainer(),
            placeholder: (context, url) => buildLoadingContainer(),
          ),
        ),
      ),
    );
  }
}
