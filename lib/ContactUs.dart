
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Login.dart';

class ContactusScreen extends StatefulWidget {
  const ContactusScreen({Key? key}) : super(key: key);

  @override
  _ContactusScreenState createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {
  var  _url = 'https://pub.dev/packages/url_launcher';
  var email,phone,address;


  Future<void> getContactData() async {
    var requestUrl = "http://taxrgs.adiyogitechnology.com/api/setting";
    Map<String,String> headers = {
      'X-API-KEY': 'AYTWEB@12345678',
      'Authorization': 'Basic YXl0YWRtaW46MTIzNDU2Nzg=',
      'Cookie': 'csrf_cookie_name=f206142d612588f91e26deb978173699; session=aer5kk87pnhj0lvihv7be4bif4dnqis7'
    };

    var response =
    await http.get(Uri.parse(requestUrl), headers: headers);
    print("Setting api" + response.body);
    var jsonData = jsonDecode(response.body);


    if (response.statusCode == 200) {
      if (jsonData['status'] == true) {
       print("Get About data");
       String getEmail = jsonData['data']['email'];
       String getMob = jsonData['data']['phone'];
       String getAddress = jsonData['data']['address'];
        setState(() {
          email = getEmail;
          phone = getMob;
          address = getAddress;
        });
      } else {
        Fluttertoast.showToast(
            msg: jsonData["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

      }
    }
  }

  @override
  void initState() {
    super.initState();
    getContactData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // TextEditingController Controlleruser = TextEditingController();
    bool hidepassword = true;
    const color = const Color(0xFF563B5A);
    const color2 = const Color(0xFF162037);


    // startTimer();
    return Container(
      height: height,
      width: width,

      child: Scaffold(


        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: color,
          title: Text("Contact Us ",style:TextStyle(color: Colors.white,fontSize: 24) ,),
          centerTitle: true,
          actions: [
            IconButton(
                icon: ImageIcon(
                  AssetImage('images/Logout 1@2x.png'),
                ),
                onPressed: () async{
                  SharedPreferences preference = await SharedPreferences.getInstance() ;
                  await preference.clear();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                  //code to execute when this button is pressed
                }
            ),
          ],
        ),
        body: Stack(

            children: <Widget>[
              // Map View

              // Show zoom buttons
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,top: 20.0,right: 10.0),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //   Text("| Income Tax                ",style:TextStyle(color: color,fontSize: 32,fontWeight: FontWeight.bold) ,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image( height: 200,width:320,image: AssetImage('images/contactus.png'),),
                          ],
                        ),
                        SizedBox(height: 20,),

                        Container(

                          child: Card(

                         shadowColor: color,
                          elevation: 2,
                           child:
                           Container(
                             padding: EdgeInsets.only(right: 7),
                             color: color,
                             child: GestureDetector(
                               onTap: (){
                                 _launchEmail();

                               },
                               child: Container(
                                 padding: EdgeInsets.only(left: 2),
                                 color: Colors.white,
                                 child:  Row(
                                   children: [
                                     Container(
                                       decoration: BoxDecoration(color:color,
                                         border: Border.all(width: 1.1),


                                         borderRadius: BorderRadius.circular(5.0),
                                       ),
                                       width: width/5,
                                       height: height/10,
                                       margin: const EdgeInsets.all(2.0),
                                       padding: EdgeInsets.all(13),


                                       child: Image(image: AssetImage('images/loginmail.png'),),
                                     ),
                                     SizedBox(width: 5,),
                                     Container(
                                       width: size.width*0.5,
                                       child: Text('$email',
                                         style: TextStyle(color: Colors.grey,fontSize: 14),),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           )
                       )
        ),
                        SizedBox(height: 20,),
                        Container(

                            child: Card(

                                shadowColor: color,
                                elevation: 2,
                                child:
                                Container(
                                  padding: EdgeInsets.only(right: 7),
                                  color: color,
                                  child: GestureDetector(
                                    onTap: (){
                                      _launchDialer();

                                    },

                                    child: Container(
                                      padding: EdgeInsets.only(left: 2),
                                      color: Colors.white,
                                      child:  Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(color:color,
                                              border: Border.all(width: 1.1),


                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            width: width/5,
                                            height: height/10,
                                            margin: const EdgeInsets.all(2.0),
                                            padding: EdgeInsets.all(13),


                                            child: Image(image: AssetImage('images/phone.png'),),
                                          ),
                                          SizedBox(width: 5,),
                                          Container(

                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Container(
                                                //   width: size.width*0.65,
                                                //   child: Text('Swesna +44 1639 4910 170 ',
                                                //     style: TextStyle(color: Colors.grey,fontSize: 14),),
                                                // ),
                                                // SizedBox(height: 5,),
                                                Container(
                                                  width: size.width*0.65,
                                                  child: Text('Mobile $phone',
                                                    style: TextStyle(color: Colors.grey,fontSize: 14),),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )







                            )
                        ),
                        SizedBox(height: 20,),
                        Container(

                            child: Card(

                                shadowColor: color,
                                elevation: 2,
                                child:
                                Container(
                                  padding: EdgeInsets.only(right: 7),
                                  color: color,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 2),
                                    color: Colors.white,
                                    child:  Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(color:color,
                                            border: Border.all(width: 1.1),


                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          width: width/5,
                                          height: height/10,
                                          margin: const EdgeInsets.all(2.0),
                                          padding: EdgeInsets.all(13),


                                          child: Image(image: AssetImage('images/12168951@2x.png'),),
                                        ),
                                        SizedBox(width: 5,),
                                        Container(
                                          width: size.width*0.65,
                                          child: Text('$address',
                                            style: TextStyle(color: Colors.grey,fontSize: 14),),
                                        ),
                                      ],
                                    ),
                                  ),
                                )







                            )
                        ),


                      ],

                    ),
                  ),
                ),
              ),
            ]
        ),
        //bottomNavigationBar: bottomNavigationBar,
      ),

      // Show the place input fields & button for
    );
  }
  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  _launchEmail() async {
    launch(
        "mailto:?subject= &body=");
  }
  _launchDialer() async {
    launch(
        "tel:<phone number>");
  }

}
