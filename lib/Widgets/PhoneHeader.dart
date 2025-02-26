import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/Models/homePageModel.dart';

import '../Util/constants.dart';

class PhoneHeader extends StatelessWidget {
  bool isBackButton;
  bool isSearchScreen;
  PhoneHeader({super.key,required this.isBackButton,required this.isSearchScreen});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomePageModel>(context);
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MouseRegion(
                  onEnter: (event) {
                    model.isHoverT(100);
                  },
                  cursor: SystemMouseCursors.click,
                  child: IconButton(
                      hoverColor: constants.hoverGrey,
                      onPressed: () {
                        isBackButton?isSearchScreen?constants.openHomeScreen(context):Navigator.pop(context):constants.scaffoldKey.currentState?.openDrawer();
                      },
                      icon: Icon(
                        isBackButton?Icons.arrow_back:Icons.menu,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(width: 5,),
                Image.asset("assets/logos/yt.png",height: 20,),
              ],
            ),
            Row(
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
                if(!isSearchScreen)
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      constants.openSearchScreen(context,"");
                    },
                    icon: const CircleAvatar(
                      backgroundColor: constants.myGrey,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
