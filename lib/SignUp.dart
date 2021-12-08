import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rgs/Login.dart';

import 'Api/ApiConfig.dart';
import 'package:http/http.dart' as http;


class Rgs extends StatefulWidget {
  static TextEditingController Controlleruser = TextEditingController();
  @override
  _RgsState createState() => _RgsState();
}

class _RgsState extends State<Rgs> {
  var fname;
  var did;
  var fd;

  bool signupstatus = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController cnfpassController = TextEditingController();

  SignUpData(String name, String lname,String phone, String mail, String pass) async {
    String username = 'aytadmin';
    String password = '1234568';
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? userid = preferences.getString("userid");
    // String id= userid.toString();
    //  String id= "22";
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('loading...')));

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var signup_url = ApiConfig().baseurl + ApiConfig().api_register;
    print("Employee Update URL--->" + signup_url);

    setState(() {
      signupstatus == true;
      //token="Bearer"+sharepref.getString("usertoken");
    });
    print("signup_url : "+signup_url.toString());
    var headerss={

      ApiConfig().content_type:ApiConfig().content_type_value,
      ApiConfig().x_api_key:ApiConfig().x_api_key_value,
      // ApiConfig().key_auth:token.toString(),
    };
    var bodys = {
      "firstname": name,
      "lastname": "bhh",
      "email_id":  mail,
      "mobile_no": phone,
      "password": pass,



    };
    print("bodys :"+bodys.toString());


    var signup_url_response= await http.post(Uri.parse(signup_url),body:bodys,headers:headerss );

    var jsonDecoded=jsonDecode(signup_url_response.body);
    print("signup_response : "+signup_url_response.body);
    var msg =jsonDecoded['message'];
    var success =jsonDecoded['status'];
    print("msg Expenses----->" + msg.toString());
    print("status Expenses----->" + success.toString());

    try{
      if(success==true){
        setState(() {
          signupstatus=false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Login();
              },
            ),
          );
        });
        // var signupdata = jsonDecoded['data'];
        // fname = jsonDecoded['data']['firstname'];
        // did = jsonDecoded['data']['device_id'];
        // fd = jsonDecoded['data']['fcm_id'];
        //
        //  print("fname : "+fname.toString());
        //  print("did : "+did.toString());
        //  print("fd : "+fd.toString());
        //
        // print("signupdata : "+signupdata.toString());




        Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }else{
        setState(() {
          signupstatus=false;
        });
        Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }catch(e){
      print(e);
    }





  }

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

            child: Form(
              key: formkey,
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
                        height: height/3,

//                      clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: const EdgeInsets.all(2.0),
                        padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                            child: FittedBox(

                              fit: BoxFit.fitWidth,
                              child:Image(image: AssetImage('images/frame.png')),
                            ),

                      ),
                      SizedBox(height: 50),
                      Text("Sign Up",
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
                          children: <Widget>[
                            Row(
                              children: [

                               Container(
                                   width:30,
                                   height: 30,
                                   child: FittedBox(
                                fit :BoxFit.fill,
                                 child: Padding(
                                   padding: const EdgeInsets.all(4.0),
                                   child: Image(image:AssetImage('images/vector2.png')),
                                 ),
                                )
                               ),
                               Container(
                                 margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                 height: 50,
                                 width: width-100,
                                 child: TextFormField(

                                   style: TextStyle(fontSize: 16,  color: Colors.black),
                                  controller: firstNameController,
                                  decoration: const InputDecoration(
                                 //   hintStyle: TextStyle(color: Colors.red),
                                    //icon: Icon(Icons.person),
                                   hintText: 'Name',
                                    //labelText: 'Name ',
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color:  Colors.grey,fontSize: 18
                                      )



                                  ),
                                  // onSaved: (String? value) {
                                  //   // This optional block of code can be used to run
                                  //   // code when the user saves the form.
                                  // },
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
                                        child: Image(image:AssetImage('images/vector.png')),
                                      ),
                                    )
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  height: 50,
                                  width: width-100,
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 16,  color: Colors.black,),
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      //icon: Icon(Icons.person),
                                      hintText: 'Email ',
                                      //labelText: 'E-mail ',
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(
                                            color:   Colors.grey,fontSize: 18
                                        )


                                    ),
                                    // onSaved: (String? value) {
                                    //   // This optional block of code can be used to run
                                    //   // code when the user saves the form.
                                    // },
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
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 16,  color: Colors.black),
                                    obscureText: true,
                                    controller: passwordController,
                                    decoration: const InputDecoration(
                                      //icon: Icon(Icons.person),
                                      hintText: 'Password',
                                      //labelText: 'Password ',
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(
                                            color:   Colors.grey,fontSize: 18
                                        )


                                    ),
                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.
                                    },
                                    validator: (String? value) {
                                      return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
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
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 16,  color: Colors.black),
                                    obscureText: true,
                                    controller: cnfpassController,
                                    decoration: const InputDecoration(

                                      //icon: Icon(Icons.person),
                                      hintText: 'Confirm Password',
                                      //labelText: 'Confirm Password ',
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(
                                            color:   Colors.grey,fontSize: 18
                                        )

                                    ),
                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.
                                    },
                                    validator: (String? value) {
                                      return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
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
                          if (formkey.currentState!.validate()) {
                            var urname = firstNameController.text;
                            var pass = passwordController.text;
                            var eml = emailController.text;
                            var mob = cnfpassController.text;
                            var cnf = "ggy";
                            SignUpData(urname, cnf, pass, eml, mob);
                          };
                        },
                          // Navigator.pushReplacement(
                          //
                          //   context,
                          //   MaterialPageRoute(builder: (context) =>  Login()),
                          // );



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

                                        child: Text("Sign Up",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w700),),
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
                                                  if (formkey.currentState!.validate()) {
                                                    var urname = firstNameController.text;
                                                    var pass = passwordController.text;
                                                    var eml = emailController.text;
                                                    var mob = cnfpassController.text;
                                                    var cnf = "ggy";
                                                    SignUpData(urname, cnf, pass, eml, mob);
                                                  };
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?",
                                style:TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w300) ,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                },
                                child: Text("Sign In",
                                  style:TextStyle(color: color,fontSize: 15,fontWeight: FontWeight.bold) ,),
                              ),
                            ],
                          ),
                          SizedBox(height: 0,),




                      ],
                      ),

                    ],

                  ),
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
