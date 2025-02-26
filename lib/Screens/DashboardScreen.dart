import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/Models/fetchVideo.dart';
import 'package:youtube_clone/Widgets/VideoTile.dart';
import 'package:youtube_clone/Widgets/WebHeaderTopBar.dart';

import '../Util/constants.dart';

class Dashboardscreen extends StatelessWidget {
  final bool isPhone;

  const Dashboardscreen({super.key, required this.isPhone});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController(); // Add a ScrollController
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          ///Header
          if (!isPhone)
            WebHeaderTopBar(isBackButton: false,isSearchScreen: false,),
          ///Body
          Consumer<fetchVideo>(
            builder: (context, value, child) => Column(
              children: [
                FutureBuilder(
                  future: value.videoFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      if (data != null && data.isNotEmpty) {
                        if (data['error'] != null &&
                            data['error']['code'] == 403) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Free API Limit Reached Please Wait Some time then try again",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          );
                        }
                        return SizedBox(
                          height: constants.getDeviceHeight(context) - 100,
                          child: ScrollbarTheme(
                            data: ScrollbarThemeData(
                              thumbColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: kIsWeb
                                ? Scrollbar(
                                    controller: scrollController,
                                    thickness: 4,
                                    child: GridView.builder(
                                      controller: scrollController,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  constants.tileCount(
                                                      constraints.maxWidth),
                                              childAspectRatio: 1 /
                                                  constants.tileWidth(
                                                      constraints.maxWidth)),
                                      itemCount: data['items'].length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: VideoTile(
                                            finalMap: data,
                                            index: index,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: constants.tileCount(
                                                constraints.maxWidth),
                                            childAspectRatio: 1 /
                                                constants.tileWidth(
                                                    constraints.maxWidth)),
                                    itemCount: data['items'].length,
                                    itemBuilder: (context, index) {
                                      return VideoTile(
                                        finalMap: data,
                                        index: index,
                                      );
                                    },
                                  ),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: Text(
                          "Loading",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      );
                    }
                    return const Center(
                      child: Text(
                        "Loading",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
