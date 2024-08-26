import 'package:flutter/material.dart';

import '../../utils/styles.dart';
import '../../widgets/text_style.dart';
import '../../functions/calculate_views.dart';

import 'package:youtube/src/models/comments_model.dart';

import 'comment_sheet.dart';
import 'comments_card.dart';

class CommentPopular extends StatelessWidget {
  final List<Comments> comments;
  final String commentCount;

  const CommentPopular({
    super.key,
    required this.comments,
    required this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return CommentSheet(comment: comments);
          },
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: size.height * 0.01,
          horizontal: size.width * 0.02,
        ),

        elevation: 2, // Set the elevation to 0 to remove Card's default shadow
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8), // Adjust the border radius as needed
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.03,
                size.height * 0.01,
                size.width * 0.03,
                0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BuildText(
                    text: 'comments  ${formatViews(commentCount)}',
                    fontSize: FontSizes.mediumTextSize(context),
                    fontWeight: FontWeight.bold,
                    textStyle: StyleText.baseTextStyle_3,
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 20,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            CommentCard(comment: comments.first),
          ],
        ),
      ),
    );
  }
}
