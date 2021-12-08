import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';




import 'Login.dart';
import 'Models/typeModel.dart';
class CapitalGainsTax extends StatefulWidget {
  String id="";
  CapitalGainsTax(this.id);
  static TextEditingController Controlleruser = TextEditingController();
  @override
  _CapitalGainsTaxState createState() => _CapitalGainsTaxState();

}

class _CapitalGainsTaxState extends State<CapitalGainsTax> {
  late Timer _timer;
  int _start = 60;
  var _start1 ;
  String id="";
  var  keytaxdates;
  var title;
  var shortDes;
  var description;
  Future<void> getCapitalgains() async {
    var headers = {
      'X-API-KEY': 'AYTWEB@12345678',
      'Authorization': 'Basic YXl0YWRtaW46MTIzNDU2Nzg=',
      'Cookie': 'session=ep4ndcfpj6bhoibg4k94l5s042cq5c1l'
    };
    var body= {
      "taxtable_id": keytaxdates
    };
    var response =
    await http.post(Uri.parse("https://technolite.in/staging/taxrjs/api/taxtable_detail"), body: body,headers: headers);
    print("Response" + response.body);

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["data"];


    if (response.statusCode == 200) {
      print("Success Detail");
      String heading01 = data[0]["name"];
      String shortDes01 = data[0]["sort_description"];
      String des01 = data[0]["description"];
      setState(() {
        title = heading01;
        shortDes = shortDes01;
        description = des01;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    id= widget.id;
    keytaxdates=id;
    getCapitalgains();

  }

  @override

  Widget build(BuildContext context) {

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
          title: Text("Capital Gains Tax ",style:TextStyle(color: Colors.white,) ,),
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

    //     Stack(
    //
    //       children: <Widget>[
    //         // Map View
    //
    //         // Show zoom buttons
    //         SafeArea(
    //           child: SingleChildScrollView(
    //             child: Padding(
    //               padding: const EdgeInsets.only(left: 10.0,top: 20.0,right: 10.0),
    //               child:
    // Container(
    // child: FutureBuilder<TypeModel>(
    // future: typeBy(),
    // builder: (BuildContext context, AsyncSnapshot<TypeModel> snapshot) {
    //   if (snapshot.hasData) {
    //     print("objectPrint" +
    //         snapshot.data!.data
    //             .toString());
    //
    //     return
    //
    //
    //       Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           //   Text("| Income Tax                ",style:TextStyle(color: color,fontSize: 32,fontWeight: FontWeight.bold) ,),
    //           Html(
    //             data: "<h1>hello</h1>",
    //           ),
    //
    //
    //         ],
    //
    //       );
    //   }
    // else
    // return Center(
    // child:
    //
    // Text("No data found"));
    //
    // },
    //
    //
    // ),
    //
    //           ),
    //         ),
    // ),
    //     ),
    //     ]
    //     ),
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
                        Text(title??"Loading...",
                          style:TextStyle(color: color,fontSize: 24,fontWeight: FontWeight.bold) ,),
                        SizedBox(height: 15,),

                        Text(shortDes??"",
                          style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.w600),),
                        SizedBox(height: 10,),
                        Html(data: description??""),


                      ],

                    ),
                  ),
                ),
              ),
            ]
        ),
       // bottomNavigationBar: bottomNavigationBar,
      ),

      // Show the place input fields & button for
    ); // showing the route
  }
  Future<TypeModel> typeBy() async {
    //  SharedPreferences preferences = await SharedPreferences.getInstance();
    //var language_id = preferences.getString("language_id");

    var  search="";
    var  taxtable_id = "1";
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

    print("object all232" + body);

    var response = await http.post(Uri.parse(requestUrl), body: body, headers: headers);

    //print("object all" );
    print("object all" + response.body);

    var jasonDataOffer = jsonDecode(response.body);
    print( jasonDataOffer);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      return TypeModel.fromJson(jasonDataOffer);
    }else {
      Fluttertoast.showToast(
          msg: "error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }


    return jasonDataOffer;

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