import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

// des
class _AddProductScreenState extends State<AddProductScreen> {
//  input field
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _productSize = TextEditingController();
  final TextEditingController _productMaterial = TextEditingController();
  final TextEditingController _productdes = TextEditingController();

  // image path
  File? _image;
  final TextEditingController _frontController = TextEditingController();
  final TextEditingController _backController = TextEditingController();
  final TextEditingController _leftController = TextEditingController();
  final TextEditingController _rightController = TextEditingController();

  Future<void> _pickFrontImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _frontController.text = _image!.path;
      });
    }
  }

  Future<void> _backImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _backController.text = _image!.path;
      });
    }
  }

  Future<void> _leftImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _leftController.text = _image!.path;
      });
    }
  }

  Future<void> _rightImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _rightController.text = _image!.path;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
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
        title: Text("Kapde"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _productName,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      label: Text("Enter product Name"),
                      hintText: "Enter your product Name",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff22d292)))),
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
                  controller: _productPrice,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text("Enter product price"),
                      hintText: "Enter your product price",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff22d292)))),
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
                  controller: _productSize,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      label: Text("Enter product size"),
                      hintText: "Enter your product size",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff22d292)))),
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
                  controller: _productMaterial,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      label: Text("Enter product Material"),
                      hintText: "Enter your product Material",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff22d292)))),
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
                  controller: _frontController,
                  onTap: () {
                    _pickFrontImage();
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                      label: Text("Enter front image"),
                      hintText: "Enter front image",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff22d292)))),
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
                  controller: _backController,
                  onTap: () {
                    _backImage();
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                      label: Text("Enter back image"),
                      hintText: "Enter back image",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff22d292)))),
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
                  controller: _leftController,
                  onTap: () {
                    _leftImage();
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                      label: Text("Enter left image"),
                      hintText: "Enter left image",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff22d292)))),
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
                  controller: _rightController,
                  onTap: () {
                    _rightImage();
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                      label: Text("Enter right image"),
                      hintText: "Enter right image",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff22d292)))),
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
                  controller: _productdes,
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: "Enter your Product Description",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff22d292)))),
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
                  onTap: addButton,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xff22d292),
                    ),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white, fontSize: 19),
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
      ),
    );
  }

  void addButton() async {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection('Products').add({
        "productName": _productName.text.trim(),
        "productPrice": _productPrice.text.trim(),
        "productSize": _productSize.text.trim(),
        "productMaterial": _productMaterial.text.trim(),
        "frontImage": _frontController.text.trim(),
        "backImage": _backController.text.trim(),
        "leftImage": _leftController.text.trim(),
        "rightImage": _rightController.text.trim(),
        "des": _productdes.text.trim(),
      });
      _productName.clear();
      _productPrice.clear();
      _productSize.clear();
      _productMaterial.clear();
      _frontController.clear();
      _backController.clear();
      _leftController.clear();
      _rightController.clear();
      _productdes.clear();
    } else {
      print("validation failed");
    }
  }
}
