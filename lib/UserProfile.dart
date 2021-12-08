
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rgs/Login.dart';
import 'package:rgs/Profilescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Api/ApiConfig.dart';
import 'changepassword.dart';
import 'package:http/http.dart' as http;

class UserProfileData extends StatefulWidget {
  var id;
  var user_email;
  var user_contact;

   UserProfileData({this.id,this.user_contact,this.user_email});

  @override
  _UserProfileDataState createState() => _UserProfileDataState();
}

class _UserProfileDataState extends State<UserProfileData> {
   late File _image;
  static const color = const Color(0xFF563B5A);
  bool profileupdatedstatus = false;

  var email;
  var mobile;
  var firname;
  var lastname;
  var loginid;
  var baseUrl = "http://taxrgs.adiyogitechnology.com/api/employee";
   void initState() {
     super.initState();
     getPrefance();
     // getProfileData();
   }


   getPrefance() async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var loginid01 = sharedPreferences.getString('LoginId');
     setState(() {
       loginid = loginid01;
     });
     getProfileData(loginid);
   }
   Future<void> getProfileData(loginid) async {
     print("login id from shared = $loginid");
     Map<String,String> headers = {
       'X-API-KEY': 'AYTWEB@12345678',
       'Authorization': 'Basic YXl0YWRtaW46MTIzNDU2Nzg=',
       'Cookie': 'csrf_cookie_name=c1234863c551125d082cd908e3cbf098; session=lc9l8b69peaicqb8g3idt82dq24ce1c6'
     };
     String url = baseUrl + '/'+ loginid.toString();
     var requestUrl = url;
     var response =
     await http.get(Uri.parse(requestUrl), headers: headers);

     print("Response --> " + response.body);

     Map<String, dynamic> map = json.decode(response.body);
     var data = map["data"];
     // print("Json --> " + data['email']);
     if (response.statusCode == 200) {
      print("Sucess --> "+ data["email"]);
      String email01= data["email"];
      String mob01= data["mobile_no"];
      String first= data["firstname"];
      String last= data["lastname"];
      setState(() {
        email = email01;
        mobile = mob01;
        firname = first;
        lastname = last;
      });
     }else{
       print("faild");
     }
   }



  Future getimage() async {
    final imagepicker = await ImagePicker.pickImage(
      source: ImageSource.camera,);

    if (imagepicker != null) {
      setState(() {
        _image = imagepicker;
        print("uploadCheckin_OUT_image--->> " + _image.path);
      });
    } else {
      Fluttertoast.showToast(
          msg: "Please Click Image First !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              //color: color,
              height: 270,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                      top: 0,
                      child: Container(
                        width: size.width*0.999,
                        decoration: BoxDecoration(color:color,
                          borderRadius: BorderRadius.only(

                            // topRight: Radius.circular(40.0),
                              bottomRight: Radius.circular(25.0),
                              //topLeft: Radius.circular(40.0),
                              bottomLeft: Radius.circular(25.0)),
                        ),
                        height: 200,
                      )),
                  Positioned(
                      top: 50,
                      child: Container(
                        width: size.width*0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.max,
                          children: [


                            Container(
                              child: Icon(

                                Icons.arrow_back,
                                color: color,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "User profile",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18,fontWeight: FontWeight.w700),
                              ),
                            ),


                            GestureDetector(
                              onTap: ()async{
                                SharedPreferences preference = await SharedPreferences.getInstance() ;
                                await preference.clear();
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                                //code to execute when this button is pressed
                              },
                              child: Container(
                                height: 25,
                                child: Image.asset('images/Logout 1@2x.png')
                              ),
                            )
                          ],
                        ),
                      )),
                  Positioned(
                    top: 135,
                    width: size.width * 0.55,

                    child: new Column(
                      children: <Widget>[
                        new Stack(fit: StackFit.loose, children: <Widget>[
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                width: 120.0,
                                height: 120.0,
                                decoration: BoxDecoration(
                                  // color: BackColorCard,
                                  color: Colors.white.withOpacity(.5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(.1),
                                        blurRadius: 4,
                                        spreadRadius: 3)
                                  ],
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.grey.withOpacity(.5),
                                  ),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                padding: EdgeInsets.all(5),
                                child: Container(
                                    width: 105.0,
                                    height: 105.0,
                                    decoration: new BoxDecoration(
                                      // shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade200
                                                .withOpacity(.1),
                                            blurRadius: 2,
                                            spreadRadius: 1)
                                      ],
                                      border: Border.all(
                                        width: 1.5,
                                        color: Colors.grey.withOpacity(.5),
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                      image: new DecorationImage(
                                        image: AssetImage(
                                            "images/user.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 60.0, left: 130.0),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  // color: BackColorCard,
                                  color: Colors.amber.withOpacity(.5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white
                                            .withOpacity(.1),
                                        blurRadius: 4,
                                        spreadRadius: 3)
                                  ],
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.white.withOpacity(.5),
                                  ),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: new CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 16.0,
                                        child: new Image.asset('images/camera.png',scale: 2,
                                        ),
                                      ),
                                      onTap: () {
                                      //  getimage();
                                      },
                                    )
                                  ],
                                ),
                              )),
                        ])
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text('$firname $lastname',
              style: TextStyle(color: color,fontWeight: FontWeight.w700,fontSize: 18),),
            SizedBox(height: 40,),
            Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      children: [
                       Image.asset('images/contactmail.png',height: 25,),
                        SizedBox(width: 15,),

                        Text('$email',style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Image.asset('images/contactcall.png',height: 25,),
                        SizedBox(width: 15,),

                        Text('$mobile',style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ),




            SizedBox(height: 40,),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        color: color,
                        onPressed: () {
                          // if (formkey.currentState.validate()) {
                          //   var urname = usernameController.text;
                          //   var pass = passController.text;
                          //   SendLoginData(urname, pass);
                          // }
                          Navigator.push(

                            context,
                            MaterialPageRoute(builder: (context) =>  ProfileScreen()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " Edit Profile ",
                              style:
                              TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.w700),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.45,

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        color: color,
                        onPressed: () {
                          // if (formkey.currentState.validate()) {
                          //   var urname = usernameController.text;
                          //   var pass = passController.text;
                          //   SendLoginData(urname, pass);
                          // }
                          Navigator.push(

                            context,
                            MaterialPageRoute(builder: (context) =>  ChangePasswordPage()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " Change Password ",
                              style:
                              TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.w700),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),





          ],
        ),
      ),
    );
  }
}
