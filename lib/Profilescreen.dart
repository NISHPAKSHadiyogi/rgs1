
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Api/ApiConfig.dart';
import 'Login.dart';
import 'UserProfile.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late File _image=File("images/user.png");
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  static TextEditingController nameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static const color = const Color(0xFF563B5A);

  bool profilestatus = false;

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

  Future UpdateProfileData(String name, String lname, String mobile,
      String email, String id, String address) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var loginid01 = sharedPreferences.getString('LoginId');
    setState(() {
      profilestatus = true;
      // token="Bearer"+preferences.getString("usertoken");
    });
    var url = ApiConfig().baseurl + ApiConfig().api_update_profile;
    print("Employee Update URL--->" + url);
    //print("Employee ID--->" + widget.employeeID);
    Map<String, String> headerss = {

      ApiConfig().content_type: ApiConfig().content_type_value,
      ApiConfig().x_api_key: ApiConfig().x_api_key_value,
      'Content-Type': 'multipart/form-data'
      // ApiConfig().key_auth:token.toString(),
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['user_id'] = loginid01.toString();
    request.fields['firstname'] = name;
    request.fields['lastname'] = "Sharan";
    request.fields['email_id'] = email;
    request.fields['mobile_no'] = mobile;
    request.fields['address'] = "sdfsdfsdf";
    //request.fields['address'] = "fhdf";
     request.files.add(
        await http.MultipartFile.fromPath('image', _image.path));
    request.headers.addAll(headerss);
    http.StreamedResponse response = await request.send();
    var responses = await http.Response.fromStream(response);
    print("Employee Update URL--->" + responses.body);
    var json = jsonDecode(responses.body);
    var status = json["status"];
    var msg = json["message"];
    print("Update Expenses----->" + responses.body);
    print("msg Expenses----->" + msg.toString());
    print("msg Expenses----->" + status.toString());
    // final respStr = await response.stream.bytesToString();
    // print("Update Expenses ----> " + respStr);
    if (response.statusCode == 200) {
      setState(() {
        profilestatus = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return UserProfileData(id: "2",user_email: name,user_contact: mobile,);
            },
          ),
        );
      });
      Fluttertoast.showToast(
          msg: "Expenses Updated Successfully!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context, 'Success!');
    } else {
      //print(response.reasonPhrase);
      setState(() {
        profilestatus = false;
      });
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context, 'Failed!');
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
      Size size = MediaQuery
          .of(context)
          .size;
      return Scaffold(

        body: SingleChildScrollView(
          child: Form(
            key: formkey,
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
                            width: size.width * 0.999,
                            decoration: BoxDecoration(color: color,
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
                            width: size.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    child: Icon(

                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "User profile",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    SharedPreferences preference = await SharedPreferences
                                        .getInstance();
                                    await preference.clear();
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                    //code to execute when this button is pressed
                                  },
                                  child: Container(
                                      height: 25,
                                      child: Image.asset(
                                          'images/Logout 1@2x.png')
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
                                          borderRadius: BorderRadius.circular(
                                              50.0),
                                        /*image: new DecorationImage(
                                            image: AssetImage(
                                                _image.path),
                                            fit: BoxFit.fill,
                                          ),
                                         */
                                        ),
                                    child:_image=="images/user.png"?Image.asset(_image.path):Image.file(_image),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 60.0, left: 130.0),
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        GestureDetector(
                                          child: new CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 16.0,
                                            child: new Image.asset(
                                              'images/camera.png', scale: 2,
                                            ),
                                          ),
                                          onTap: () {
                                            getimage();
                                            //selectProfileimage();
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
                  style: TextStyle(color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),),
                SizedBox(height: 40,),


                Container(
                  decoration: BoxDecoration(color: Colors.white,
                    border: Border.all(color: color, width: 0.5),

                    //borderRadius: BorderRadius.circular(25.0),
                  ),
                  width: size.width * 0.9,
                  height: 45,
                  margin: const EdgeInsets.all(2.0),
                  padding: EdgeInsets.fromLTRB(10, 10, 5, 5),


                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Container(
                              width: 30,
                              height: 30,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Image(
                                      image: AssetImage('images/user.png')),
                                ),
                              )
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            height: 50,
                            width: size.width * 0.5,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black),
                              controller: nameController,
                              decoration: const InputDecoration(
                                //labelText: 'E-mail Id',

                                //icon: Icon(Icons.person),
                                  hintText: 'hello@rgsaccount.co.uk',
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                      color: Colors.grey
                                  )


                              ),
                              onSaved: (String? value) {
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                              validator: (String? value) {
                                return (value != null && value.contains('@'))
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ),
                          ),

                        ],
                      )

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(color: Colors.white,
                    border: Border.all(color: color, width: 0.5),

                    //borderRadius: BorderRadius.circular(25.0),
                  ),
                  width: size.width * 0.9,
                  height: 45,
                  margin: const EdgeInsets.all(2.0),
                  padding: EdgeInsets.fromLTRB(10, 10, 5, 5),


                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Container(
                              width: 30,
                              height: 30,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Image(image: AssetImage(
                                      'images/contactmail.png')),
                                ),
                              )
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            height: 50,
                            width: size.width * 0.5,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black),
                              controller: emailController,
                              decoration: const InputDecoration(
                                //labelText: 'E-mail Id',

                                //icon: Icon(Icons.person),
                                  hintText: 'hello@rgsaccount.co.uk',
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                      color: Colors.grey
                                  )


                              ),
                              onSaved: (String? value) {
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                              validator: (String? value) {
                                return (value != null && value.contains('@'))
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ),
                          ),

                        ],
                      )

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(color: Colors.white,
                    border: Border.all(color: color, width: 0.5),

                    //borderRadius: BorderRadius.circular(25.0),
                  ),
                  width: size.width * 0.9,
                  height: 45,
                  margin: const EdgeInsets.all(2.0),
                  padding: EdgeInsets.fromLTRB(10, 10, 5, 5),


                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Container(
                              width: 30,
                              height: 30,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Image(image: AssetImage(
                                      'images/contactcall.png')),
                                ),
                              )
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            height: 50,
                            width: size.width * 0.5,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black),
                              controller: phoneController,
                              decoration: const InputDecoration(
                                //labelText: 'E-mail Id',

                                //icon: Icon(Icons.person),
                                  hintText: '+44 7462532147',
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                      color: Colors.grey
                                  )


                              ),
                              onSaved: (String? value) {
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                              validator: (String? value) {
                                return (value != null && value.contains('@'))
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ),
                          ),

                        ],
                      )

                    ],
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 19, horizontal: 20),
                      color: color,
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          var urname = nameController.text;
                          var emailid = emailController.text;
                          var mobile = phoneController.text;
                          var id = "id";
                          var ln = "Sharan";
                          var add = "sdfsdfsdf";
                          UpdateProfileData(
                              urname, emailid, mobile, id, ln, add);
                        }
                        // Navigator.push(
                        //
                        //   context,
                        //   MaterialPageRoute(builder: (context) =>  UserProfileData()),
                        // );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " Update ",
                            style:
                            TextStyle(color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      );
    }
  }

