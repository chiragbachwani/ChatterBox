import 'package:chat_app/const/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:chat_app/controller/profile_controller.dart';

ProfileController profileController = ProfileController();

Widget pickerDialog(context, ProfileController controller) {
  var listTile = [camera, gallery, cancel];
  var icons = [
    Icons.camera_alt_rounded,
    Icons.photo_size_select_actual_rounded,
    Icons.cancel
  ];
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      padding: const EdgeInsets.all(16),
      color: Vx.gray800,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          source.text.semiBold.white.make(),
          const Divider(),
          10.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
                3,
                (index) => ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.back();
                            controller.selectImage(context, ImageSource.camera);
                            break;
                          case 1:
                            Get.back();
                            controller.selectImage(
                                context, ImageSource.gallery);
                            break;

                          case 2:
                            Get.back();
                            break;
                          default:
                        }
                      },
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                      ),
                      title: listTile[index].text.white.make(),
                    )),
          )
        ],
      ),
    ),
  );
}
