import 'package:flutter/material.dart';

import 'comments_card.dart';
import '../../utils/styles.dart';
import '../../widgets/text_style.dart';

import 'package:youtube/src/models/comments_model.dart';

class CommentSheet extends StatelessWidget {
  final List<Comments> comment;

  const CommentSheet({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.68,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4.0,
                width: 50.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                  horizontal: size.width * 0.03,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    BuildText(
                      text: "Comments",
                      color: Colors.black,
                      // fontSize: 24,
                      fontSize: FontSizes.regularTextSize(context),
                      fontWeight: FontWeight.bold,
                      textStyle: StyleText.baseTextStyle_3,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.close_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context, null); // Close the dialog.
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 1.0, // Set the height of the line
                color: Colors.black, // Set the color of the line
              ),
              Expanded(
                child: comment.isEmpty
                    ? Center(
                        child: BuildText(
                          text: 'No Comments found !',
                          fontSize: FontSizes.mediumTextSize(context),
                          fontWeight: FontWeight.bold,
                          textStyle: StyleText.baseTextStyle_1,
                        ),
                      )
                    : ListView.builder(
                        itemCount: comment.length,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          var item = comment[index];

                          return CommentCard(
                            comment: item,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
