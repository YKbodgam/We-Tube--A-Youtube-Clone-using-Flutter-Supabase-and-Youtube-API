import 'package:flutter/material.dart';

import '../utils/styles.dart';
import '../utils/colours.dart';
import '../widgets/text_style.dart';
import '../widgets/selectable_chip.dart';

import '../models/thumbnail_model/thumbnail_card.dart';
import '../models/skeleton_model/thumbnail_loader.dart';
import '../models/store_video_model/create_video_sheet.dart';
import '../components/home_page_components/navbar_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool allowNavigation = false;
  bool loading = false;

  late String imgPath = 'null';
  late List<dynamic> videos = [];

  @override
  void initState() {
    super.initState();
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

  final List<String> tags = [
    'Technology',
    'Education',
    'Music',
    'Sports',
    'Movies',
    'Science',
    'Cooking',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    itemCount: tags.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: SelectableChip(
                          label: tags[index],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: getAllVideos,
                    child: loading
                        ? ListView(
                            children: List.generate(
                              // Generate loading skeleton cards based on the length of the list
                              videos.length,
                              (index) => BuildSkeletonLoader(size: size),
                            ),
                          )
                        : videos.isEmpty
                            ? Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BuildText(
                                      text: 'No Videos found !',
                                      fontSize:
                                          FontSizes.mediumTextSize(context),
                                      fontWeight: FontWeight.bold,
                                      textStyle: StyleText.baseTextStyle_1,
                                    ),
                                    BuildText(
                                      text: 'Add some videos to your home page',
                                      fontSize:
                                          FontSizes.mediumTextSize(context),
                                      fontWeight: FontWeight.bold,
                                      textStyle: StyleText.baseTextStyle_1,
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: videos.length,
                                itemBuilder: (context, index) {
                                  var item = videos[index];

                                  loading = false;

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
                    context: context,
                    builder: (BuildContext context) {
                      return const AddNewVideo();
                    },
                  );

                  if (result != null) {
                    setState(() {
                      videos.add(result);
                    });
                  }
                },

                backgroundColor: kPrimaryLightColor,
                child: const Icon(Icons.add), // Change color as needed
              ),
            ),

            // FutureBuilder<List<String>>(
            //   future: fetchTags(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       return Center(child: Text('Error: ${snapshot.error}'));
            //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //       return Center(child: Text('No tags available'));
            //     } else {
            //       return
            //       ListView.builder(
            //         itemCount: 1, // Adjust if you have multiple rows
            //         itemBuilder: (context, index) {
            //           return Container(
            //             padding: EdgeInsets.symmetric(vertical: 10.0),
            //             child: SingleChildScrollView(
            //               scrollDirection: Axis.horizontal,
            //               child: Row(
            //                 children: snapshot.data!.map((tag) {
            //                   return Padding(
            //                     padding:
            //                         EdgeInsets.symmetric(horizontal: 4.0),
            //                     child: Chip(
            //                       label: Text(tag),
            //                       onDeleted: () {},
            //                     ),
            //                   );
            //                 }).toList(),
            //               ),
            //             ),
            //           );
            //         },
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
