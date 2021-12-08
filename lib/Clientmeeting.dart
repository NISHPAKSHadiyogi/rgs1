import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Login.dart';

class ClientMeetingPage extends StatefulWidget {

  @override
  _ClientMeetingPageState createState() => _ClientMeetingPageState();
}

class _ClientMeetingPageState extends State<ClientMeetingPage> {
  @override
  Widget build(BuildContext context) {
    const color = const Color(0xFF563B5A);
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: color,
        title: Text("My Account ",style:TextStyle(color: Colors.white,fontSize: 24) ,),
        centerTitle: true,
        actions: [
          IconButton(
              icon: ImageIcon(
                AssetImage('images/Logout 1@2x.png'),
              ),
              onPressed: () async{
                SharedPreferences preference = await SharedPreferences.getInstance() ;
                await preference.clear();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                //code to execute when this button is pressed
              }
          ),
        ],
      ),
      body:  WebView(
        initialUrl: 'https://myaccount.rgsaccountants.co.uk/',
        javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}

