
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:youtube_clone/Models/homePageModel.dart';
import 'package:youtube_clone/Screens/MainScreen.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../Screens/SearchScreen.dart';
import '../Screens/VideoDetails.dart';

class constants{
  static const String appName = "YT Clone";


  ///Links
  static const String apiKey = "youapikey";
  static const String maxResult = "48";
  static const String maxResult2 = "16";
  static const String VideoByOrder = "date";
  static const String VideoByRelevence = "relevance";

  // static const String apiUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=10&q=funny&key=youapikey";
  // static const String apiUrl = "https://corsproxy.io/?url=https://thefact.space/random";

  ///API Function
  static String APIFun(String PageToken){
    String apiUrl="";
    if(PageToken.isEmpty){
      apiUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=$maxResult&order=$VideoByOrder&key=$apiKey";
    }else{
      apiUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=$maxResult2&order=$VideoByRelevence&pageToken=$PageToken&key=$apiKey";
    }
    return apiUrl;
  }

  static String APISearch(String query){
    String apiUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=$maxResult2&order=$VideoByRelevence&q=$query&key=$apiKey";
    return apiUrl;
  }

  ///Constant Width
  static const int PHONE_WIDTH = 480;
  static const int TABLET_WIDTH = 768;

  ///Colors
  static const hoverGrey = Color(0xff272727);
  static const myGrey = Color(0xff4F4C4C);

  ///SideBar List
  static const Map<int,dynamic> SideBar = {
    0:{
      "name":"Home",
      "icon": Icons.home
    },
    1:{
      "name":"Shorts",
      "icon": Icons.browse_gallery
    },
    2:{
      "name":"Subscription",
      "icon": Icons.subscriptions
    },
    3:{
      "name":"You",
      "icon": Icons.person
    },
    4:{
      "name":"History",
      "icon": Icons.history
    },
  };

  ///get Device Width
  static double getDeviceWidth(context){
    return MediaQuery.of(context).size.width;
  }

  ///get Device Height
  static double getDeviceHeight(context){
    return MediaQuery.of(context).size.height;
  }

  ///Grid Item Width
  static double tileWidth(double constraints){
    if(constraints>1350){
     return 0.9;
    }else if(constraints>1200 && constraints<1350){
      return 1;
    }else if(constraints>1000 && constraints<1200){
      return 0.9;
    }else if(constraints>TABLET_WIDTH+100 && constraints<1000){
      return 1;
    }else if(constraints>720 && constraints<TABLET_WIDTH+100){
      return 0.9;
    }else if(constraints>PHONE_WIDTH && constraints<720){
      return 1;
    }else if(constraints<PHONE_WIDTH){
      return 0.83;
    }
    return 1;
  }

  ///Grid Item Count
  static int tileCount(double constraints){
    if(constraints>1200){
      return 4;
    }else if(constraints>TABLET_WIDTH+100){
      return 3;
    }else if(constraints>PHONE_WIDTH){
      return 2;
    }
    return 1;
  }

  ///Font Size Title VideoDetail
  static double VDfont(double con){
    if(con>TABLET_WIDTH){
      return 24;
    }else if(con>PHONE_WIDTH){
      return 18;
    }else{
      return 14;
    }
  }

  ///Get Time
  static String timeAgo(String publishTime) {
    // Parse the publish time
    final DateTime publishedDate = DateTime.parse(publishTime).toUtc();
    final DateTime now = DateTime.now().toUtc();
    final Duration difference = now.difference(publishedDate);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final int weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      final int months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      final int years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }

  ///Format Publish Time
  static String formatPublishDate(String publishTime) {
    DateTime dateTime = DateTime.parse(publishTime);
    return DateFormat('MMM d, yyyy').format(dateTime);
  }

  ///Scaffold State
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<ScaffoldState> scaffoldKeyVideoDetail = GlobalKey<ScaffoldState>();

  ///Youtube Player Controller Phone
  // static YoutubePlayerController ytControllerWeb(String videoId){
  //   final YoutubePlayerController controller = YoutubePlayerController(
  //     flags: const YoutubePlayerFlags(
  //       autoPlay: true,
  //       mute: true,
  //     ),
  //     initialVideoId: videoId,
  //   );
  //   return controller;
  // }
  ///Youtube Player Web
  static YoutubePlayerController ytControllerPhone(String videoId){
    final controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
    return controller;
  }

  ///Open Video
  static void openVideoDeatilsScreen(BuildContext context,Map map,int index){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VideoDetails(Videomap: map, index: index),));
  }

  ///Open Search
  static void openSearchScreen(BuildContext context,String Query){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SeacrhScreen(SearchQuery: Query),));
  }
  ///Open Home
  static void openHomeScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage(),));
  }
}