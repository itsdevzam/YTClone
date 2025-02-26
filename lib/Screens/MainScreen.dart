import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/Models/homePageModel.dart';
import 'package:youtube_clone/Screens/DashboardScreen.dart';
import 'package:youtube_clone/Widgets/PhoneHeader.dart';
import 'package:youtube_clone/Widgets/WebHeaderSideBar.dart';

import '../Util/constants.dart';
import '../Widgets/SideBarList.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageModel>(
      builder: (context, homePageModel, child) => Scaffold(
        key: constants.scaffoldKey,
        backgroundColor: Colors.black,
        drawer: Drawer(
          width: 100,
          backgroundColor: Colors.black,
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Image.asset("assets/logos/yt_logo.png",width: 60,height: 80,),
              Flexible(child: Sidebarlist(isPhone: true,))
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return constraints.maxWidth>=constants.PHONE_WIDTH?
                ///For Web
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //header
                WebHeader(deviceHeight: constants.getDeviceHeight(context)),
                //body
                const Expanded(
                  child: Dashboardscreen(isPhone: false,),
                )
              ],
            ):
                ///For Phone
            Column(
              children: [
                const SizedBox(height: kIsWeb?0:20.0,),
                //header
                PhoneHeader(isBackButton: false,isSearchScreen: false,),
                //body
                const Expanded(child: Dashboardscreen(isPhone: true,)),
              ],
            );
          },
        ),
      ),
    );
  }
}
