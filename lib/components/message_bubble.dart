import 'package:chat_app/const/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../const/images.dart';
import '../views/chat_screen/chat_screen.dart';
import 'package:intl/intl.dart' as intl;

Widget messageBubble(DocumentSnapshot doc) {
  var t =
      doc['created_on'] == null ? DateTime.now() : doc["created_on"].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  // Fetch user details from Firestore
  var userM = FirebaseFirestore.instance.collection("users");

  return FutureBuilder<DocumentSnapshot>(
    future: userM
        .doc(currentUser!.uid == doc['toId'] ? doc['fromId'] : doc['toId'])
        .get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasData) {
        var friendDoc = snapshot.data!;
        String friendName = friendDoc['name'];
        String imageUrl = friendDoc['image_url'];

        return Card(
          elevation: 0.8,
          color: Colors.white,
          child: ListTile(
            onTap: () {
              Get.to(
                () => const ChatScreen(),
                transition: Transition.rightToLeft,
                arguments: [
                  friendName,
                  currentUser!.uid == doc['toId'] ? doc["fromId"] : doc['toId'],
                ],
              );
            },
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Vx.purple400,
              backgroundImage: NetworkImage(imageUrl),
              child: Icon(Icons.person),
            ),
            title: friendName.text.size(16).semiBold.make(),
            subtitle: "${doc["last_msg"]}".text.maxLines(1).make(),
            trailing: Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.access_time_filled_rounded,
                    size: 16, color: Vx.gray400),
                label: time.text.size(12).gray400.make(),
              ),
            ),
          ),
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Vx.black),
        ));
      }
    },
  );
}
