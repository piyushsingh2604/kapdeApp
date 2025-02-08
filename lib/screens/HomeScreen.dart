import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapde/screens/add_product_screen.dart';
import 'package:kapde/screens/edit_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProductScreen(),
              ));
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xffFFF9F9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFFF9F9),
        title: Text("Kapde"),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Products").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!.docs;
            return SizedBox(
              height: screenHeight * 0.99,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProductScreen(id: data[index].id),
                            ));
                      },
                      child: Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color.fromARGB(38, 158, 158, 158),
                                  blurRadius: 6,
                                  spreadRadius: 2)
                            ]),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 10,
                              top: 10,
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            data[index]["frontImage"]),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(13)),
                              ),
                            ),
                            Positioned(
                              left: 120,
                              top: 13,
                              child: Text(
                                data[index]["productName"],
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 120,
                              top: 41,
                              child: Text(
                                "Price: ${data[index]["productPrice"]}",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text("No data found"),
            );
          }
        },
      ),
    );
  }
}
