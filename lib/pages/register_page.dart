import 'package:flutter/material.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';

import '../services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  RegisterPage({super.key, required this.onTap});



  void register(BuildContext context) async{
    final auth = AuthService();
    if(passwordController.text == confirmPasswordController.text){
      try{
        await auth.signUp(emailController.text, passwordController.text);
      } catch (e){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      }
    } else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("passwords do not match"))
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
              "Let's create an account for you!",
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
            SizedBox(height: 10,),
            MyTextfield(
              hintText:"Confirm Password",
              obscureText: true,
              controller: confirmPasswordController,
            ),
            SizedBox(height: 25,),
            MyButton(
                onTap: () => register(context),
                text: "Register"
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                  ),
                ),
                SizedBox(width: 4,),
                GestureDetector(
                  onTap: onTap ,
                  child: Text(
                    'Login now',
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
