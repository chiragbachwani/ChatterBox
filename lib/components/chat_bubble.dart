import 'package:chat_app/const/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

Widget chatBubble(index, DocumentSnapshot doc) {
  var t =
      doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Directionality(
    textDirection:
        doc['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                doc['uid'] == currentUser!.uid ? Vx.black : Vx.purple600,
            child: Image.asset(
              "assets/user.png",
              color: Colors.white,
            ),
          ),
          20.widthBox,
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  color: doc['uid'] == currentUser!.uid
                      ? Vx.purple600
                      : Vx.gray700,
                  borderRadius: BorderRadius.circular(16)),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: "${doc['msg']}".text.white.semiBold.make(),
              ),
            ),
          ),
          10.widthBox,
          Directionality(
            textDirection: TextDirection.ltr,
            child:
                time.text.size(12).fontWeight(FontWeight.w400).gray600.make(),
          )
        ],
      ),
    ),
  );
}
