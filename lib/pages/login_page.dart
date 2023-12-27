
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/components/my_button.dart';
import 'package:login_page/components/my_textfield.dart';
import 'package:login_page/components/square_tile.dart';
//import 'package:login_page/pages/customer_page.dart';
import 'package:login_page/pages/home_page.dart';
import 'package:login_page/pages/signup.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  // final Function()? onTap;
  // const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();


  //sign user in method
  void signUserIn() async {
    //show loading circle
    showDialog(
      context: context, 
      builder: (context) {
      return const Center(
        child: CircularProgressIndicator()
        );
      },
    );
  

  //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
      ).then((value) {
        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePagee()
                          ),
                        );
      });



    } on FirebaseAuthException catch (e) {

      
      //show error message
      showErrorMessage(e.code);



      
    }

    
  }

  //error message
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              ' Incorrect Email',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
      );
    
  }


  

  @override
  Widget build(BuildContext context) {
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
         
              //forget passward?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forget Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
         
              //sign in button
              MyButton(
                onTap: signUserIn, text: '',
              ),
         
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
            MaterialPageRoute(builder: (context) => const SignupPage()),
          );
        },
        child:const Row(
          children: [
            SizedBox(width: 80,),
            Text(
              
              'Not a Member  ??   ',
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              
              'Register Now',
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