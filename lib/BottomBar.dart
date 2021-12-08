import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rgs/TaxTable.dart';
import 'package:rgs/bookingmeeting.dart';

import 'Home.dart';
import 'MileageTracker.dart';

import 'Realtime.dart';
import 'UserProfile.dart';
String frobottom = '0';
String frobottom1 = '1';
String frobottom2 = '2';


class BottomBar extends StatefulWidget {
  int bottom;
  BottomBar({ required this.bottom});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<BottomBar> {
  int _selectedItemIndex = 0;

  final List pages = [
    MileageTrackerPage( frobottom),
    Chatscreen(frobottom1),
    Home(),
    BookingMeetingPage(frobottom2),
    UserProfileData(),
  ];

  setBottomBarIndex(index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedItemIndex = widget.bottom == null ? 2 : widget.bottom;

    });
  }

  @override
  Widget build(BuildContext context) {
    const color = const Color(0xFF563B5A);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,

       width: double.infinity,


        decoration: BoxDecoration(color:Colors.white,
          border: Border.all(width: 0.0,color: Colors.grey),

          borderRadius:  BorderRadius.only(
            topRight: Radius.circular(200),
            topLeft: Radius.circular(200),
            bottomLeft: Radius.circular(200),
            bottomRight: Radius.circular(200),

          ),
        ),

        margin: const EdgeInsets.all(0.0),
        //padding: EdgeInsets.fromLTRB(5, 1, 1, 5),
        child: Row(


          children: [

            buildNavBarItem(Image.asset('images/bottomcar.png',), Text("."), 0),
            buildNavBarItem(Image.asset('images/chat.png',), Text(""), 1),
            buildNavBarItem(Image.asset('images/Home-icon 1@2x.png',), Text(""), 2),
            buildNavBarItem(Image.asset('images/Booking-Metting - Copy 1@2x.png',), Text(""), 3),
            buildNavBarItem(Image.asset('images/User_font_awesome 2@2x.png',), Text(""), 4),

          ],
        ),
      ),
      // floatingActionButton: GestureDetector(
      //   child: Container(
      //     height: 75,
      //     width: 75,
      //     decoration: BoxDecoration(
      //       color: _selectedItemIndex == 2 ? Colors.white : Colors.white54,
      //       boxShadow: [
      //         BoxShadow(
      //             color: _selectedItemIndex == 2
      //                 ? Colors.white.withOpacity(0.5)
      //                 : Colors.white54,
      //             blurRadius: 5,
      //             spreadRadius: 7)
      //       ],
      //       borderRadius: BorderRadius.circular(80.0),
      //     ),
      //     padding: EdgeInsets.all(12),
      //     child: Image.asset(
      //       'assets/images/comment.png',
      //       //fit: BoxFit.contain,
      //     ),
      //   ),
      //   onTap: () {
      //     showModalBottomSheet<void>(
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.vertical(
      //           top: Radius.circular(20)
      //         )
      //       ),
      //
      //
      //       context: context,
      //       builder: (BuildContext context) {
      //         return Container(
      //           color: Colors.white,
      //           height: size.height*0.3,
      //
      //
      //
      //
      //           child: Column(
      //             children: [
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: [
      //                   GestureDetector(
      //                     onTap: (){
      //                       Navigator.of(context).pop();
      //
      //
      //                     },
      //                       child: Icon(Icons.cancel_outlined)),
      //                 ],
      //               ),
      //               Container(
      //                 padding: EdgeInsets.all(10),
      //                 child: Center(
      //                     child: Image.asset('assets/images/profile.png')),
      //               ),
      //               Text('Upload a video')
      //             ],
      //           ),
      //         );
      //       },
      //     );
      //     /*setState(() {
      //       int _selectedIndex = 2;
      //
      //     });*/
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: pages[_selectedItemIndex],
    );

  }

  GestureDetector buildNavBarItem(Image image, Text text, int index) {
    return GestureDetector(
      onTap: () {
        _selectedItemIndex = index;
        // setState(() {
        //  // print("taped");
        //   Fluttertoast.showToast(msg: index.toString());
        //   _selectedItemIndex = index;
        // });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: MediaQuery.of(context).size.width / 5,

        height: 60,
        //  border:
        //     Border(bottom: BorderSide(width: 4, color: kSecondaryLightColor)),
        //     gradient: LinearGradient(colors: [
        //       kSecondaryLightColor.withOpacity(0.3),
        //       kSecondaryLightColor.withOpacity(0.016),
        //     ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
        //     : BoxDecoration( ),
        // color: Colors.white,
        child: Column(
          children: [

            IconButton(
              iconSize: 10,
              // padding: EdgeInsets.all(9.0),
              icon: image,
              color: index == _selectedItemIndex
                  ? Colors.grey
                  : Colors.black, onPressed: () {
                setState(() {
                  _selectedItemIndex = index;
                });

            },
            ),
            index == _selectedItemIndex?Icon(Icons.circle,size: 10,color: color,):Container(),
            // Text(
            //   ".",
            //   style: TextStyle(
            //     fontSize: 5,
            //     color: index == _selectedItemIndex
            //         ? Colors.red
            //         : Colors.grey[500],
            //   ),
            // )
          ],
        ),
      ),
    );
  }


}
