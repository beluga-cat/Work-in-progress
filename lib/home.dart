import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterclass9th/product.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': namecon.text, // John Doe
          'company': compcon.text, // Stokes and Sons
          'age': agecon.text // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  TextEditingController namecon = TextEditingController();
  TextEditingController compcon = TextEditingController();
  TextEditingController agecon = TextEditingController();
  TextEditingController? usercon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: TextField(
                controller: namecon,
                decoration: const InputDecoration(hintText: "Name"),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: TextField(
                controller: compcon,
                decoration: const InputDecoration(hintText: "Company"),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: TextField(
                decoration: const InputDecoration(hintText: "Age"),
                controller: agecon,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            ElevatedButton(
                onPressed: () {
                  addUser();
                },
                child: const Text("Add")),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: TextField(
                decoration: const InputDecoration(hintText: "User ID"),
                controller: usercon,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (usercon!.text == "") {
                    print("Nothing in Field Text");
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Product(
                                USERID: usercon!.text,
                              )),
                    );
                  }
                },
                child: const Text("Find")),
          ],
        ),
      )),
    );
  }
}
