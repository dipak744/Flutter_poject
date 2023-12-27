import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
// import 'package:login_page/pages/customer_page.dart';
import 'package:login_page/pages/productspage.dart';
import 'package:login_page/pages/seller_page.dart';
//import 'package:login_page/pages/grocery_upload_screen.dart';

class HomePagee extends StatelessWidget {
  HomePagee({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // Sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: SizedBox( // Added SizedBox to control overall width
          width: 300, // Adjust width as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 80),
              // Center the "Logged in as" text
              Align(
                alignment: Alignment.center,
                child: Text(
                  "LOGGED IN AS: ${user.email!}",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30), // Spacing between text and buttons
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Bigger buttons with spacing
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(30),
                        textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        minimumSize: const Size.fromHeight(75), // Adjust height as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Scaffold(
                            backgroundColor: Colors.orange,
                            body: CostumerPage(),
                            ),
                        ),
                        );
                      },
                      child: const Text('Customer'),
                    ),
                    const SizedBox(height: 40), // Spacing between buttons
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(30),
                        textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        minimumSize: const Size.fromHeight(75),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SellerPage()
                          ),
                        );
                      },
                      child: const Text('Seller'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
