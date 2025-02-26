import 'package:flutter/material.dart';

import '../Screens/MainScreen.dart';
import '../Util/constants.dart';

class WebHeaderTopBar extends StatelessWidget {
  bool isBackButton;
  String? SText;
  bool isSearchScreen;
  WebHeaderTopBar({super.key,required this.isBackButton,this.SText,required this.isSearchScreen});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController(text: SText);
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: 90,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if(isBackButton)
                  IconButton(
                      hoverColor: constants.hoverGrey,
                      onPressed: () {
                        isSearchScreen?constants.openHomeScreen(context):Navigator.pop(context);
                        },
                      icon: const Icon(Icons.arrow_back, color: Colors.white,)),
                  const SizedBox(width: 10,),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    onTap: (){
                      if(isBackButton) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Homepage(),
                            ));
                      }
                    },
                    child: Image.asset(
                      "assets/logos/yt.png",
                      height: 40,
                      width: 120,
                    ),
                  ),
                ],
              ),
              constraints.maxWidth > constants.TABLET_WIDTH
                  ? Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: constants.getDeviceWidth(context) * 0.3,
                    child: TextField(
                      controller: searchController,
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
                      Navigator.pop(context);
                      constants.openSearchScreen(context, searchController.text);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: constants.myGrey,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      width: 70,
                      height: 52,
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const CircleAvatar(
                        radius: 23,
                        backgroundColor: constants.myGrey,
                        child: Icon(
                          Icons.mic,
                          color: Colors.white,
                        ),
                      ))
                ],
              )
                  : Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const CircleAvatar(
                            backgroundColor: constants.myGrey,
                            child: Icon(
                              Icons.mic,
                              color: Colors.white,
                            ),
                          )),
                      ///Search
                      if(!isSearchScreen)
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            constants.openSearchScreen(context, searchController.text);
                          },
                          icon: const CircleAvatar(
                            backgroundColor: constants.myGrey,
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  )),
              Material(
                elevation: 0,
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                        Border.all(color: Colors.white, width: 1)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          " Sign In",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
