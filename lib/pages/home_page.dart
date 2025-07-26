import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chart_service.dart';
import 'package:flutter/material.dart';

import '../components/user_tile.dart';
import 'chat_page.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Drawer(),
      body: buildUserList(),
    );
  }

  Widget buildUserList(){
    return StreamBuilder(
        stream: chatService.getUserStream(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text('Error');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.map<Widget>((userData) => buildUserListItem(userData, context)).toList(),
          );

        }
    );
  }

  Widget buildUserListItem(Map<String, dynamic> userData, BuildContext context){
    //display all users except current user
    if(userData["email"] != authService.currentUer()!.email){
      return UserTile(
        text: userData['email'],
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData['email'],
              )
          )

          );
        },
      );
    } else{
      return Container();
    }
  }
}

