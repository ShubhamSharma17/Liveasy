// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:authentication/Auth/phone_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => PhoneScreen(),
        ));
  }

  int _radioSelected = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Home Screen',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  signOut();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'Please select your profile'.tr,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _radioSelected,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          _radioSelected = value.hashCode;
                        });
                      },
                    ),
                    Icon(Icons.home, size: 40),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shipper',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Eiusmod excepteur qui non reprehend \n construct Ea dolore velit eu ex ',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: _radioSelected,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          _radioSelected = value.hashCode;
                          // _radioVal = 'male';
                        });
                      },
                    ),
                    Icon(Icons.local_shipping, size: 40),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transponder',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Eiusmod excepteur qui non reprehend \n construct Ea dolore velit eu ex ',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            CupertinoButton(
                color: Colors.blue, child: Text('CONTINUE'), onPressed: () {})
          ],
        ),
      ),
    ));
  }
}
