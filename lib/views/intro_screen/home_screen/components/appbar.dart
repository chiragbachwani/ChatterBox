import 'package:chat_app/const/colors.dart';
import 'package:chat_app/const/images.dart';
import 'package:chat_app/const/strings.dart';
import 'package:chat_app/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget appbar(GlobalKey<ScaffoldState> key) {
  return Container(
    padding: const EdgeInsets.only(right: 7),
    color: Colors.white,
    height: 80,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        onTap: () {
          key.currentState!.openDrawer();
        },
        child: Container(
          decoration: const BoxDecoration(
              color: Vx.gray800,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100))),
          height: 80,
          width: 90,
          child: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
      ),
      RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: "$appname\n",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: bgColor,
              ),
            ),
            TextSpan(
              text: connecting,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Vx.gray600,
              ),
            ),
          ],
        ),
      ),
      GetBuilder<HomeController>(
        builder: (controller) => CircleAvatar(
          backgroundColor: Vx.purple400,
          radius: 25,
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
                  .width(300)
                  .height(300)
                  .clip(Clip.antiAlias)
                  .make(),
        ),
      ),
    ]),
  );
}
