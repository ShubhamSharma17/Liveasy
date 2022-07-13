// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, equal_keys_in_map, sized_box_for_whitespace, unused_import

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../Auth/phone_auth.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({Key? key}) : super(key: key);

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  String selectedValue = 'English';

  final List locale = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'हिन्दी', 'locale': Locale('hi', 'IN')}
  ];
  upDateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  buildDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text(''),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          upDateLanguage(locale[index]['locale']);
                          setState(() {
                            selectedValue = locale[index]['name'].toString();
                          });
                        },
                        child: Text(locale[index]['name']),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please select your Language'.tr,
                style: TextStyle(fontSize: 25)),
            SizedBox(height: 5),
            Text('You can change the language'.tr,
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 5),
            Text('at any time'.tr, style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                buildDialog(context);
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                width: MediaQuery.of(context).size.width * .5,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedValue,
                          style: TextStyle(fontSize: 20),
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    )),
              ),
            ),
            SizedBox(height: 20),
            CupertinoButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: ((context) => PhoneScreen())));
                },
                child: Text('NEXT'.tr))
          ],
        ),
      ),
    );
  }
}
