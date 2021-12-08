import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
//ignore: import_of_legacy_library_into_null_safe

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';
import 'Models/typeModel.dart';
class IncomeTax extends StatefulWidget {
  String id="";
  IncomeTax(this.id);
  static TextEditingController Controlleruser = TextEditingController();
  @override
  _IncomeTaxState createState( ) => _IncomeTaxState();

}

class _IncomeTaxState extends State<IncomeTax> {
  late Timer _timer;
  String id="";
  int _start = 60;
  var _start1 ;
  var  taxtable_id;
  var titlel,shortDes,description;
@override
  void initState() {
    // TODO: implement initState
   id= widget.id;
   taxtable_id=id;

   typeBy();
   setState(() {

   });

    super.initState();
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
          title: Text("Income Tax",style:TextStyle(color: Colors.white,) ,),
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
        body:

        Stack(

            children: <Widget>[
              // Map View

              // Show zoom buttons
              SafeArea(
       child:
        SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.only(left: 10.0,top: 20.0,right: 10.0),
    child:
    Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    //   Text("| Income Tax                ",style:TextStyle(color: color,fontSize: 32,fontWeight: FontWeight.bold) ,),
    Container(
    width: size.width*0.7,
    child: Text(titlel??"Loading...",
    style:TextStyle(color: color,fontSize: 24,fontWeight: FontWeight.bold) ,),
    ),
    SizedBox(height: 15,),

    Container(
    width: size.width*0.7,
    child: Text(shortDes??"",
    style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.w600),),
    ),
    SizedBox(height: 10,),
    Container(
    width: size.width*0.9,
    padding: EdgeInsets.all(1),
    child: Html(data: description??""),
    ),


    ],

    ),
    ),
    )
              ),



            ]
        ),
        //bottomNavigationBar: bottomNavigationBar,
      ),

      // Show the place input fields & button for
    ); // showing the route
  }
    Future<TypeModel> typeBy() async {
    //  SharedPreferences preferences = await SharedPreferences.getInstance();
    //var language_id = preferences.getString("language_id");

    var  search="";
      taxtable_id = id;
    String requestUrl = "https://technolite.in/staging/taxrjs/api/taxtable_detail";

    //print("SliderUrl--> " + endpointUrl);
    //  Map<String, String> queryParameter = {
   //   "route": routeProductType,
    //  };
  //   String queryString = Uri(queryParameters: queryParameter).query;
   //  var requestUrl = url + '?' + queryString;
    // print("listEmployeeurl--> " + requestUrl);
    // var headerValue =
    //      "BmJLPUn3Yz3CWKd2cf8IpKzXhZhbRK2AkYnt40lLYgvZRyFc3ITtwNPYZyalTuCYWRakZMQVbPeV8jCSXKb5Mbdahb5ZbZ8izxuqlfdobX824lrIdZZHtTpM1EszHrkHcFxVwZQoyN44oht7mgeeaAuz8gHaYXieANYLSb66pcrjvhaWSKSkC48a4O6Ewwf5lD5LacLiopm3KGYziDjSoslckG1ucpls3t7HbSLJ5JTBhYIx3d5VbJuz8B1evas3";

    Map<String, String> headers = {

    'X-API-KEY': "AYTWEB@12345678",
    'authorization': 'Basic ' +
    base64Encode(utf8.encode('aytadmin:12345678')),
    };

    String body = jsonEncode({"taxtable_id" : taxtable_id});

    print("object all232----" + body);




    var response = await http.post(Uri.parse(requestUrl), body: {"taxtable_id" : taxtable_id}, headers: headers);
    //print("object all" );
    print("object all" + response.body);
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["data"];

    if (response.statusCode == 200) {
      print(response.body);
      print(data[0]["name"]);
      String heading01 = data[0]["name"];
      String shortDes01 = data[0]["sort_description"];
      String des01 = data[0]["description"];
      setState(() {
        titlel = heading01;
        shortDes = shortDes01;
        description = des01;
      });
  /*  Fluttertoast.showToast(
    msg: "successfully",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0);

   */
     return TypeModel.fromJson(json.decode(response.body));
    }else {
   /* Fluttertoast.showToast(
    msg: "error",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0);

    */
    }


     return json.decode(response.body);

    //  return  TypeModel(status: "status", code: "code", message: "message",data: "hfjhd");
    }
  Widget get bottomNavigationBar {
    return
      Container(
        decoration: BoxDecoration(color:Colors.red,
          border: Border.all(width: 0.5),


          borderRadius: BorderRadius.circular(200.0),
        ),
        margin: const EdgeInsets.all(10.0),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child:
        ClipRRect(

          clipBehavior: Clip.antiAliasWithSaveLayer,

          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(200),
            topLeft: Radius.circular(200),
            bottomLeft: Radius.circular(200),
            bottomRight: Radius.circular(200),

          ),
          child: BottomNavigationBar(
            iconSize: 35,
            items: const [
              BottomNavigationBarItem(

                icon: ImageIcon(

                  AssetImage('images/4860638@2x.png'),
                ), label: '.'  ,),
              BottomNavigationBarItem(icon: ImageIcon(
                AssetImage('images/3257419 - Copy 1@2x.png'),
              ), label: '.'),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('images/Home-icon 1@2x.png'),
                  ), label: ''),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('images/Booking-Metting - Copy 1@2x.png'),
                  ), label: ''),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('images/User_font_awesome 2@2x.png'),
                  ), label: ''),
            ],
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            showUnselectedLabels: true,
          ),
        ),
      );

  }
}