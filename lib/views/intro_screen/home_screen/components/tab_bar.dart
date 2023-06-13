import 'package:chat_app/const/strings.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget tabbar() {
  return Container(
    color: Vx.gray800,
    child: const RotatedBox(
      quarterTurns: 3,
      child: TabBar(
          indicator: BoxDecoration(),
          labelColor: Colors.blue,
          unselectedLabelColor: Vx.white,
          tabs: [
            Tab(
              text: chats,
            ),
            Tab(
              text: status,
            ),
            Tab(
              text: camera,
            ),
          ]),
    ),
  );
}
