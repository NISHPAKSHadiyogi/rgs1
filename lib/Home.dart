import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//ignore: import_of_legacy_library_into_null_safe

import 'package:rgs/AboutUs.dart';
import 'package:rgs/Clientmeeting.dart';
import 'package:rgs/ContactUs.dart';
import 'package:rgs/KeyTaxDates.dart';
import 'package:rgs/OtpVerify.dart';
import 'package:rgs/Quickbooks.dart';
import 'package:rgs/Realtime.dart';
import 'package:rgs/TaxTable.dart';
import 'package:rgs/bookingmeeting.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';
import 'MileageTracker.dart';
class Home extends StatefulWidget {
  static TextEditingController Controlleruser = TextEditingController();
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

  late Timer _timer;
  int _start = 60;
  var _start1 ;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Fluttertoast.showToast(msg: "home");
  }

  @override

  Widget build(BuildContext context) {
  Size size =  MediaQuery.of(context).size;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // TextEditingController Controlleruser = TextEditingController();
    bool hidepassword = true;
    const color = const Color(0xFF563B5A);
    const color2 = const Color(0xFF162037);


    // startTimer();
    return Scaffold(


      // backgroundColor: Colors.white,
     appBar: AppBar(
       title:Container(child: Image.asset('images/icon.png',height: 150,width: 150,)),
      centerTitle: true,
    backgroundColor: color,
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
    //    backgroundColor: color,
    //    title: Image( image: AssetImage('images/4860636@2x.png'),),
    //      centerTitle: true,
    //      actions: [
    //  IconButton(
    //  icon: ImageIcon(
    //    AssetImage('images/Logout 1@2x.png'),
    //  ),
    //     onPressed: (){
    //    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    //       //code to execute when this button is pressed
    //     }
    // ),
    //      ],
     ),
      body:

      Stack(

        children: <Widget>[
          // Map View

          // Show zoom buttons
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,top: 20.0,right: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[



                    Wrap(
                      spacing: 20.0, // gap between adjacent chips
                      runSpacing: 25.0,
                      children: <Widget>[
                        Column(
                            children:[
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(

                                    context,
                                    MaterialPageRoute(builder: (context) =>  AboutusScreen()),
                                  );

                                },
                                child: Container(
                                  decoration: BoxDecoration(color:color2,
                                    border: Border.all(width: 1.1),


                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  width: width/4,
                                  height: height/8,
                                  margin: const EdgeInsets.all(2.0),
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),


                                  child: Stack(
                                    children: [

                                      Container(
                                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                          height: width/3.5,
                                          width: height/9,
                                          child: Image(image: AssetImage('images/info.png'),)

                                      ),


                                    ],
                                  ),
                                ),
                              ),
                              Text("About Us",style:TextStyle(color: color,fontSize: 9) ,),
                            ]
                        ),
                        GestureDetector(
                          child: Column(
                              children:[
                                Container(
                                    decoration: BoxDecoration(color:color2,
                                      border: Border.all(width: 1.1),


                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    width: width/4,
                                    height: height/8,
                                    margin: const EdgeInsets.all(2.0),
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),


                                    child: Stack(
                                      children: [
                                        Container(

                                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                            height: width/4,
                                            width: height/8,
                                            child: Image(image: AssetImage('images/Booking-Metting 1@2x.png'),)
                                        ),

                                      ],
                                    )


                                ),
                                Text("Book a Meeting",style:TextStyle(color: color,fontSize: 9) ,),
                              ]
                          ),
                          onTap: (){var formbottom = 3;
                            Navigator.push(

                              context,
                              MaterialPageRoute(builder: (context) =>  BookingMeetingPage(formbottom)),
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(

                              context,
                              MaterialPageRoute(builder: (context) =>  ClientMeetingPage()),
                            );
                          },
                          child: Column(
                              children:[
                                Container(
                                    decoration: BoxDecoration(color:color2,
                                      border: Border.all(width: 1.1),


                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    width: width/4,
                                    height: height/8,
                                    margin: const EdgeInsets.all(2.0),
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),


                                    child: Stack(
                                      children: [
                                        Container(

                                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                          height: width/4,
                                          width: height/8,
                                          child: Image(image: AssetImage('images/Client-Portal 1@2x.png'),),

                                        ),

                                      ],
                                    )


                                ),
                                Text("Client Portal",style:TextStyle(color: color,fontSize: 9) ,),
                              ]
                          ),
                        ),
                        Column(
                            children:[
                              GestureDetector(
                                onTap: (){var frombottom1 = 2;
                                  Navigator.push(

                                    context,
                                    MaterialPageRoute(builder: (context) =>  Chatscreen(frombottom1)),
                                  );

                                },
                                child: Container(
                                    decoration: BoxDecoration(color:color2,
                                      border: Border.all(width: 1.1),


                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    width: width/4,
                                    height: height/8,
                                    margin: const EdgeInsets.all(2.0),
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),


                                    child: Stack(
                                      children: [
                                        Container(

                                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                            height: width/4,
                                            width: height/8,
                                            child: Image(image: AssetImage('images/Real-Time-Chat 1@2x.png'),)
                                        ),

                                      ],
                                    )


                                ),
                              ),
                              Text("Real Time Chat",style:TextStyle(color: color,fontSize: 9) ,),
                            ]
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(

                              context,
                              MaterialPageRoute(builder: (context) => QuickbookPage()),
                            );
                          },

                          child: Column(
                              children:[
                                Container(
                                  decoration: BoxDecoration(color:color2,
                                    border: Border.all(width: 1.1),


                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  width: width/4,
                                  height: height/8,
                                  margin: const EdgeInsets.all(2.0),
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),


                                  child: Stack(
                                    children: [


                                      Container(
                                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                          height: width/4,
                                          width: height/8,
                                          child: Image(image: AssetImage('images/Quick-books 1@2x.png'),)

                                      ),



                                    ],
                                  ),
                                ),
                                Text(" Open Quickbooks",style:TextStyle(color: color,fontSize: 9) ,),
                              ]
                          ),
                        ),
                        Column(
                            children:[
                              GestureDetector(
                                onTap: () {var  frombottom=1;

                                  Navigator.push(

                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        MileageTrackerPage(frombottom)),
                                  );
                                },

                                child: Container(
                                    decoration: BoxDecoration(color:color2,
                                      border: Border.all(width: 1.1),


                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    width: width/4,
                                    height: height/8,
                                    margin: const EdgeInsets.all(2.0),
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),


                                    child: Stack(
                                      children: [
                                        Container(

                                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                            height: width/4,
                                            width: height/8,
                                            child: Image(image: AssetImage('images/car.png'),)
                                        ),

                                      ],
                                    )


                                ),
                              ),
                              Text("Mileage Tracker",style:TextStyle(color: color,fontSize: 9) ,),
                            ]
                        ),
                        Column(
                          children:[
                        Container(
                            decoration: BoxDecoration(color:color2,
                              border: Border.all(width: 1.1),


                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            width: width/4,
                            height: height/8,
                            margin: const EdgeInsets.all(2.0),
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),


                            child: Stack(
                              children: [
                                Container(

                                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    height: width/4,
                                    width: height/8,
                                    child: new GestureDetector(
                                      onTap: () {
                                        Navigator.push(

                                          context,
                                          MaterialPageRoute(builder: (context) =>
                                              KeyTaxDates()),
                                        );
                                      },
                                        child: Image(image: AssetImage('images/Key-Tax-Dates 1@2x.png'),)
                                    ),
                                ),

                              ],
                            )


                        ),
                            Text("Key Text Dates",style:TextStyle(color: color,fontSize: 9) ,),
                          ]
                        ),
                        Column(
                            children:[
                              Container(
                                  decoration: BoxDecoration(color:color2,
                                    border: Border.all(width: 1.1),


                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  width: width/4,
                                  height: height/8,
                                  margin: const EdgeInsets.all(2.0),
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),


                                  child: Stack(
                                    children: [
                                      Container(

                                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        height: width/4,
                                        width: height/8,
                                        child: new GestureDetector(
                                          onTap: () {
                                            Navigator.push(

                                              context,
                                              MaterialPageRoute(builder: (context) =>  TaxTable()),
                                            );
                                          },
                                          child:  Image(image: AssetImage('images/calender.png'),),
                                        ),
                                        //child: Image(image: AssetImage('images/3257419 1@2x.png'),)
                                      ),

                                    ],
                                  )


                              ),
                              Text("Tax Tables",style:TextStyle(color: color,fontSize: 9) ,),
                            ]
                        ),
                        Column(
                          children:[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(

                              context,
                              MaterialPageRoute(builder: (context) =>  ContactusScreen()),
                            );

                          },
                          child: Container(
                            decoration: BoxDecoration(color:color2,
                              border: Border.all(width: 1.1),


                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            width: width/4,
                            height: height/8,
                            margin: const EdgeInsets.all(2.0),
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),


                            child: Stack(
                              children: [

                                    Container(
                                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        height: width/4,
                                        width: height/8,
                                        child: Image(image: AssetImage('images/contact_us 1@2x.png'),)

                                    ),

                                  ],

                            ),
                          ),
                        ),
                            Text("Contact Us",style:TextStyle(color: color,fontSize: 9) ,),
                          ]
                        ),

                      ],
                    ),



                  ],

                ),
              ),
            ),
          ),
        ],
      ),
     //bottomNavigationBar: bottomNavigationBar,
    ); // showing the route
  }
  Widget get bottomNavigationBar {
    return
      Container(
        decoration: BoxDecoration(color:Colors.red,
        border: Border.all(width: 0.5),

    borderRadius: BorderRadius.circular(200.0),
    ),
        margin: const EdgeInsets.all(10.0),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:
      ClipRRect(

      clipBehavior: Clip.antiAliasWithSaveLayer,

      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(200),
        topLeft: Radius.circular(200),
        bottomLeft: Radius.circular(200),
        bottomRight: Radius.circular(200),

      ),
      child: BottomNavigationBar(
        iconSize: 35,
        items: const [
          BottomNavigationBarItem(


            icon: ImageIcon(
              AssetImage('images/4860638@2x.png'),
          ), label: ''  ,),
          BottomNavigationBarItem(icon: ImageIcon(
            AssetImage('images/3257419 - Copy 1@2x.png'),
          ), label: '.'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('images/Home-icon 1@2x.png'),
              ), label: '.'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('images/Booking-Metting - Copy 1@2x.png'),
              ), label: '.'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('images/User_font_awesome 2@2x.png'),
              ), label: '.'),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        showUnselectedLabels: false,
      ),
    ),
      );

  }
}

