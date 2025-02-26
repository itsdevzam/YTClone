import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/homePageModel.dart';
import '../Util/constants.dart';
import 'SideBarList.dart';

class WebHeader extends StatelessWidget {
  double deviceHeight;
   WebHeader({super.key,required this.deviceHeight});

  @override
  Widget build(BuildContext context) {
    final Modal = Provider.of<HomePageModel>(context);
    return SizedBox(
      width: 100,
      height: deviceHeight,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            MouseRegion(
              onEnter: (event) {
                Modal.isHoverT(100);
              },
              cursor: SystemMouseCursors.click,
              child: IconButton(
                  hoverColor: constants.hoverGrey,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  )),
            ),
            Flexible(
              child:  Sidebarlist(isPhone: false,),
            ),
          ],
        ),
      ),
    );
  }
}
