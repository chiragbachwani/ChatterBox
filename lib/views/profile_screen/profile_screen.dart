import 'package:chat_app/components/picker_dialog.dart';
import 'package:chat_app/const/firebase_const.dart';
import 'package:chat_app/const/images.dart';
import 'package:chat_app/const/strings.dart';
import 'package:chat_app/controller/profile_controller.dart';
import 'package:chat_app/services/store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Vx.gray800,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: "Profile".text.white.semiBold.make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () async {
                if (controller.imgpath.isEmpty) {
                  controller.updateProfile(context);
                } else {
                  await controller.uploadImage(context);
                  controller.updateProfile(context);
                }
              },
              child: "Save".text.semiBold.white.make())
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: 700,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder(
            future: StoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.docs[0];
                //here doc[0] because it will only contain 1 document

                //setting values to the controller
                controller.nameController.text = data['name'];
                controller.phoneController.text = data['phone'];
                controller.aboutController.text = data['about'];

                return Column(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 80,
                        backgroundColor: Vx.purple400,
                        child: Stack(children: [
                          controller.imgpath.isEmpty && data['image_url'] == ''
                              ? Image.asset(
                                  user,
                                  color: Colors.white,
                                )
                              : controller.imgpath.isNotEmpty
                                  ? Image.file(
                                      File(
                                        controller.imgpath.value,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                      .box
                                      .width(250)
                                      .height(250)
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make()
                                  : Image.network(
                                      data['image_url'],
                                      fit: BoxFit.cover,
                                    )
                                      .box
                                      .width(300)
                                      .height(300)
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make(),
                          Positioned(
                            right: 0,
                            bottom: 20,
                            child: CircleAvatar(
                              backgroundColor: Vx.purple400,
                              child: Icon(Icons.camera_alt_rounded).onTap(() {
                                Get.dialog(pickerDialog(context, controller));
                              }),
                            ),
                          )
                        ]),
                      ),
                    ),
                    20.heightBox,
                    const Divider(
                      color: Vx.gray700,
                      height: 1,
                    ),
                    10.heightBox,
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: TextFormField(
                        controller: controller.nameController,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            label: "Name".text.make(),
                            isDense: true,
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                      subtitle: namesub.text.gray400.semiBold.make(),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                      title: TextFormField(
                        controller: controller.aboutController,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            label: "About".text.make(),
                            isDense: true,
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      title: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: controller.phoneController,
                        readOnly: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            prefix: "+91".text.white.make(),
                            border: InputBorder.none,
                            label: "Phone".text.make(),
                            isDense: true,
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
