import 'package:chat_app/const/firebase_const.dart';
import 'package:chat_app/const/images.dart';
import 'package:chat_app/const/strings.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../controller/home_controller.dart';

Widget drawer() {
  return Drawer(
    backgroundColor: Vx.gray800,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(25),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.arrow_back_ios_new).onTap(() {
              Get.back();
            }),
            iconColor: Colors.white,
            title: settings.text.white.semiBold.make(),
          ),
          20.heightBox,
          GetBuilder<HomeController>(
            builder: (controller) => CircleAvatar(
              backgroundColor: Vx.purple400,
              radius: 40,
              child: HomeController.instance.userImage.isEmpty
                  ? Image.asset(
                      "assets/user.png",
                      color: Vx.white,
                    )
                  : Image.network(
                      HomeController.instance.userImage,
                      fit: BoxFit.cover,
                    )
                      .box
                      .roundedFull
                      .height(300)
                      .width(300)
                      .clip(Clip.antiAlias)
                      .make(),
            ),
          ),
          10.heightBox,
          HomeController.instance.username.text.semiBold
              .size(16)
              .color(Colors.white)
              .make(),
          20.heightBox,
          const Divider(
            color: Vx.gray700,
            height: 1,
          ),
          10.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
                darwerIconList.length,
                (index) => ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.to(() => ProfileScreen(),
                                transition: Transition.downToUp);

                            break;
                          default:
                        }
                      },
                      leading: Icon(
                        darwerIconList[index],
                        color: Colors.white,
                      ),
                      title: drawerlistTitles[index].text.semiBold.white.make(),
                    )),
          ),
          10.heightBox,
          const Divider(
            color: Vx.gray700,
            height: 1,
          ),
          10.heightBox,
          ListTile(
            leading: const Icon(
              inviteicon,
              color: Colors.white,
            ),
            title: invite.text.semiBold.white.make(),
          ),
          const Spacer(),
          ListTile(
            onTap: () async {
              await auth.signOut();
              Get.offAll(() => const ChatApp());
            },
            leading: const Icon(
              logoutIcon,
              color: Colors.white,
            ),
            title: logout.text.semiBold.white.make(),
          )
        ],
      ),
    ),
  );
}
