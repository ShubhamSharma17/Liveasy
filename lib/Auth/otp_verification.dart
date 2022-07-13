// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:developer';

import 'package:authentication/Screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPScreen extends StatefulWidget {
  final String verificationID;
  final String phoneNumber;
  const OTPScreen(
      {Key? key, required this.verificationID, required this.phoneNumber})
      : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  String automaticVerifyCode = '';

  @override
  void initState() {
    super.initState();
    listenOTP();
  }

  void listenOTP() async {
    await SmsAutoFill().listenForCode();
    // log('OTp listen successful');
  }

  void verifyOTP() async {
    String otp = automaticVerifyCode.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationID, smsCode: otp);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => HomePage(),
            ));
      }
    } on FirebaseException catch (e) {
      log(e.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    String phone = widget.phoneNumber;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.black),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(height: 50),
          Text(
            'Verify Phone'.tr,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Code is send to '.tr + phone),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: PinFieldAutoFill(
                currentCode: automaticVerifyCode,
                codeLength: 6,
                onCodeChanged: (code) {
                  setState(() {
                    automaticVerifyCode = code.toString();
                  });
                }),
          ),
          SizedBox(height: 25),
          CupertinoButton(
              color: Colors.blue,
              child: Text(
                'Verify and Continue'.tr,
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                verifyOTP();
              })
        ]),
      ),
    );
  }
}
