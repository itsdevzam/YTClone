import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/Models/fetchVideo.dart';
import 'package:youtube_clone/Widgets/PhoneHeader.dart';
import 'package:youtube_clone/Widgets/SideVideoList.dart';
import 'package:youtube_clone/Widgets/WebHeaderTopBar.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../Util/constants.dart';
import '../Widgets/SideBarList.dart';
import 'MainScreen.dart';

class VideoDetails extends StatefulWidget {
  Map Videomap;
  int index;
  VideoDetails({super.key, required this.Videomap, required this.index});

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  @override
  Widget build(BuildContext context) {
    // print(Videomap);
    // print("Index : $index");
    final YoutubePlayerController ytController = constants.ytControllerPhone(widget.Videomap['items'][widget.index]['id']['videoId']);
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            ///Header
             constraints.maxWidth>constants.PHONE_WIDTH?WebHeaderTopBar(isBackButton: true,isSearchScreen: false,):Padding(
               padding:  const EdgeInsets.only(top: kIsWeb?0:20.0),
               child: PhoneHeader(isBackButton: true,isSearchScreen: false,),
             ),
            ///Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 7.0),
                child: SingleChildScrollView(
                  child: Consumer<fetchVideo>(
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            color: Colors.black,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///For Phone
                                // YoutubePlayer(
                                //   controller: constants.ytControllerPhone(Videomap['items'][index]['id']['videoId']),
                                //   showVideoProgressIndicator: true,
                                //   progressIndicatorColor: Colors.amber,
                                // ),
                                ///For Web
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0,left: 20,right: 20,bottom: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // Subtle white effect background
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.3),
                                          // Subtle white shadow
                                          blurRadius: 20,
                                          spreadRadius: 4,
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          // Slight dark shadow for contrast
                                          blurRadius: 10,
                                          offset: const Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: YoutubePlayer(
                                        controller: ytController,
                                        aspectRatio: 16 / 9,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    widget.Videomap['items'][widget.index]
                                        ['snippet']['title'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: constants.VDfont(
                                            constraints.maxWidth)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: constants.myGrey,
                                              child: Text(
                                                widget.Videomap['items']
                                                                [widget.index]
                                                            ['snippet']
                                                        ['channelTitle'][0] ??
                                                    "0",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            widget.Videomap['items']
                                                            [widget.index]
                                                        ['snippet']
                                                    ['channelTitle'] ??
                                                "DevZam",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: constraints.maxWidth >
                                                    constants.PHONE_WIDTH
                                                ? 20
                                                : 0),
                                        child: Material(
                                          elevation: 0,
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            onTap: () {},
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1)),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .download_for_offline_rounded,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    " Download",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: double.maxFinite,
                                      color: constants.myGrey,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              constants.formatPublishDate(widget
                                                          .Videomap['items']
                                                      [widget.index]['snippet']
                                                  ['publishTime']),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              widget.Videomap['items']
                                                              [widget.index]
                                                          ['snippet']
                                                      ['description'] ??
                                                  "No Description",
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                if (constraints.maxWidth < constants.TABLET_WIDTH)
                                  Padding(padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                                    child: FutureBuilder(
                                        future: value.videoFutureForSideBar,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(child:CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.white));
                                          } else if (snapshot.hasData) {
                                            return SideVideoList(isPhone: true, data: snapshot.data!,myYtController: ytController,);
                                          } else {
                                            return const Text(
                                                "No data available",
                                                style: TextStyle(
                                                    color: Colors.white));
                                          }
                                        }),
                                  )
                              ],
                            ),
                          ),
                        ),
                        if (constraints.maxWidth > constants.TABLET_WIDTH)
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, right: 20, bottom: 20),
                                child: FutureBuilder(
                                    future: value.videoFutureForSideBar,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return const Text("Loading",
                                            style: TextStyle(
                                                color: Colors.white));
                                      } else if (snapshot.hasData) {
                                        return SideVideoList(isPhone: false, data: snapshot.data!,myYtController: ytController,);
                                      } else {
                                        return const Text("No data available",
                                            style:
                                                TextStyle(color: Colors.white));
                                      }
                                    }),
                              ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchVideosDATA();
    });
    super.initState();
  }

  void fetchVideosDATA() async {
    try {
      context.read<fetchVideo>().fetchVideoFunForSideBar(widget.Videomap['nextPageToken']);
      print("Fetched Data: Success"); // Debugging: Log the fetched data
    } catch (e) {
      print("Error fetching video data: $e"); // Debugging: Log any errors
    }
  }
}
