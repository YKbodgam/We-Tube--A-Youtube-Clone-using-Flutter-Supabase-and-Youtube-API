import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/styles.dart';
import '../utils/colours.dart';
import '../utils/customs.dart';
import '../config/snackbar.dart';
import '../widgets/text_style.dart';
import '../widgets/selectable_chip.dart';

import '../components/navbar_details.dart';
import '../models/thumbnail_model/thumbnail_card.dart';
import '../models/skeleton_model/thumbnail_loader.dart';
import '../models/store_video_model/create_video_sheet.dart';

import 'package:youtube/src/services/fetch_videos_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();
  bool allowNavigation = false;
  bool loading = true;

  String selectedCategory = 'All';
  List<dynamic> selectedCategoryVideos = [];

  late String imgPath = 'null';
  late List<dynamic> videos = [];

  @override
  void initState() {
    super.initState();
    getCategoryVideos();
  }

  Future<void> getAllVideos() async {
    // setState(
    //   () {
    //     loading = true;
    //   },
    // );
    // await fetchVideos().then(
    //   (value) => setState(() {
    //     videos = value;
    //     loading = false;
    //   }),
    // );
  }

  Future<void> getCategoryVideos() async {
    setState(() {
      loading = true;
    });

    try {
      final fetchedCategoryVideos = await fetchCategoryVideos();

      setState(() {
        fetchedCategoryVideos.forEach(
          (categoryId, videos) {
            categoryIds.forEach(
              (categoryName, categoryMap) {
                if (categoryMap.containsKey(categoryId)) {
                  categoryMap[categoryId] = videos;
                }
              },
            );
          },
        );
      });
    } catch (e) {
      SnackWidget.showSnackbar(
        context,
        'API request limit Exceeded !',
        label: 'Close',
        onPressed: () => SystemNavigator.pop(
          animated: true,
        ),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final categoriesMap = categoryIds.map((categoryName, categoryMap) {
      return MapEntry(categoryName,
          categoryMap.values.expand((list) => list as List<dynamic>).toList());
    });

    // Flatten the videos list
    final List<dynamic> categoryVideos = categoriesMap.values
        .expand((categoryList) => categoryList as List<dynamic>)
        .toList();

    // Shuffle the list
    categoryVideos.shuffle(Random());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.01),
                  child: const HomeNavbar(),
                ),
                Container(
                  constraints: const BoxConstraints(maxHeight: 60),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final categoryName = categories[index];

                      return Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: SelectableChip(
                          label: categoryName,
                          isSelected: selectedCategory == categoryName,
                          onSelected: () {
                            setState(() {});

                            selectedCategory = categoryName;
                            selectedCategory == 'All'
                                ? selectedCategoryVideos = categoryVideos
                                : selectedCategoryVideos =
                                    categoryIds[categoryName]
                                        .values
                                        .expand(
                                            (videos) => videos as List<dynamic>)
                                        .toList();
                          },
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await getCategoryVideos();
                    },
                    child: loading
                        ? ListView(
                            children: List.generate(
                              // Generate loading skeleton cards based on the length of the list
                              categoryVideos.length ?? 5,
                              (index) => BuildSkeletonLoader(size: size),
                            ),
                          )
                        : selectedCategoryVideos.isEmpty
                            ? categoryVideos.isEmpty
                                ? Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BuildText(
                                          text: 'No Videos found !',
                                          fontSize:
                                              FontSizes.mediumTextSize(context),
                                          fontWeight: FontWeight.bold,
                                          textStyle: StyleText.baseTextStyle_1,
                                        ),
                                        BuildText(
                                          text:
                                              'Add some videos to your home page',
                                          fontSize:
                                              FontSizes.mediumTextSize(context),
                                          fontWeight: FontWeight.bold,
                                          textStyle: StyleText.baseTextStyle_1,
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: categoryVideos.length,
                                    itemBuilder: (context, index) {
                                      var item = categoryVideos[index];

                                      return ThumbnailCard(
                                        videoPreview: item,
                                      );
                                    },
                                  )
                            : ListView.builder(
                                controller: _controller,
                                itemCount: selectedCategoryVideos.length,
                                itemBuilder: (context, index) {
                                  var item = selectedCategoryVideos[index];

                                  return ThumbnailCard(
                                    videoPreview: item,
                                  );
                                },
                              ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 15,
              bottom: 15,
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return const AddNewVideo();
                    },
                  );

                  if (result != null) {
                    setState(
                      () {
                        selectedCategoryVideos.insert(
                          0,
                          result,
                        );

                        _controller.jumpTo(0);
                      },
                    );

                    SnackWidget.showSnackbar(
                      context,
                      'New Video added',
                      label: 'Okay',
                    );
                  }
                },

                backgroundColor: kPrimaryLightColor,
                child: const Icon(Icons.add), // Change color as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
