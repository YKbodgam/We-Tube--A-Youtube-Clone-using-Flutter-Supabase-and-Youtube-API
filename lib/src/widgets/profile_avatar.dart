import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileAvatar extends StatelessWidget {
  final String imgPath;
  final double radius;

  const ProfileAvatar({
    super.key,
    required this.imgPath,
    this.radius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2, // Set the desired width
      height: radius * 2, // Set the desired height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.black, // Set the border color
          width: 1, // Set the border width
        ),
      ),
      child: CircleAvatar(
        backgroundImage: imgPath != '' && imgPath.isNotEmpty
            ? CachedNetworkImageProvider(imgPath) as ImageProvider
            : const AssetImage("assets/images/Profile.jpg"),
      ),
    );
  }
}
