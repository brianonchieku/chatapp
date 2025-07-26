import 'package:chatapp/components/my_textfield.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/chat/chart_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  final TextEditingController messageController = TextEditingController();
  final AuthService authService = AuthService();
  final ChatService chatService = ChatService();

  void sendMessage() async{
    if(messageController.text.isNotEmpty){
      await chatService.sendMessage(receiverID, messageController.text);
      messageController.clear();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(child: buildMessageList()),
          buildUserInput()
        ],
      ),
    );
  }

  Widget buildMessageList(){
    final String senderID = authService.currentUer()!.uid;
    return StreamBuilder(
        stream: chatService.getMessage(senderID, receiverID),
        builder: (context, snapshots){
          if(snapshots.hasError){
            return Text('Error');
          }
          if(snapshots.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshots.data!.docs.map((doc) => buildMessageItem(doc)).toList(),
          );

        }
    );
  }

  Widget buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser = data['senderID'] == authService.currentUer()!.uid;
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
        child: Column(
          crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
                data['message']),
          ],
        )
    );
  }

  Widget buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          Expanded(
              child: MyTextfield(
                  hintText: "Type a message",
                  obscureText: false,
                  controller: messageController
              )
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: sendMessage,
                icon: Icon(Icons.send, color: Colors.white,)
            ),
          )
        ],
      ),
    )
  }
}
