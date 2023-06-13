import 'package:chat_app/components/message_bubble.dart';
import 'package:chat_app/services/store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget chatsComponent() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: StreamBuilder(
      stream: StoreServices.getMesssage(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Vx.black)),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: "Start a conversation...".text.semiBold.black.make(),
          );
        } else {
          return ListView(
            children: snapshot.data!.docs.mapIndexed((currentValue, index) {
              var doc = snapshot.data!.docs[index];
              return messageBubble(doc);
            }).toList(),
          );
        }
      },
    ),
  );
}
