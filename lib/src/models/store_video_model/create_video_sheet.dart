import 'package:flutter/material.dart';

import 'create_video_card.dart';

class AddNewVideo extends StatelessWidget {
  const AddNewVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
            const NewVideoCard(),
          ],
        ),
      ),
    );
  }
}
