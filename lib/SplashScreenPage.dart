
import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'dart:convert';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:rgs/BottomBar.dart';
import 'package:rgs/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Api/ApiConfig.dart';
import 'ConnectionStatus.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;


class SplashScreenpage extends StatefulWidget {

  @override
  SplashScreenpageState createState() =>SplashScreenpageState();
}

class SplashScreenpageState extends State<SplashScreenpage> {
  bool sitestatus = false;
  bool logIN = false;

  void initState() {
    super.initState();

    //getPrefance();
    // SiteSetting();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        body: Column(
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/nointernet.jpg"),
                //  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ));
  }
}