class CustomEventDialog extends StatefulWidget {
  final title;
  final  content;
  CustomEventDialog({this.title, this.content});

  @override
  CustomEventDialogState createState() => new CustomEventDialogState();
}

class CustomEventDialogState extends State<CustomEventDialog> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Dialog(
        backgroundColor: Colors.transparent,

        child: Container(
          width: size.width*0.7,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            color: Colors.white,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Wrap(
              children: <Widget>[

                Center(
                  child: Container(
                    height: size.height*.27,
                    width: size.width*.75,

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 3),

                          height: 50,
                          width: size.width*.85,
                          //alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xFF563B5A),
                            borderRadius: BorderRadius.all(
                                Radius.circular(0)
                            ),
                            border: Border.all(
                              color: Color(0xFF563B5A),
                            ),
                          ),
                          child: Center(
                            child: Text("Open external app",
                              style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.w700),),
                          ),

                        ),
                        SizedBox(height: 10,),
                        Center(
                          child: Text('Open QuickBooks App will be launched.',
                            style: TextStyle(color: Colors.grey,
                          fontSize: 15),),
                        ),
                        SizedBox(height: 7,),
                        Center(child: Text('Are you sure?',
                          style: TextStyle(color: Colors.grey,fontSize: 15),)),
                        SizedBox(height: 25,),



                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 5),

                                height: 40,
                                width: size.width*.25,
                                //alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:Color(0xFF563B5A),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5)
                                  ),
                                  border: Border.all(
                                    color: Color(0xFF563B5A),
                                  ),
                                ),
                                child: Center(
                                  child: Text("Yes",
                                    style: TextStyle(color:Colors.white,fontSize: 15),),
                                ),

                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),

                              height: 40,
                              width: size.width*.25,
                              //alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)
                                ),
                                border: Border.all(
                                  color: Color(0xFF563B5A),
                                ),
                              ),
                              child: Center(
                                child: Text("No",
                                  style: TextStyle(color:Color(0xFF563B5A),fontSize: 15),),
                              ),

                            ),
                          ],
                        ),







                        //Text(_selectedGender == 'male' ? 'Hello gentlement!' : 'Hi lady!')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}