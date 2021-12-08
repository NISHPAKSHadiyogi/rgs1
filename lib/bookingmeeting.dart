import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Login.dart';

class BookingMeetingPage extends StatefulWidget {
  var formbottom2;
  BookingMeetingPage(this.formbottom2);

  @override
  _BookingMeetingPageState createState() => _BookingMeetingPageState();
}

class _BookingMeetingPageState extends State<BookingMeetingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Fluttertoast.showToast(msg: "BookingMeetingPage");
  }
  @override
  Widget build(BuildContext context) {
    const color = const Color(0xFF563B5A);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text("Book a Meeting ",style:TextStyle(color: Colors.white,fontSize: 22) ,),
        centerTitle: true,
        leading: widget.formbottom2 == 3 ?GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back)):Container(),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: ImageIcon(
                AssetImage('images/Logout 1@2x.png'),
              ),
              onPressed: () async{
                SharedPreferences preference = await SharedPreferences.getInstance() ;
                preference.clear();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                //code to execute when this button is pressed
              }
          ),
        ],
      ),
      body:  WebView(
        initialUrl: 'https://calendly.com/rgsbooknow/client',
        javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}
