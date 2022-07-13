// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:authentication/Auth/otp_verification.dart';
import 'package:authentication/Screen/change_language_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController phoneController = TextEditingController();

  void sendOTP() async {
    String phone = '+91${phoneController.text.trim()}';

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationID, resendToken) {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => OTPScreen(
                      verificationID: verificationID,
                      phoneNumber: phoneController.text.trim())));
        },
        verificationCompleted: (credential) {},
        verificationFailed: (e) {
          log(e.code.toString());
        },
        codeAutoRetrievalTimeout: (verificationID) {},
        timeout: Duration(seconds: 30),
      );
    } on FirebaseException catch (e) {
      log(e.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ChangeLanguagePage()));
            },
            icon: Icon(Icons.cancel),
            color: Colors.black),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(height: 80),
            Text(
              'Please enter your mobile number'.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'you will receive a 6 digit'.tr,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'to verify next'.tr,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: InternationalPhoneNumberInput(
                  inputBorder: InputBorder.none,
                  selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    setSelectorButtonAsPrefixIcon: true,
                    leadingPadding: 20,
                    useEmoji: true,
                  ),
                  textFieldController: phoneController,
                  hintText: 'Enter Your number here!'.tr,
                  onInputChanged: ((value) {})),
            ),
            SizedBox(height: 15),
            CupertinoButton(
              color: Colors.blue,
              child: Text('CONTINUE'.tr),
              onPressed: () {
                sendOTP();
              },
            ),
          ],
        ),
      )),
    );
  }
}
