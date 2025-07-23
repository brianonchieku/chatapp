import 'package:chatapp/auth/auth_service.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  final void Function()? onTap;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) async{
    final authService = AuthService();
    try{
      await authService.signIn(emailController.text, passwordController.text);
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, size: 60, color: Theme.of(context).colorScheme.primary,),
            SizedBox(height: 50,),
            Text(
                "Welcome back, you've been missed",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16
              ),

            ),
            SizedBox(height: 25,),
            MyTextfield(
              hintText:"Email",
              obscureText: false,
              controller: emailController,
            ),
            SizedBox(height: 10,),
            MyTextfield(
              hintText:"Password",
              obscureText: true,
              controller: passwordController,
            ),
            SizedBox(height: 25,),
            MyButton(
                onTap: () => login(context),
                text: "Login"
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                  ),
                ),
                SizedBox(width: 4,),
                GestureDetector(
                  onTap: onTap ,
                  child: Text(
                    'Register now',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),

    );
  }
}
