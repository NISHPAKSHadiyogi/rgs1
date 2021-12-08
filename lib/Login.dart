import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rgs/ForgotPassword.dart';
import 'package:rgs/Profilescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Api/ApiConfig.dart';
import 'BottomBar.dart';
import 'Home.dart';
import 'SignUp.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  // var id_fcm;
  // var id_device;
  // Login({this.id_fcm,this.id_device});
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();


  late bool loginstatus = false;

   bool passvis=false;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getPrefance();
  // }
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

        SingleChildScrollView(
          child: Form(
            key: formkey,
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

                        Container(

                          decoration: BoxDecoration(color:color,
                            // border: Border.all(color: Colors.blueAccent,borderRadius: 5),
                            borderRadius: BorderRadius.circular(25.0),
                          ),

                          width: width,
                          height: 300,

//                      clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: const EdgeInsets.all(2.0),
                          padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                          child: FittedBox(

                            fit: BoxFit.fitWidth,
                            child:Image(image: AssetImage('images/frame.png')),
                          ),

                        ),
                        SizedBox(height: 50),
                        Text("Log In",style:TextStyle(color: color,fontSize: 30,fontWeight: FontWeight.bold) ,),
                        SizedBox(height: 20),
                        Wrap(
                          spacing: 5.0, // gap between adjacent chips
                          runSpacing: 25.0,
                          children: <Widget>[


                            Container(
                              decoration: BoxDecoration(color:Colors.white,
                                border: Border.all(color: color,width: 0.5),

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
                                              child: Image(image:AssetImage('images/vector.png')),
                                            ),
                                          )
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        height: 50,
                                        width: width-100,
                                        child: new TextFormField(
                                          style: TextStyle(fontSize: 16,  color: Colors.black),
                                          controller: emailController,

                                          autofocus: false,
                                          decoration: const InputDecoration(
                                              //labelText: 'E-mail Id',

                                            //icon: Icon(Icons.person),
                                            hintText: 'Email',
                                              border: InputBorder.none,
                                              labelStyle: TextStyle(
                                                  color:   Colors.grey
                                              )


                                          ),
                                          validator: ((value) {
                                            if (value!.isEmpty) {
                                              return "Email  Required!!";
                                            }
                                            return null;
                                          }),
                                          // onSaved: (String? value) {
                                          //   // This optional block of code can be used to run
                                          //   // code when the user saves the form.
                                          // },
                                          // validator: (String? value) {
                                          //   return (value != null &&
                                          //       value.contains('@')) ? 'Do not use the @ char.' : null;
                                          // },
                                        ),
                                      ),

                                    ],
                                  )

                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(color:Colors.white,
                                border: Border.all(color: color,width: 0.5),

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
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 16,  color: Colors.black),
                                          obscureText: true,
                                          controller: passwordController,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            // icon: Icon(Icons.person),
                                           hintText: 'Password',


                                            //labelText: 'Password ',
                                            labelStyle: TextStyle(
                                                color:   Colors.grey
                                            )


                                          ),
                                          // onSaved: (String? value) {
                                          //   // This optional block of code can be used to run
                                          //   // code when the user saves the form.
                                          // },
                                          validator: ((value) {
                                            if (value!.isEmpty) {
                                              return "Password Required!!";
                                            }
                                            return null;
                                          }),
                                          // validator: (String? value) {
                                          //   return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                          // },
                                        ),
                                      ),

                                    ],
                                  )

                                ],
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 5,),

                        Container(
                            margin: const EdgeInsets.all(2.0),
                            alignment: Alignment.topLeft,

                            child:GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                              },
                              child: Text("Forgot Password",style: TextStyle(fontSize: 15,color: color),
                              ),
                            )),
                        SizedBox(height: 25,),


                        GestureDetector(
                          onTap: () async {


                            // var bottom =2;
                            // Timer(
                            //   Duration(seconds: 1),
                            //       () => Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => BottomBar(bottom: bottom,),
                            //     ),
                            //   ),
                            // );


                              var mail = emailController.text;
                              var pass = passwordController.text;

                              if(emailController.text.isEmpty){
                                Fluttertoast.showToast(msg: "Please Fill Email First",backgroundColor: Colors.red);

                              }else{
                                if(passwordController.text.isEmpty){
                                  Fluttertoast.showToast(msg: "Please Fill Password First",backgroundColor: Colors.red);
                                }else{
                                  var fcm = "widget.id_fcm";
                                  var device = "widget.id_device";
                                  LoginData(mail, pass,fcm,device);
                                }
                              }



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

                                          child: Text("Log In ",style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.w700),),
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
                                              child: Image(image:AssetImage('images/forward.png')),
                                            ),
                                            // Icon(Icons.keyboard_arrow_right),
                                          ),
                                          // onTap: () {
                                          //
                                          //   //  mapController.animateCamera(
                                          //   //  CameraUpdate.zoomIn(),
                                          // },
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
                        SizedBox(height: 25,),
                        Container(
                          margin: const EdgeInsets.all(2.0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Text("Don't have an account?",
                                style:TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w300) ,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Rgs()));
                                },
                                child: Text("Sign Up",
                                  style:TextStyle(color: color,fontSize: 15,fontWeight: FontWeight.bold) ,),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 0,),
                      ],

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Show the place input fields & button for
    ); // showing the route
  }

  // getPrefance() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     loginstatus = sharedPreferences.getBool('loggedIn')!;
  //     var index =0;
  //     Timer(
  //         Duration(seconds: 3),
  //             () => Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                 loginstatus == true ? BottomBar(bottom: index,) : Home()
  //               //logIN==true?BottomBar() :LoginScreen()
  //             )));
  //   });
  // }
  LoginData(String mail, String pass,String fcmid, String deviceid) async {
    String username = 'aytadmin';
    String password = '12345678';
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? userid = preferences.getString("userid");
    // String id= userid.toString();
    //  String id= "22";
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('loading...')));

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var login_url = ApiConfig().baseurl + ApiConfig().api_login;
     print("Employee login_url --->" + login_url);

    setState(() {
      loginstatus == true;
      //token="Bearer"+sharepref.getString("usertoken");
    });

    Map<String, String> headerss={

      ApiConfig().content_type:ApiConfig().content_type_value,
      ApiConfig().x_api_key:ApiConfig().x_api_key_value,
      'Content-Type': 'multipart/form-data'
      // ApiConfig().key_auth:token.toString(),
    };
    // var bodys = {
    //   "mobile_no": "mail",
    //   "password": "pass",
    //   "fcm_id": "fcm",
    //    "device_id": "deviceid",
    //
    //
    // };
    // print("bodys :"+bodys.toString());


    var request = http.MultipartRequest('POST', Uri.parse(login_url));
    request.fields['email'] = mail;
    request.fields['password'] = pass;
    request.fields['fcm_id'] = "widget.id_fcm";
    request.fields['device_id'] = "widget.id_device";
    //request.fields['address'] = "fhdf";
    //request.files.add(await http.MultipartFile.fromPath('profile_image[]', _image.path));
    request.headers.addAll(headerss);
    http.StreamedResponse response = await request.send();
    var responses = await http.Response.fromStream(response);
    print("Employee Update URL--->" + responses.body);
    var json = jsonDecode(responses.body);
    var status = json["status"];
    var msg = json["message"];
    print("Update Expenses----->" + responses.body);
    print("msg Expenses----->" + msg.toString());
    print("status Expenses----->" + status.toString());



    if (response.statusCode == 200) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      print(json["data"]['id']);
      setState(() {
        sharedPreferences.setBool("loggedIn", true);
        sharedPreferences.setString('LoginId', json["data"]['id']);
        loginstatus=false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BottomBar(bottom: 2);
            },
          ),
        );
      });
    /*  Fluttertoast.showToast(
          msg: json["data"]["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

     */
      // Navigator.pop(context, 'Success!');

    } else {
      //print(response.reasonPhrase);
      setState(() {
        loginstatus=false;
      });
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // Navigator.pop(context, 'Failed!');
    }





  }
}