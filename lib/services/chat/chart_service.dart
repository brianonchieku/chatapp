import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService{

  //get instance of firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUserStream(){
    return firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }


  //send messages
  Future<void> sendMessage(String receiverID, message) async{
    //get current user info
    final String currentUserID = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create new message
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp
    );

    //construct chatroom id for the two users
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); //sort the ids(this ensures the chatroomid is the same for any two people)
    String chatroomID = ids.join("_");

    //add new message to database
    await firestore.collection("chat_rooms").doc(chatroomID).collection("messages").add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessage(String userID, otherUserID){
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatroomID = ids.join("_");
    
    return firestore.collection("chat_rooms").doc(chatroomID).collection("messages").orderBy("timestamp", descending: false).snapshots();
  }

}