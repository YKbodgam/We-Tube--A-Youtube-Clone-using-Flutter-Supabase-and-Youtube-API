import 'package:flutter/material.dart';

import 'package:youtube/src/models/video_model.dart';
import 'package:youtube/src/models/channel_model.dart';

import 'description_card.dart';

class DescriptionSheet extends StatelessWidget {
  final VideoPreview video;
  final Channel channel;

  const DescriptionSheet({
    super.key,
    required this.video,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return DescriptionCard(video: video, channel: channel);
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
