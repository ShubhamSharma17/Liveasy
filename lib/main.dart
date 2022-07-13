// ignore_for_file: prefer_const_constructors

import 'package:authentication/Assets/local_string.dart';
import 'package:authentication/Auth/otp_verification.dart';
import 'package:authentication/Auth/phone_auth.dart';
import 'package:authentication/Screen/change_language_page.dart';
import 'package:authentication/Screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
        translations: LocalString(),
        locale: Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser != null)
            ? HomePage()
            // : OTPScreen(verificationID: ' ', phoneNumber: ''),
            : ChangeLanguagePage());
    // : HomePage());
  }
}
