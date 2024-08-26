import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../widgets/image_error_cont.dart';
import '../../widgets/image_loading_cont.dart';

Widget buildThumbnailContainer(Size size, String getImage) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(14),
        topRight: Radius.circular(14),
      ),
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(14),
        topRight: Radius.circular(14),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9, // Set your preferred ratio
        child: CachedNetworkImage(
          imageUrl: getImage,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => buildErrorContainer(),
          placeholder: (context, url) => buildLoadingContainer(),
        ),
      ),
    ),
  );
}
