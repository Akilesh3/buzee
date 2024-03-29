
import 'package:buzee/Components/my_button.dart';
import 'package:buzee/Components/my_textfields.dart';
import 'package:buzee/Components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async{

    //show loading circle
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
     );

    //try sign in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      //pop the loading circle
      Navigator.pop(context);

      //wrong email
      if (e.code == 'user-not-found'){
        wrongEmailMessage();
      //wrong password
      }else if (e.code == 'wrong-password'){
        wrongPasswordMessage();
      }
    }
  }

  //wrong email message popup
  void wrongEmailMessage(){
    showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
            title: Text('Incorrect Email'),
          );
        },
    );
  }

  //wrong password message popup
  void wrongPasswordMessage(){
    showDialog(
      context: context,
      builder: (context){
        return const AlertDialog(
          title: Text('Incorrect Password'),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
              //logo
                const Icon(Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 50),
              //welcome back, you've been missed!
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(color: Colors.grey[700],
                  fontSize: 16),
                ),

                const SizedBox(height: 25),
              //email textfield
                my_textfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),
              //password textfield
                my_textfield(
                  controller: passwordController,
                  hintText: 'password',
                  obscureText: true,
                ),

                const SizedBox(height: 10,),
              //forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          'Forgot password?',
                      style:TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 25.0),
              //sign in button
              MyButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 25),
              //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children:[
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700])

                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height:50),
              //google sign in button

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SquareTile(imagePath: 'img/google.png'),
                    SizedBox(width: 20,),
                  //apple signIn
                    SquareTile(imagePath: 'img/apple.png'),
                  ],
                ),
                const SizedBox(height:50),
              //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('not a member?',
                    style: TextStyle(color: Colors.grey[700])
                    ),
                    const SizedBox(width:4),
                    const Text('register now',
                    style:TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

