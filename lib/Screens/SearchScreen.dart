import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/Models/fetchVideo.dart';
import 'package:youtube_clone/Util/constants.dart';
import 'package:youtube_clone/Widgets/PhoneHeader.dart';
import '../Widgets/WebHeaderTopBar.dart';

class SeacrhScreen extends StatefulWidget {
  String? SearchQuery;
  SeacrhScreen({super.key, this.SearchQuery});

  @override
  State<SeacrhScreen> createState() => _SeacrhScreenState();
}

class _SeacrhScreenState extends State<SeacrhScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController sController= TextEditingController(text: widget.SearchQuery);
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              ///Header
              constraints.maxWidth > constants.PHONE_WIDTH
                  ? WebHeaderTopBar(isBackButton: true, SText: widget.SearchQuery,isSearchScreen: true,)
                  : Padding(
                    padding: const EdgeInsets.only(top: kIsWeb?0:20.0),
                    child: PhoneHeader(isBackButton: true,isSearchScreen: true,),
                  ),

              ///SearchBar
              if(constraints.maxWidth < constants.TABLET_WIDTH)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: constants.getDeviceWidth(context) * 0.7,
                      child: TextField(
                        controller: sController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  topLeft: Radius.circular(25))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  topLeft: Radius.circular(25))),
                          hintText: "Search",
                          prefix: SizedBox(
                            width: 10,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  topLeft: Radius.circular(25))),
                        ),
                      ),
                    ),
                    ///Search
                    InkWell(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      onTap: () {
                        constants.openSearchScreen(context, sController.text);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: constants.myGrey,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        width: 50,
                        height: 50,
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ///Body
              isEmptyQuery()?
              const Text("Search Something",style: TextStyle(color: Colors.white),):
              Consumer<fetchVideo>(builder: (context, value, child) => FutureBuilder(
                  future: value.videoFutureForSearchBar,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      var data = snapshot.data;
                      if (data == null) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (data.isEmpty) {
                        return const Center(child: Text("No results found", style: TextStyle(color: Colors.white)));
                      }
                      if(data.isNotEmpty){
                        return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data['items'].length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10, right: 20, left: 30),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        splashFactory: NoSplash.splashFactory,
                                        onTap: () {
                                          constants.openVideoDeatilsScreen(
                                              context, data, index);
                                        },
                                        highlightColor: Colors.transparent,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: FadeInImage(
                                              placeholder: const AssetImage(
                                                  "assets/logos/placeholder.jpg"),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Column(
                                                  children: [
                                                    Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                      size: 80,
                                                    ),
                                                    Text(
                                                      "Image Error",
                                                      style: TextStyle(color: Colors.red),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                );
                                              },
                                              image: NetworkImage(
                                                "https://corsproxy.io/?url=${data['items'][index]['snippet']['thumbnails']['medium']['url']}",
                                              ),
                                              fit: BoxFit.fitWidth,
                                              width: constraints.maxWidth<=constants.PHONE_WIDTH
                                                  ? constants.getDeviceWidth(context) * 0.4
                                                  : constants.getDeviceWidth(context) * 0.2,
                                            )),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              splashFactory: NoSplash.splashFactory,
                                              onTap: () {
                                                constants.openVideoDeatilsScreen(
                                                    context, data, index);
                                              },
                                              highlightColor: Colors.transparent,
                                              child: Text(
                                                data['items'][index]['snippet']['title'] ??
                                                    "Loading",
                                                maxLines: 2,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(color: Colors.white,fontSize: constraints.maxWidth<=constants.TABLET_WIDTH?14:18),
                                              ),
                                            ),
                                            Text(
                                              data['items'][index]['snippet']
                                              ['channelTitle'] ??
                                                  "DevZam",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                              TextStyle(color: const Color(0xD6CFCFCF),fontSize: constraints.maxWidth<=constants.TABLET_WIDTH?13:16),
                                            ),
                                            Text(
                                              constants.timeAgo(data['items'][index]
                                              ['snippet']['publishTime']),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                              TextStyle(color: const Color(0xD6CFCFCF),fontSize: constraints.maxWidth<=constants.TABLET_WIDTH?13:16),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        );
                      }
                    }else{
                      return const CircularProgressIndicator();
                    }
                    return const CircularProgressIndicator();
                  }

              ),),
            ],
          )),
    );
  }

  bool isEmptyQuery(){
    if(widget.SearchQuery!.isEmpty){
      return true;
    }else{
      return false;
    }
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<fetchVideo>().fetchVideoFunForSearchBar(widget.SearchQuery!);
    });
    super.initState();
  }
}
