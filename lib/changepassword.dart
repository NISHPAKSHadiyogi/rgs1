
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'BottomBar.dart';
import 'Login.dart';
 TextEditingController Controlleruserold = TextEditingController();
 TextEditingController Controllerusernew = TextEditingController();
 TextEditingController Controlleruserconfirm = TextEditingController();
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // TextEditingController Controlleruser = TextEditingController();
    bool hidepassword = true;
    const color = const Color(0xFF563B5A);
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
                      Text("Change Password",
                        style:TextStyle(color: color,fontSize: 28,fontWeight: FontWeight.bold) ,),
                      SizedBox(height: 20),
                      Wrap(
                        spacing: 15.0, // gap between adjacent chips
                        runSpacing: 15.0,
                        children: <Widget>[


                          Container(
                            decoration: BoxDecoration(color:Colors.white,
                              border: Border.all(color: color,width: 1),

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
                                        width:30,
                                        height: 30,
                                        child: FittedBox(
                                          fit :BoxFit.fill,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Image(image:AssetImage('images/vector2x.png')),
                                          ),
                                        )
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      height: 50,
                                      width: width-100,
                                      child: TextField(
                                        style: TextStyle(fontSize: 16,  color: Colors.black,
                                        ),
                                        controller: Controlleruserold,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          //icon: Icon(Icons.person),
                                            hintText: 'Old Password ',
                                            //labelText: 'E-mail ',
                                            border: InputBorder.none,
                                            labelStyle: TextStyle(
                                                color:   Colors.grey,fontSize: 18
                                            )


                                        ),

                                      ),
                                    ),

                                  ],
                                )

                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(color:Colors.white,
                              border: Border.all(color: color,width: 1),

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
                                        width:30,
                                        height: 30,
                                        child: FittedBox(
                                          fit :BoxFit.fill,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Image(image:AssetImage('images/vector2x.png')),
                                          ),
                                        )
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      height: 50,
                                      width: width-100,
                                      child: TextField(
                                        style: TextStyle(fontSize: 16,  color: Colors.black),
                                        controller: Controllerusernew,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          //icon: Icon(Icons.person),
                                            hintText: 'New Password',
                                            //labelText: 'Password ',
                                            border: InputBorder.none,
                                            labelStyle: TextStyle(
                                                color:   Colors.grey,fontSize: 18
                                            )


                                        ),

                                      ),
                                    ),

                                  ],
                                )

                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(color:Colors.white,
                              border: Border.all(color: color,width: 1),

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
                                        width:30,
                                        height: 30,
                                        child: FittedBox(
                                          fit :BoxFit.fill,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Image(image:AssetImage('images/vector2x.png')),
                                          ),
                                        )
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      height: 50,
                                      width: width-100,
                                      child: TextField(
                                        style: TextStyle(fontSize: 16,  color: Colors.black),
                                        controller: Controlleruserconfirm,
                                        obscureText: true,
                                        decoration: const InputDecoration(

                                          //icon: Icon(Icons.person),
                                            hintText: 'Confirm Password',
                                            //labelText: 'Confirm Password ',
                                            border: InputBorder.none,
                                            labelStyle: TextStyle(
                                                color:   Colors.grey,fontSize: 18
                                            )

                                        ),

                                      ),
                                    ),

                                  ],
                                )

                              ],
                            ),
                          ),
                          SizedBox(height: 0,),

                          GestureDetector(
                            onTap: (){
                              sentotp();

                            },
                            child: Container(
                              decoration: BoxDecoration(color:color,
                                border: Border.all(color: color,width: 1),

                                //borderRadius: BorderRadius.circular(25.0),
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
                                          color: color,

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
                          SizedBox(height: 0,),





                        ],
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
    );
  }
  Future<void> sentotp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString("LoginId");
    var  search="";
    var  page= Controlleruserold.text ;
    var  page1= Controllerusernew.text ;
    var  page2= Controlleruserconfirm.text ;

    String requestUrl = "https://technolite.in/staging/taxrjs/api/change_password";
    //print("SliderUrl--> " + endpointUrl);
    //  Map<String, String> queryParameter = {
    //    routeKey: routeProductType,
    //  };
    // String queryString = Uri(queryParameters: queryParameter).query;
    // var requestUrl = url + '?' + queryString;
    // print("listEmployeeurl--> " + requestUrl);
    Map<String, String> headers = {

      'X-API-KEY': "AYTWEB@12345678",
      'Authorization': 'Basic YXl0YWRtaW46MTIzNDU2Nzg=',
      'Cookie': 'session=6n02d43hlaik0m87u07cku9fmjn30vfb'
    };

    String body = jsonEncode({"email_id":"page" });

    var response = await http.post(Uri.parse(requestUrl),  body:{
      'id': id,
      'old_password': page,
      'new_password': page1,
      'confrim_password': page2
    },headers: headers
    );

    print("object all" + response.body);

    var jasonDataOffer = jsonDecode(response.body);
    print("object all###" + jasonDataOffer["message"].toString());
    if (response.statusCode == 200) {
      var jasonDataOffer = jsonDecode(response.body);
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar(bottom: 2)));

      Fluttertoast.showToast(
          msg:jasonDataOffer["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    //  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Login()),);

      //Fluttertoast(,jasonDataOffer["message"],)
      //return TypeModel.fromJson(jasonDataOffer);
    }
    else{
      Fluttertoast.showToast(
          msg:jasonDataOffer["message"].toString(),
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
