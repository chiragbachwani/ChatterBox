import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget statusComponent() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Vx.purple400,
            child: Image.asset(
              "assets/user.png",
              color: Colors.white,
            ),
          ),
          title: "My Status".text.fontWeight(FontWeight.w500).black.make(),
          subtitle: "tap to add status updates".text.gray400.make(),
        ),
        20.heightBox,
        "Recent Updates".text.fontWeight(FontWeight.w500).black.make(),
        20.heightBox,
        ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Vx.purple400,
                        width: 3,
                      )),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Vx.randomColor,
                    child: Image.asset(
                      "assets/user.png",
                      color: Colors.white,
                    ),
                  ),
                ),
                title: "Username".text.black.fontWeight(FontWeight.w500).make(),
                subtitle: "Today, 8:47 PM"
                    .text
                    .black
                    .fontWeight(FontWeight.w500)
                    .make(),
              ),
            );
          },
        ),
      ],
    ),
  );
}
