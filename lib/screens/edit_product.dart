import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kapdeapp/screens/HomeScreen.dart';

class EditProductScreen extends StatefulWidget {
  final String id;
  const EditProductScreen({super.key, required this.id});
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

// des
class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF9F9),
      appBar: AppBar(
        backgroundColor: Color(0xffFFF9F9),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
        title: Text("Edit"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Products")
              .doc(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.hasError}"),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data;
              final formKey = GlobalKey<FormState>();

//  input field
              TextEditingController productName =
                  TextEditingController(text: data!['productName']);
              final TextEditingController productPrice =
                  TextEditingController(text: data['productPrice']);
              final TextEditingController productSize =
                  TextEditingController(text: data['productSize']);
              final TextEditingController productMaterial =
                  TextEditingController(text: data['productMaterial']);
              final TextEditingController productdes =
                  TextEditingController(text: data['des']);

              // image path
              File? image;
              final TextEditingController frontController =
                  TextEditingController(text: data['frontImage']);
              final TextEditingController backController =
                  TextEditingController(text: data['backImage']);
              final TextEditingController leftController =
                  TextEditingController(text: data['leftImage']);
              final TextEditingController rightController =
                  TextEditingController(text: data['rightImage']);

              Future<void> pickFrontImage() async {
                final picker = ImagePicker();
                final XFile? pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    image = File(pickedFile.path);
                    frontController.text = image!.path;
                  });
                }
              }

              Future<void> backImage() async {
                final picker = ImagePicker();
                final XFile? pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    image = File(pickedFile.path);
                    backController.text = image!.path;
                  });
                }
              }

              Future<void> leftImage() async {
                final picker = ImagePicker();
                final XFile? pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    image = File(pickedFile.path);
                    leftController.text = image!.path;
                  });
                }
              }

              Future<void> rightImage() async {
                final picker = ImagePicker();
                final XFile? pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    image = File(pickedFile.path);
                    rightController.text = image!.path;
                  });
                }
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: productName,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              label: Text("Enter product Name"),
                              hintText: "Enter your product Name",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff22d292)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your product Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: productPrice,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              label: Text("Enter product price"),
                              hintText: "Enter your product price",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff22d292)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your product price";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: productSize,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              label: Text("Enter product size"),
                              hintText: "Enter your product size",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff22d292)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your product size";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: productMaterial,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              label: Text("Enter product Material"),
                              hintText: "Enter your product Material",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff22d292)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your product Material";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: frontController,
                          onTap: () {
                            pickFrontImage();
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                              label: Text("Enter front image"),
                              hintText: "Enter front image",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff22d292)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter front image";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: backController,
                          onTap: () {
                            backImage();
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                              label: Text("Enter back image"),
                              hintText: "Enter back image",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff22d292)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter back image";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: leftController,
                          onTap: () {
                            leftImage();
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                              label: Text("Enter left image"),
                              hintText: "Enter left image",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff22d292)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter left image";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: rightController,
                          onTap: () {
                            rightImage();
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                              label: Text("Enter right image"),
                              hintText: "Enter right image",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff22d292)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter right image";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: productdes,
                          maxLines: 4,
                          decoration: InputDecoration(
                              hintText: "Enter your Product Description",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff22d292)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your Address";
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              FirebaseFirestore.instance
                                  .collection('Products')
                                  .doc(widget.id)
                                  .update({
                                "productName": productName.text.trim(),
                                "productPrice": productPrice.text.trim(),
                                "productSize": productSize.text.trim(),
                                "productMaterial": productMaterial.text.trim(),
                                "frontImage": frontController.text.trim(),
                                "backImage": backController.text.trim(),
                                "leftImage": leftController.text.trim(),
                                "rightImage": rightController.text.trim(),
                                "des": productdes.text.trim(),
                              });
                              productName.clear();
                              productPrice.clear();
                              productSize.clear();
                              productMaterial.clear();
                              frontController.clear();
                              backController.clear();
                              leftController.clear();
                              rightController.clear();
                              productdes.clear();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeScreen()));
                            } else {
                              print("validation failed");
                            }
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xff22d292),
                            ),
                            child: Center(
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('Products')
                                .doc(widget.id)
                                .delete();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeScreen()));
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.red[700],
                            ),
                            child: Center(
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Text("no data"),
              );
            }
          }),
    );
  }
}
