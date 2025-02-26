import 'package:flutter/material.dart';
import 'package:youtube_clone/Util/constants.dart';
import 'package:youtube_clone/Screens/VideoDetails.dart';

class VideoTile extends StatelessWidget {
  Map<String, dynamic> finalMap;
  int index = 0;

  VideoTile({super.key, required this.finalMap, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: (){
              constants.openVideoDeatilsScreen(context,finalMap,index);
            },
            highlightColor: Colors.transparent,
            child: Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                      placeholder: const AssetImage("assets/logos/placeholder.jpg"),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return const Column(
                          children: [
                            Icon(Icons.error,color: Colors.red,size: 80,),
                            Text(
                              "Image Error",
                              style: TextStyle(color: Colors.red),
                            ),
                             SizedBox(height: 10,),
                          ],
                        );
                      },
                      image: NetworkImage("https://corsproxy.io/?url=${finalMap['items'][index]['snippet']['thumbnails']['medium']['url']}",),
                      fit: BoxFit.fitWidth,
                      width: constants.getDeviceWidth(context),
                  )
                )
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: constants.myGrey,
                child: Text(
                  finalMap['items'][index]['snippet']['channelTitle'][0] ?? "O",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: (){
                    constants.openVideoDeatilsScreen(context,finalMap,index);
                  },
                  highlightColor: Colors.transparent,
                  child: Text(
                    finalMap['items'][index]['snippet']['title'] ?? "Loading",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, top: 5),
            child: Text(
              finalMap['items'][index]['snippet']['channelTitle'] ?? "DevZam",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xD6CFCFCF)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Text(
              constants
                  .timeAgo(finalMap['items'][index]['snippet']['publishTime']),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xD6CFCFCF)),
            ),
          ),
        ],
      ),
    );
  }

}
