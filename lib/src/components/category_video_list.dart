import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/styles.dart';
import '../widgets/text_style.dart';

import '../models/thumbnail_model/thumbnail_card.dart';
import '../models/skeleton_model/thumbnail_loader.dart';

import 'package:youtube/src/services/fetch_videos_category.dart';

class CategoryVideosList extends StatelessWidget {
  const CategoryVideosList({
    super.key,
    required this.size,
    required this.categoryIds,
  });

  final Size size;
  final Map<String, dynamic> categoryIds;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchCategoryVideos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return BuildSkeletonLoader(size: size);
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BuildText(
                  text: 'API request limit ran out !',
                  fontSize: FontSizes.mediumTextSize(context),
                  fontWeight: FontWeight.bold,
                  textStyle: StyleText.baseTextStyle_1,
                ),
                BuildText(
                  text: 'Please try again after some time',
                  fontSize: FontSizes.mediumTextSize(context),
                  fontWeight: FontWeight.bold,
                  textStyle: StyleText.baseTextStyle_1,
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BuildText(
                  text: 'No Videos found !',
                  fontSize: FontSizes.mediumTextSize(context),
                  fontWeight: FontWeight.bold,
                  textStyle: StyleText.baseTextStyle_1,
                ),
                BuildText(
                  text: 'Add some videos to your home page',
                  fontSize: FontSizes.mediumTextSize(context),
                  fontWeight: FontWeight.bold,
                  textStyle: StyleText.baseTextStyle_1,
                ),
              ],
            ),
          );
        } else {
          snapshot.data!.forEach((categoryId, videos) {
            categoryIds.forEach(
              (categoryName, categoryMap) {
                if (categoryMap.containsKey(categoryId)) {
                  categoryMap[categoryId] = videos;
                }
              },
            );
          });

          final categoriesMap = categoryIds.map((categoryName, categoryMap) {
            return MapEntry(categoryName,
                categoryMap.values.expand((list) => list).toList());
          });

          // Flatten the videos list
          final List<dynamic> categoryVideos = categoriesMap.values
              .expand((categoryList) => categoryList)
              .toList();

          // Shuffle the list
          categoryVideos.shuffle(Random());

          return ListView.builder(
            itemCount: categoryVideos.length,
            itemBuilder: (context, index) {
              var item = categoryVideos[index];

              return ThumbnailCard(
                videoPreview: item,
              );
            },
          );
        }
      },
    );
  }
}
