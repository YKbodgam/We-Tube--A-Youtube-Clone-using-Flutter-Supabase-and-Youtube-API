import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';
import '../../widgets/text_style.dart';
import 'create_video_card.dart';

class AddNewVideo extends StatelessWidget {
  const AddNewVideo({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      child: SingleChildScrollView(
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
                horizontal: size.width * 0.04,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  BuildText(
                    text: "Add Video",
                    color: kPrimaryDarkShade,
                    fontSize: FontSizes.largeTextSize(context),
                    fontWeight: FontWeight.bold,
                    textStyle: StyleText.baseTextStyle_2,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.close_outlined,
                      color: kPrimaryDarkShade,
                    ),
                    onPressed: () {
                      Navigator.pop(context, null); // Close the dialog.
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                height: 1.0, // Set the height of the line
                color: kPrimaryDarkShade, // Set the color of the line
              ),
            ),
            const NewVideoCard(),
          ],
        ),
      ),
    );
  }
}
