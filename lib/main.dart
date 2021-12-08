
import 'dart:async';
import 'dart:convert';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rgs/BottomBar.dart';
import 'package:rgs/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Api/ApiConfig.dart';
import 'ConnectionStatus.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;
import 'SplashScreenPage.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await GetStorage.init();
  //await FlutterDownloader.initialize(debug: true // optional: set false to disable printing logs to console
  //);

  runApp( MyApp());

}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return
      MultiProvider(
        providers: [
        ChangeNotifierProvider(
        create: (context) => ConnectivityProvider(),
    child: SplashScreen(),
    )
    ],
      child:
      GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    ));
  }
}

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool sitestatus=false;
  bool logIN=false;

  void initState() {
    super.initState();

    getPrefance();
    SiteSetting();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
          children: [
            Container(
              constraints: BoxConstraints.tight(size),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/splash.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ));
  }
var loginid;

  getPrefance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    loginid = sharedPreferences.getString('LoginId');
    print('Login id = $loginid');
    setState(() {
      logIN = sharedPreferences.getBool('loggedIn')??false;
      Timer(
        Duration(seconds: 5),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => loginid==null ?Login():BottomBar(bottom: 2),
          ),
        ),
      );
    });
  }
    SiteSetting() async {
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
     var site_url = ApiConfig().baseurl + ApiConfig().api_setting;
     print("Employee Update URL--->" + site_url);

     setState(() {
       sitestatus == true;
       //token="Bearer"+sharepref.getString("usertoken");
     });
     print("site_url : "+site_url.toString());
     var headerss={

       ApiConfig().content_type:ApiConfig().content_type_value,
       ApiConfig().x_api_key:ApiConfig().x_api_key_value,
      // ApiConfig().key_auth:token.toString(),
     };


     var site_response= await http.get(Uri.parse(site_url),headers:headerss );

     var jsonDecoded=jsonDecode(site_response.body);
     print("site_response : "+site_response.body);
     var msg =jsonDecoded['message'];
     var success =jsonDecoded['status'];
     print("msg Expenses----->" + msg.toString());
     print("success Expenses----->" + success.toString());

     try{
       if(success==true){
         setState(() {
           sitestatus=false;
         });
         var cmslist = jsonDecoded['data'];
         // tnc_title = jsonDecoded['data']['4']['name'];
         // tnc_name = jsonDecoded['data']['4']['title'];
         // tnc_content = jsonDecoded['data']['4']['content'];
         // tnc_img = jsonDecoded['data']['4']['banner'];
         // print("cmslistdata : "+tnc_title.toString());
         // print("title : "+tnc_name.toString());
         // print("content : "+tnc_content.toString());
         // print("img : "+tnc_img.toString());
         // print("cmslistdata : "+cmslist.toString());
          print("cmsdata : "+cmslist.toString());

         //var video = jsonDecoded['videoData'];
         //category=categorylist;
         print("categorylistdata : "+cmslist.length.toString());
         //print("dash_video : "+video.length.toString());
         // print("dash_video : "+videolist.length.toString());



        /* Fluttertoast.showToast(
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
           sitestatus=false;
         });
        /* Fluttertoast.showToast(
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



   }

