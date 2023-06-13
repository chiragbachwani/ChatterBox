import 'package:chat_app/const/firebase_const.dart';

class StoreServices {
  static getUser(String id) {
    return firebaseFirestore
        .collection(collectionUser)
        .where('id', isEqualTo: id)
        .get();
  }

  static getAllUsers() {
    return firebaseFirestore.collection(collectionUser).snapshots();
  }

  static getChats(String chatId) {
    return firebaseFirestore
        .collection(collectionchats)
        .doc(chatId)
        .collection(collectionMessages)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getMesssage() {
    return firebaseFirestore
        .collection(collectionchats)
        .where("users.${currentUser!.uid}", isEqualTo: null)
        .where("created_on", isNotEqualTo: null)
        .snapshots();
  }
}
