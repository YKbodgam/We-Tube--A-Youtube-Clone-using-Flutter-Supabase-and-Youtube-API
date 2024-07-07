import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colours.dart';
import '../constants/rounded_button.dart';
import '../constants/selectable_chip.dart';
import '../components/shimmer_loader/thumbnail_loader.dart';
import '../components/home_page_components/navbar_details.dart';

import 'package:youtube/src/services/fetch_video_details.dart';
import 'package:youtube/src/services/fetch_video_id_from_url.dart';

import '../widgets/thumbnail_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool allowNavigation = false;
  bool loading = false;

  late String videoUrl = '';
  late String imgPath = 'null';
  late List<dynamic> videos = [];

  @override
  void initState() {
    super.initState();
  }

  void _addVideoFromUrl() async {
    setState(
      () {
        loading = true;
      },
    );

    // We will get Video ID from the URL
    String? videoId = extractVideoId(_urlController.text);

    // After we get the video ID from the URL we will fetch the video details
    if (videoId != null) {
      final video = await fetchVideoDetails(videoId);

      // Once we get the video details we will update the video list
      setState(
        () {
          videos.add(video);
          loading = false;
        },
      );
    } else {
      // Show error message
      debugPrint('error');
    }
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
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: RefreshIndicator(
        onRefresh: getAllVideos,
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: kPrimaryDarkShade,
                ),
              )
            : Column(
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
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _urlController,
                          decoration:
                              const InputDecoration(labelText: 'YouTube URL'),
                        ),
                      ),
                    ],
                  ),
                  RoundedButton(
                    text: 'import',
                    press: _addVideoFromUrl,
                  ),
                  Expanded(
                    child: loading
                        ? ListView(
                            children: List.generate(
                              // Generate loading skeleton cards based on the length of the list
                              videos.length,
                              (index) => BuildSkeletonLoader(size: size),
                            ),
                          )
                        : ListView.builder(
                            itemCount: videos.length,
                            itemBuilder: (context, index) {
                              var item = videos[index];

                              if (videos.isEmpty) {
                                return Text(
                                  'No Videos found ! \n Add some videos to your home page',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }

                              return ThumbnailCard(
                                videoPreview: item,
                              );
                            },
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
