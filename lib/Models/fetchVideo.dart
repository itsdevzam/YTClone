import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_clone/Util/constants.dart';
import 'package:youtube_clone/Util/testData.dart';

class fetchVideo extends ChangeNotifier {
  fetchVideo(){
    fetchVideoFun();
  }
  Map<String, dynamic> _videosMap = {};
  Map<String, dynamic> _videosMapForSideBar = {};
  Map<String, dynamic>? _videosMapForSearchBar = {};

  ///Enable for Real API Data
  Future<void> fetchVideoFun()async{
     http.Response apiResponse = await http.get(Uri.parse(constants.APIFun("")));
     _videosMap=jsonDecode(apiResponse.body);
     notifyListeners();
  }
  Future<Map<String, dynamic>> get videoFuture async => _videosMap;

  Future<void> fetchVideoFunForSearchBar(String query)async{
    _videosMapForSearchBar=null;
    notifyListeners();
    http.Response apiResponse = await http.get(Uri.parse(constants.APISearch(query)));
    _videosMapForSearchBar=jsonDecode(apiResponse.body);
    notifyListeners();
  }
  Future<Map<String, dynamic>> get videoFutureForSearchBar async => _videosMapForSearchBar!;

  Future<void> fetchVideoFunForSideBar(String token)async{
    http.Response apiResponse = await http.get(Uri.parse(constants.APIFun(token)));
    _videosMapForSideBar=jsonDecode(apiResponse.body);
    notifyListeners();
  }
  Future<Map<String, dynamic>> get videoFutureForSideBar async => _videosMapForSideBar;

 ///Enable for test Data
 //  Future<void> fetchVideoFunForSideBar(String token)async{
 //    _videosMapForSideBar=testData.zdata;
 //    notifyListeners();
 //  }
 //  Future<Map<String, dynamic>> get videoFutureForSideBar async => _videosMapForSideBar;
 //  late final _lvideosMapForSearchBar;
 //  Future<void> fetchVideoFunForSearchBar(String query)async{
 //    _lvideosMapForSearchBar=testData.zdata;
 //    notifyListeners();
 //  }
 //  Future<Map<String, dynamic>> get videoFutureForSearchBar async => _lvideosMapForSearchBar;
 //
 //  Future<void> fetchVideoFun()async{
 //     _videosMap=testData.zdata;
 //     notifyListeners();
 //  }
 //  Future<Map<String, dynamic>> get videoFuture async => _videosMap;
}