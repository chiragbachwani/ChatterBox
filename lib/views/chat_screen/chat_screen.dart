import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/controller/chats_controller.dart';
import 'package:chat_app/services/store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: Vx.gray800,
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ).onTap(() {
          Get.back();
        }),
        backgroundColor: Colors.transparent,
        actions: const [
          Icon(
            Icons.more_vert_rounded,
            color: Colors.white,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          color: Vx.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                      child: RichText(
                          text: TextSpan(children: [
                    TextSpan(
                      text: "${controller.friendname}\n",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    const TextSpan(
                      text: "Last seen",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Vx.gray600,
                          fontSize: 12),
                    ),
                  ]))),
                  const CircleAvatar(
                    backgroundColor: Vx.purple600,
                    child: Icon(
                      Icons.video_call_rounded,
                      color: Colors.white,
                    ),
                  ),
                  10.widthBox,
                  const CircleAvatar(
                    backgroundColor: Vx.purple600,
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            25.heightBox,
            Obx(
              () => Expanded(
                child: controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Vx.gray800),
                        ),
                      )
                    : StreamBuilder(
                        stream: StoreServices.getChats(controller.chatId),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          }
                          else{
                            return ListView(
                            children: snapshot.data!.docs
                                .mapIndexed((currentValue, index) {
                              var doc = snapshot.data!.docs[index];

                              return chatBubble(index, doc);
                            }).toList(),
                          );
                          }

                          
                        },
                      ),
              ),
            ),
            10.heightBox,
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: Vx.purple400,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        controller: controller.messageController,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.emoji_emotions_rounded,
                              color: Vx.gray300,
                            ),
                            suffixIcon: Icon(
                              Icons.attach_file_sharp,
                              color: Vx.gray300,
                            ),
                            border: InputBorder.none,
                            hintText: "Type your message here ....",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Vx.gray300)),
                      ),
                    ),
                  ),
                  20.widthBox,
                  GestureDetector(
                    onTap: () {
                      controller.sendMessage(controller.messageController.text);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Vx.purple400,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
