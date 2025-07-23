import 'package:chatapp/auth/auth_service.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logUserOut(){
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
              onPressed: logUserOut,
              icon: Icon(Icons.logout)
          )
        ],
      ),
    );
  }
}
