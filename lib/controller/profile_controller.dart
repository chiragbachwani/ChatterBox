import 'dart:io';

import 'package:chat_app/const/firebase_const.dart';
import 'package:chat_app/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileController extends GetxController {
  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  var phoneController = TextEditingController();

  // variables for image
  var imgpath = ''.obs;
  var imglink = '';

  updateProfile(context) async {
    var store =
        firebaseFirestore.collection(collectionUser).doc(currentUser!.uid);
    await store.set({
      'name': nameController.text,
      'about': aboutController.text,
    }, SetOptions(merge: true));

    if (imglink == '') {
      return null;
    } else {
      store.set({'image_url': imglink}, SetOptions(merge: true));
    }

    VxToast.show(context, msg: "Profile updated succesfully");
  }

  selectImage(context, source) async {
    await Permission.storage.request();
    await Permission.photos.request();
    await Permission.camera.request();

    var status = await Permission.photos.status;

    if (status.isGranted) {
      VxToast.show(context, msg: "Permission Denied");
    } else {
      try {
        final img =
            await ImagePicker().pickImage(source: source, imageQuality: 80);

        imgpath.value = img!.path;

        VxToast.show(context, msg: "Image selected");
      } on PlatformException catch (e) {
        VxToast.show(context, msg: e.toString());
      }
    }
  }

//upload image to firestore
  uploadImage(context) async {
    VxToast.show(context, msg: "Uploading Started");

    var name = basename(imgpath.value);
    var destination = "images/${currentUser!.uid}/$name";

    Reference ref = FirebaseStorage.instance.ref().child(destination);

    var file = File(imgpath.value);

    var uploadTask = ref.putFile(file);

    var snapshot = await uploadTask.whenComplete(() {});

    if (snapshot.state == TaskState.success) {
      var d = await ref.getDownloadURL();

      print(d);

      imglink = d;

      HomeController.instance.update();

      VxToast.show(context, msg: "Image uploaded successfully");
    } else {
      VxToast.show(context, msg: "Image upload failed");
    }
    update();
  }
}
