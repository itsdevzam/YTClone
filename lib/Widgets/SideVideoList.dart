import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../Models/fetchVideo.dart';
import '../Util/constants.dart';

class SideVideoList extends StatelessWidget {
  bool isPhone;
  Map<String,dynamic> data;
  YoutubePlayerController myYtController;
  SideVideoList({super.key,required this.isPhone,required this.data,required this.myYtController});

  @override
  Widget build(BuildContext context) {
    if(data.isNotEmpty){
      if(data['error'] != null && data['error']['code'] == 403){
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text("Free API Limit Reached Please Wait Some time then try again",style: TextStyle(color: Colors.white,fontSize: 18),),
          ),
        );
      }
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data['items'].length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0,bottom: 10,right: 20,left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: (){
                      print(" controller");
                      myYtController.close();
                      constants.openVideoDeatilsScreen(context,data,index);
                    },
                    highlightColor: Colors.transparent,
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
                          image: NetworkImage("https://corsproxy.io/?url=${data['items'][index]['snippet']['thumbnails']['medium']['url']}",),
                          fit: BoxFit.fitWidth,
                          width: isPhone?constants.getDeviceWidth(context)*0.4:constants.getDeviceWidth(context)*0.125,
                        )
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: (){
                            print(" controllr");
                            myYtController.close();
                            constants.openVideoDeatilsScreen(context,data,index);
                          },
                          highlightColor: Colors.transparent,
                          child: Text(
                            data['items'][index]['snippet']['title'] ?? "Loading",
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Text(
                          data['items'][index]['snippet']['channelTitle'] ?? "DevZam",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Color(0xD6CFCFCF)),
                        ),
                        Text(
                          constants
                              .timeAgo(data['items'][index]['snippet']['publishTime']),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Color(0xD6CFCFCF)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    }else{
      return const Text("data Error",style: TextStyle(color: Colors.white),);
    }
  }
}
