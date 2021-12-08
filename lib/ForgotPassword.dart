import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rgs/Login.dart';
import 'package:rgs/OtpVerify.dart';
import 'package:shared_preferences/shared_preferences.dart';
String email="";
class ForgotPassword extends StatefulWidget {
  static TextEditingController Controlleruser = TextEditingController();
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController Controlleruser = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    bool hidepassword = true;
    const color = const Color(0xFF563B5A);

    return Container(
      height: height,
      width: width,

      child: Scaffold(


        backgroundColor: Colors.white,

        body:

        SingleChildScrollView(
          child: Stack(

            children: <Widget>[
              // Map View

              // Show zoom buttons
              SafeArea(
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
                            padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                            child: FittedBox(

                              fit: BoxFit.fitWidth,
                              child:Image(image: AssetImage('images/forgot-passsword 1.png')),
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



                      SizedBox(height: 50),
                      Text("Forgot Password",style:TextStyle(color: color,fontSize: 25,fontWeight: FontWeight.w700) ,),
                      SizedBox(height: 20),
                      Wrap(
                        spacing: 5.0, // gap between adjacent chips
                        runSpacing: 25.0,
                        children: <Widget>[


                          Container(
                            decoration: BoxDecoration(color:Colors.white,
                              border: Border.all(width: 0.5),

                              //borderRadius: BorderRadius.circular(25.0),
                            ),
                            width: width,
                            height: 45,
                            margin: const EdgeInsets.all(2.0),
                            padding: EdgeInsets.fromLTRB(10, 10, 5, 5),


                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    Container(
                                        width:32,
                                        height: 30,
                                        child: FittedBox(
                                          fit :BoxFit.fill,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Image(image:AssetImage('images/vector.png')),
                                          ),
                                        )
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      height: 50,
                                      width: width-100,
                                      child: TextField(
                                        controller: Controlleruser,
                                        style: TextStyle(fontSize: 16,  color: Colors.black,fontWeight: FontWeight.w400),
                                        decoration: const InputDecoration(
                                            //labelText: 'Enter your email Id',

                                            //icon: Icon(Icons.person),
                                             hintText: 'Enter your email Id ',
                                            border: InputBorder.none,
                                            labelStyle: TextStyle(
                                                color:   Colors.grey
                                            )


                                        ),

                                      ),
                                    ),

                                  ],
                                )

                              ],
                            ),
                          ),


                        ],
                      ),
                      SizedBox(height: 30,),
                      Container(
                          margin: const EdgeInsets.all(2.0),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child:Text("We Sent OTP on your registered Email ID",
                            style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.w400),)),
                      SizedBox(height: 50,),
                      GestureDetector(
                        onTap: (){
                          sentotp();


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



                                      child: FittedBox(
                                        fit :BoxFit.fill,

                                        child: Text("Send OTP ",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700),),
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
                                              onTap: (){
                                                sentotp();

                                              },
                                                child: Image(image:AssetImage('images/forward.png'))),
                                          ),
                                          // Icon(Icons.keyboard_arrow_right),
                                        ),
                                        onTap: () {

                                          //  mapController.animateCamera(
                                          //  CameraUpdate.zoomIn(),
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
            ],
          ),
        ),
      ),

      // Show the place input fields & button for
    ); // showing the route
  }
  Future<void> sentotp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var language_id = preferences.getString("language_id");
    var  search="";
    var  page= Controlleruser.text.toString();
       print(page);

    String requestUrl = "http://taxrgs.adiyogitechnology.com/api/password_forgot";
    //print("SliderUrl--> " + endpointUrl);
    //  Map<String, String> queryParameter = {
    //    routeKey: routeProductType,
    //  };
    // String queryString = Uri(queryParameters: queryParameter).query;
    // var requestUrl = url + '?' + queryString;
    // print("listEmployeeurl--> " + requestUrl);
    Map<String, String> headers = {
      'X-API-KEY': "AYTWEB@12345678",
      'authorization': 'Basic ' +
          base64Encode(utf8.encode('aytadmin:12345678')),

    };

    String body = jsonEncode({"email_id":page});

    var response = await http.post(Uri.parse(requestUrl),body:{"email_id":page },  headers: headers

    );

    print("object all" + response.body);

    var jasonDataOffer = jsonDecode(response.body);
    print("object all--" + response.statusCode.toString());
    if (response.statusCode == 200) {

      Fluttertoast.showToast(
          msg:jasonDataOffer["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Login()));
      //Fluttertoast(,jasonDataOffer["message"],)
      //return TypeModel.fromJson(jasonDataOffer);
    }
    else{
      Fluttertoast.showToast(
          msg:jasonDataOffer["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    return jasonDataOffer;

  }
}