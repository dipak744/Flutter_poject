import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:login_page/components/my_button.dart';
import 'package:login_page/components/my_textfield.dart';
import 'package:login_page/components/square_tile.dart';
import 'package:login_page/pages/login_page.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

  final passwordController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
         child: SingleChildScrollView(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
               
              //logo
              const Icon(
                Icons.lock,
                size: 100,
              ),
         
              const SizedBox(height: 50),
         
              //welcome
              Text(
                'GRAHAK',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 24,
         
                ),
              
              ),
            
              const SizedBox(height: 25),
         
              //username textfield
              MyTextField(
                controller: emailController,
                hintText: 'email',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              
         
              //email textfield
              MyTextField(
                controller: passwordController,
                hintText: 'password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
         
              const SizedBox(height: 25),
              GestureDetector(
      onTap: (){
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  auth
                      .createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value){
                        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
                      });
                },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin:const  EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
          "Regiser Now",
          style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          ),
         
          ),
          ),
      ),
    ),
              //sign in button
              // MyButton(
              //   onTap: , text: 'Sign Up',
              // ),
         
              const SizedBox(height: 50),
         
              //or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                     ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10.0),
                      child: Text(
                        'or continue with',
                        style: TextStyle(color: Colors.grey[700]),
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
         
              const SizedBox(height: 50),
         
              //google + apple sign in buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google button
                  SquareTilee(imagePath: 'lib/images/goo.png'),
         
                  SizedBox(width:25),
         
                  //apple button
                  SquareTilee(imagePath: 'lib/images/apple.png'),
                
                ],
              ),
              const SizedBox(height: 50),
         
              //not registered yet?
              Row(
  children: [
    const SizedBox(width: 4),
    Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: const Row(
          children: [
            SizedBox(width: 80,),
            Text(
              
              'Already a Member  ??   ',
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              
              'Login Now',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
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