import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/Models/homePageModel.dart';

import '../Util/constants.dart';

class Sidebarlist extends StatelessWidget {
  bool isPhone=false;
  Sidebarlist({super.key,required this.isPhone});

  @override
  Widget build(BuildContext context) {

    return Consumer<HomePageModel>(
      builder: (context, homePageModel, child) => ListView.builder(
        itemBuilder: (context, index) {
          return MouseRegion(
            onEnter: (event) {
              homePageModel.isHoverT(index);
            },
            onExit: (event) {
              homePageModel.isHoverF();
            },
            cursor: SystemMouseCursors.click,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                      color: isPhone?Colors.transparent:homePageModel
                          .isHoverIndex == index
                          ? homePageModel.isHover
                          ? constants.hoverGrey
                          : Colors.black
                          : Colors.black,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0),
                    child: Column(
                      children: [
                        Icon(constants
                            .SideBar[index]['icon'],
                          color: Colors.white,),
                        const SizedBox(height: 5,),
                        Text(constants
                            .SideBar[index]['name'],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: constants.SideBar.length,),
    );
  }
}
