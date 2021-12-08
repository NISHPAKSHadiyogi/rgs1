
import 'dart:convert';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Api/ApiConfig.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;

class AboutusScreen extends StatefulWidget {
  const AboutusScreen({Key? key}) : super(key: key);

  @override
  _AboutusScreenState createState() => _AboutusScreenState();
}

class _AboutusScreenState extends State<AboutusScreen> {
  bool cmsstatus = false;
  var cms_name;
  var cms_img;
  var cms_title;
  var cms_content;

  void initState() {
    super.initState();
    CmsData();
  }

  CmsData() async {
    setState(() {
      cmsstatus = true;
      //token="Bearer"+sharepref.getString("usertoken");
    });
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
    var cms_url = ApiConfig().baseurl + ApiConfig().api_cmspg + "1";
    print("Employee Update URL--->" + cms_url);


    print("cms_url : "+cms_url.toString());
    var headerss={

      ApiConfig().content_type:ApiConfig().content_type_value,
      ApiConfig().x_api_key:ApiConfig().x_api_key_value,
      // ApiConfig().key_auth:token.toString(),
    };


    var cms_url_response= await http.get(Uri.parse(cms_url),headers:headerss );

    var jsonDecoded=jsonDecode(cms_url_response.body);
    print("site_response : "+cms_url_response.body);
    var msg =jsonDecoded['message'];
    var success =jsonDecoded['status'];
    print("msg Expenses----->" + msg.toString());
    print("success Expenses----->" + success.toString());

    try{
      if(success==true){
        setState(() {
          cmsstatus=false;
        });
        var cmslist = jsonDecoded['data'];
          setState(() {
            cms_name = jsonDecoded['data']['cms_name'];
            cms_title = jsonDecoded['data']['cms_title'];
            cms_content = jsonDecoded['data']['cms_contant'];
            cms_img = jsonDecoded['data']['cms_banner'];

          });

         print("name : "+cms_name.toString());
         print("title : "+cms_title.toString());
        print("img : "+cms_img.toString());
        print("content : "+cms_content.toString());

        // print("cmslistdata : "+cmslist.toString());
        print("cmsdata : "+cmslist.toString());

        //var video = jsonDecoded['videoData'];
        //category=categorylist;
        print("categorylistdata : "+cmslist.length.toString());
        //print("dash_video : "+video.length.toString());
        // print("dash_video : "+videolist.length.toString());



      /*  Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

       */
      }else{
        setState(() {
          cmsstatus=false;
        });
      /*  Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

       */
      }
    }catch(e){
      print(e);
    }





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
          title: Text("About Us ",style:TextStyle(color: Colors.white,fontSize: 24) ,),
          centerTitle: true,
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
        ),
        body:cmsstatus==true?Center(child: CircularProgressIndicator()):

        Stack(

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
                          children: [
                            Container(
                              child: Text("| ",
                                style:TextStyle(color: color,fontSize: 22,fontWeight: FontWeight.bold) ,),
                            ),
                            Container(
                              child: Text(cms_title??"About  RGS ",
                                style:TextStyle(color: color,fontSize: 22,fontWeight: FontWeight.bold) ,),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(height: 200, width: 280, image: AssetImage('images/icon.png'),),
                          ],
                        ),
                        // Container(
                        //   width: size.width*0.9,
                        //   child: Text(cms_name??'National Insurance',
                        //     style: TextStyle(color: Colors.grey,fontSize: 22,fontWeight: FontWeight.w700),),
                        // ),
                        SizedBox(height: 10,),
                        Container(
                          width: size.width*0.9,

                          child: Html(data:cms_content)
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

}
