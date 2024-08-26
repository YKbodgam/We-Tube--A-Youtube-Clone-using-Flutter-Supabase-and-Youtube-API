import 'package:flutter/material.dart';

import '../../utils/styles.dart';
import '../../widgets/text_style.dart';
import '../../widgets/profile_avatar.dart';
import '../../functions/calculate_time.dart';

import 'package:youtube/src/models/comments_model.dart';

class CommentCard extends StatelessWidget {
  final Comments comment;

  const CommentCard({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.01,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileAvatar(
            imgPath: comment.authorProfile,
            radius: 16,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildText(
                    text: "${comment.authorName}  •  ${timeAgo(
                      comment.publisedAt,
                    )}",
                    color: Colors.black.withOpacity(0.6),
                    fontSize: FontSizes.smallTextSize(context),
                    fontWeight: FontWeight.bold,
                    textStyle: StyleText.baseTextStyle_2,
                  ),
                  BuildText(
                    text: comment.comment,
                    fontSize: FontSizes.mediumSmallTextSize(context),
                    fontWeight: FontWeight.bold,
                    textStyle: StyleText.baseTextStyle_1,
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.favorite_outline_outlined,
                size: 18,
                color: Colors.black,
              ),
              BuildText(
                text: comment.likeCount.toString(),
                fontSize: FontSizes.smallTextSize(context),
                fontWeight: FontWeight.bold,
                textStyle: StyleText.baseTextStyle_1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
