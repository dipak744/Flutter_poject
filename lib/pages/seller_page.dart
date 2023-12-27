// import 'dart:html';

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_page/pages/square_tile.dart';

// ... imports

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {

  File? _image;
  final imagePicker = ImagePicker();
  final _auth = FirebaseAuth.instance;

  
TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController aboutmecontroller = TextEditingController();
  _loadimagefromgallery() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    // detect_image(_image);
  }
  // ignore: unused_element
  _loadimagefromcamera() async {
    var image = await imagePicker.pickImage(source: ImageSource.camera);

    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    // detect_image(_image);
  }

  uploadphoto(BuildContext context, imageurl , a) async {
    final firestore = FirebaseFirestore.instance.collection('Products');
    var user = _auth.currentUser;
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref('${user!.email!}Profile$id');
    UploadTask uploadTask = reference.putFile(imageurl);

    await Future.value(uploadTask).then((value) async {
      var newUrl = await reference.getDownloadURL();
      
      firestore
          .doc(a)
          .set({'image-url': newUrl}, SetOptions(merge: true));
    }).onError((error, stackTrace) {
      // PopUpMessages.flushBarErrorMessage(error.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    
                  ),
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.purple.shade300,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(175),
                      )),
                ),
                Align(
                    heightFactor: 2.1,
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                        radius: 70,
                        child: InkWell(
                          onTap: () {
                            _loadimagefromgallery();
                            setState(() {});
                          },
                          child: 
                          CircleAvatar(
                            backgroundImage: _image != null
                            ? FileImage(_image!)
                            : null,
                               
                            backgroundColor: const Color.fromARGB(255, 230, 227, 227),
                            radius: 65,
                            
                          ),
                        ))),
                const Align(
                    heightFactor: 5,
                    alignment: Alignment.center,
                    child: Text(
                      "SELL YOUR ITEMS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    )),
              ],
            ),
            SetupTextField(
              controller: firstnamecontroller,
              text: 'Product Name',
              icon: Icons.first_page,
            ),
            SetupTextField(
              controller: lastnamecontroller,
              text: 'Price',
              icon: Icons.last_page,
            ),
            SetupTextField(
              controller: phonenumbercontroller,
              text: 'Category',
              icon: Icons.interests,
            ),
            
            AboutYouTextField(
              controller: aboutmecontroller,
              text: 'Description',
            ),
            RoundBtn(
              text: "Save  ",
              height: 50,
              width: 700,
              ontap: () {
                var user = _auth.currentUser;
                CollectionReference ref = FirebaseFirestore.instance.collection('Products');
                ref.doc(firstnamecontroller.text).set({
                'product-name': firstnamecontroller.text,
                'price': lastnamecontroller.text,
                'bid-price': lastnamecontroller.text,
                'description': aboutmecontroller.text,
                'image-url': '',
                'product-holder':user!.uid
    }).then((value) {
      uploadphoto(context,_image!.absolute,firstnamecontroller.text);
    });
              },
            )
          ],
        ),
      ),
    );
  }
}
