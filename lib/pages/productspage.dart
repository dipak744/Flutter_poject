// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_page/pages/square_tile.dart';

class CostumerPage extends StatelessWidget {
  const CostumerPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController bidconteroller = TextEditingController();
    return Scaffold(
    appBar: AppBar(
      title: const Text("Products List"),
    ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            // print("Aayshuh");
            return const CircularProgressIndicator(); // Show loading indicator while fetching data
          }
          // print("aaysuh");
          final documents = snapshot.data!.docs;
          // ignore: avoid_print
          print(documents);
    
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              var data = documents[index].data() as Map<String, dynamic>;
              // print(data);
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 200,
                  // width: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 20,),
                      CircleAvatar(
                                      backgroundImage:
                                          data['image-url'] != ''
                                              ? Image.network(
                                                      data['image-url']
                                                      .toString())
                                                  .image
                                              : null,
                                      backgroundColor: const Color.fromARGB(
                                          255, 230, 227, 227),
                                      radius: 55,
                                    ),
                    // const SizedBox(width: 10,),
                    SizedBox(
                      width: 150,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const SizedBox(height: 50,),
                        Text("Name :"+data['product-name']),
                        
                        Text("Price : "+data['price']),
                        Text("Biddin price: "+data['bid-price']),
                        Text("Description: " + data['description'],),
                        const SizedBox(height: 5,),
                        TextFormField(
                                controller: bidconteroller,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8), // Adjust border radius as needed
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10), // Adjust padding
                                  hintText: "Bid Here",
                                ),
                              ),
                        
                      ],),
                    ),
                    SizedBox(
                      
                      width: 50,
                      child: RoundBtn(height:20 , width: 30, ontap: () {
                        final firestore = FirebaseFirestore.instance.collection('Products');
                        firestore
                            .doc(data['product-name'])
                            .set({'bid-price': bidconteroller.text}, SetOptions(merge: true));
                        bidconteroller.clear();
                    
                        }, text: 'Bid',),
                    ),

                    const   SizedBox(width: 10,)
                    ],
                  )
                ),
              );
              
            },
          );
        },
      ),
    );
}}