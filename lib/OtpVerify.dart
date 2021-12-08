import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';

 //ignore: import_of_legacy_library_into_null_safe

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rgs/Home.dart';
import 'package:rgs/Login.dart';
class OtpVerify extends StatefulWidget {
  static TextEditingController Controlleruser = TextEditingController();
  @override
  _OtpVerifyState createState() => _OtpVerifyState();

}

class _OtpVerifyState extends State<OtpVerify> {



  String currentText = "";
  TextEditingController textEditingController = TextEditingController();
  CountDownController _controller = CountDownController();

  bool timerstatus=false;
  @override

  Widget build(BuildContext context) {
//startTimer();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // TextEditingController Controlleruser = TextEditingController();
    bool hidepassword = true;
    const color = const Color(0xFF563B5A);
    const color2 = const Color(0x6BD5D0D5);



    return Container(
      height: height,
      width: width,

      child: Scaffold(


        backgroundColor: Colors.white,

        body:

        Stack(

          children: <Widget>[
            // Map View

            // Show zoom buttons
            SafeArea(
        child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 20.0,right: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(

                          decoration: BoxDecoration(color:color,
                            // border: Border.all(color: Colors.blueAccent,borderRadius: 5),
                            borderRadius: BorderRadius.circular(25.0),
                          ),

                          width: width,
                          height: 300,

//                      clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: const EdgeInsets.all(2.0),
                          padding: EdgeInsets.fromLTRB(15, 70, 15, 20),
                          child: FittedBox(

                            fit: BoxFit.fitWidth,
                            child:Image(image: AssetImage('images/otp.png')),
                          ),

                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: Icon(Icons.arrow_back,size: 40,color: Colors.white,),),
                        ),

                      ],
                    ),


                    SizedBox(height: 30),
                    Text("OTP",style:TextStyle(color: color,fontSize: 25,fontWeight: FontWeight.bold) ,),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(right: 5,left: 5),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 3) {
                            return "Please enter correct otp";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            inactiveFillColor: Colors.pink.shade50,
                            borderRadius: BorderRadius.circular(1),
                            fieldHeight: 60,
                            fieldWidth: 60,
                            activeFillColor: Colors.pink.shade50,
                            activeColor: color,
                            selectedColor: Colors.black12,
                            borderWidth: 1,
                            inactiveColor: Colors.black12),
                        cursorColor: Colors.black12,
                        animationDuration: Duration(milliseconds: 300),
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                    ),


                    SizedBox(height: 0,
                    ),
                    Container(

                        margin: const EdgeInsets.all(2.0),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                timerstatus==false? CircularCountDownTimer(

                                  width: MediaQuery.of(context).size.width / 8,
                                  height: MediaQuery.of(context).size.height / 20,

                                  duration:120,

                                  fillColor: Colors.white,
                                  color: Colors.white30,
                                  controller: _controller,
                                  // backgroundColor: Colors.white54,
                                  // strokeWidth: 10.0,
                                  // strokeCap: StrokeCap.round,
                                  isTimerTextShown: true,
                                  isReverse: true,


                                  onComplete: () async {

                                      setState(() {
                                        timerstatus=true;
                                      });

                                  },
                                  textStyle: TextStyle(fontSize: 14.0,color: Colors.grey),
                                ):Container(),
                                InkWell(
                                    onTap: () {},child: timerstatus==false?
                                Text("Sec",
                                  style: TextStyle(fontSize: 16,color: Colors.grey,),):Container()),
                              ],
                            ),


                           //SizedBox(width: 200,),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerify()));
                          },child: timerstatus==true?
                        Text("Resend",
                          style: TextStyle(fontSize: 18,color: Colors.grey,fontWeight: FontWeight.bold),):Container()), ],)
        ),
                    SizedBox(height: 15,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(

                          context,
                          MaterialPageRoute(builder: (context) =>  Login()),
                        );

                      },
                      child: Container(
                        decoration: BoxDecoration(color:color,
                          border: Border.all(color: color,width: 0.5),

                          borderRadius: BorderRadius.circular(5.0),
                        ),

                        width: width,
                        height: 45,
                        margin: const EdgeInsets.all(2.0),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,

                              children: [
                                Container(
                                    margin: const EdgeInsets.all(10.0),
                                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),


                                    child: FittedBox(
                                      fit :BoxFit.fill,

                                      child: Text("Submit",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w700),),
                                    )
                                ),
                                Expanded(child: SizedBox( )),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  clipBehavior: Clip.hardEdge,

                                  child: Material(
                                    color: Colors.white, // button color
                                    child: InkWell(
                                      splashColor: Colors.blue, // inkwell color
                                      child: SizedBox(
                                        width: 50,
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: GestureDetector(
                                              child: Image(image:AssetImage('images/forward.png'))),
                                        ),
                                        // Icon(Icons.keyboard_arrow_right),
                                      ),
                                      onTap: (){
                                        Navigator.push(

                                          context,
                                          MaterialPageRoute(builder: (context) =>  Login()),
                                        );

                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width:5),
                              ],
                            ),


                          ],
                        ),
                      ),
                    ),
                  ],

                ),
              ),
            ),
            ),
          ],
        ),

      ),

      // Show the place input fields & button for
    ); // showing the route
  }
}