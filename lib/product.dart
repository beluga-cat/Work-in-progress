import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterclass9th/home.dart';
import 'package:flutterclass9th/readalldata.dart';

class Product extends StatefulWidget {
  // const Product(String text, {Key? key}) : super(key: key, required this.usercon);
  final String? USERID;

  const Product({Key? key, this.USERID}) : super(key: key);

  @override
  State<Product> createState() => _ProductState(USERID);
}

class _ProductState extends State<Product> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final String? userID;

  _ProductState(this.userID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 18, 46),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: FutureBuilder<DocumentSnapshot>(
            future: users.doc("$userID").get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Text(
                    "Full Name: ${data['full_name']} \n Company: ${data['company']} \n Age: ${data['age']}",
                    style: TextStyle(color: Colors.white, fontSize: 28));
              }

              return CircularProgressIndicator();
            },
          ),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReadAllData()),
              );
            },
            child: Text("Read All Data")),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
            child: Text("Add Data")),
      ]),
    );
  }
}
