import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rgs/MileageTracker.dart';
import 'package:shared_preferences/shared_preferences.dart';
//ignore: import_of_legacy_library_into_null_safe


import 'IncomeTax.dart';
import 'Login.dart';
import 'Models/typeModel.dart';
class TaxTable extends StatefulWidget {

  static TextEditingController Controlleruser = TextEditingController();
  @override
  _TaxTableState createState() => _TaxTableState();

}

class _TaxTableState extends State<TaxTable> {
  late Timer _timer;
  int _start = 60;
  var _start1 ;


  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
        () => 'Data Loaded',
  );

  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    // TextEditingController Controlleruser = TextEditingController();
    bool hidepassword = true;
    const color = const Color(0xFF563B5A);
    const color2 = const Color(0xFF162037);
    var group_id,
        product_id,
        category_id,
        cartCount,
        sort_type_id;


    // startTimer();
    return Scaffold(


      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: color,
        title: Text("Tax Tables",style:TextStyle(color: Colors.white,fontSize: 24) ,),
        centerTitle: true,
        automaticallyImplyLeading: true,
        // leading: widget.frobottom1 == 2?
        // GestureDetector(
        //     onTap: (){
        //       Navigator.pop(context);
        //     },
        //     child: Icon(Icons.arrow_back)):Container(),
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

      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Container(
            height: height*0.85,
            child: FutureBuilder<TypeModel>(
                future: typeBy(),
                builder: (BuildContext context, AsyncSnapshot<TypeModel> snapshot) {
                  if (snapshot.hasData) {
                    print("objectPrint" +
                        snapshot.data!.data
                            .toString());
                    return ListView.builder(
                        scrollDirection:
                        Axis.vertical,
                        itemCount: snapshot
                            .data!.data.length,
                        itemBuilder:
                            (context, index) {
                          var bestSellerProducts =
                          snapshot.data!
                              .data[index];
                          print(
                              "objectPrintdfgdfh" +
                                  snapshot.data!
                                      .data[index]
                                      .toString());
                          return Container(
                              child:  Card(
                                elevation: 5.0,
                                margin: EdgeInsets.all(8.0),

                                child: Container(
                                  padding: EdgeInsets.only(left: 5),
                                  color:  color,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    color: Colors.white,
                                    child:  GestureDetector(
                                      onTap: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  IncomeTax(snapshot.data!
                                              .data[index].id)),
                                        ),
                                      },

                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: size.width*0.7,
                                                padding: EdgeInsets.all(0.8),
                                                child: Text(
                                                  snapshot.data!
                                                    .data[index].name??"-",
                                                  style: TextStyle(
                                                    color: Colors.grey, fontWeight: FontWeight.w600,
                                                    fontSize: 18,

                                                  ),

                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Container(
                                                width: size.width*0.7,

                                                padding: EdgeInsets.all(0.8),
                                                child:  Text(snapshot.data!
                                                    .data[index].sort_description??="-",
                                                  style: TextStyle(color: Colors.grey,fontSize: 14),),
                                              ),
                                              SizedBox(height: 15,),
                                            ],
                                          ),
                                          SizedBox(width: 20,),
                                          GestureDetector(
                                            onTap: () => {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) =>  IncomeTax(snapshot.data!
                                                    .data[index].id)),
                                              ),
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              child: Image(image:
                                              AssetImage('images/tax.png'),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              );
                        });
                  } else if(snapshot.hasError){
                    return Center(
                        child:

                        Text("No data found",style: TextStyle(color: Colors.red,fontSize: 14)));

                  }else

                    {return Center(
                        child:
                    Text("Loading"));
                      }
                }),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 10,
          //       itemBuilder: (context,index){
          //     return  Card(
          //       elevation: 5.0,
          //       margin: EdgeInsets.all(8.0),
          //
          //
          //       child: Container(
          //
          //         padding: EdgeInsets.only(left: 5),
          //         color:  color,
          //         child: Container(
          //          // width: size.width*0.99,
          //           padding: EdgeInsets.only(left: 10),
          //           color: Colors.white,
          //           child:  GestureDetector(
          //             onTap: () => {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(builder: (context) =>  IncomeTax()),
          //               ),
          //             },
          //
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Container(
          //                       width: size.width*0.7,
          //                       padding: EdgeInsets.all(0.8),
          //                       child: Text(
          //                         "Income Tax",
          //                         style: TextStyle(
          //                           color: Colors.grey, fontWeight: FontWeight.w600,
          //                           fontSize: 18,
          //
          //                         ),
          //
          //                         textAlign: TextAlign.start,
          //                       ),
          //                     ),
          //                     SizedBox(height: 10,),
          //                     Container(
          //                       width: size.width*0.7,
          //                       padding: EdgeInsets.all(0.8),
          //                       child: Text('Income data Income dataIncome data Income '
          //                           'data Income data Income dataIncome data Income data '
          //                           'Income data Income dataIncome data Income data ',
          //                         style: TextStyle(color: Colors.grey,fontSize: 14),),
          //                     ),
          //                     SizedBox(height: 15,),
          //                   ],
          //                 ),
          //                 SizedBox(width: 20,),
          //                 GestureDetector(
          //                   onTap: () => {
          //                     Navigator.push(
          //                       context,
          //                       MaterialPageRoute(builder: (context) =>  IncomeTax()),
          //                     ),
          //                   },
          //                   child: Container(
          //                     height: 35,
          //                     width: 35,
          //                     child: Image(image:
          //                     AssetImage('images/tax.png'),),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     );
          //   }),
          // ),



        ],

      ),
      //bottomNavigationBar: bottomNavigationBar,
    ); // showing the route
  }
  Future<TypeModel> typeBy() async {
  //  SharedPreferences preferences = await SharedPreferences.getInstance();
    //var language_id = preferences.getString("language_id");

    var  search="";
    var  page=0;
    String requestUrl = "https://technolite.in/staging/taxrjs/api/all_tax_tables";

    //print("SliderUrl--> " + endpointUrl);
  //  Map<String, String> queryParameter = {
  //    routeKey: routeProductType,
  //  };
   // String queryString = Uri(queryParameters: queryParameter).query;
   // var requestUrl = url + '?' + queryString;
   // print("listEmployeeurl--> " + requestUrl);
   // var headerValue =
  //      "BmJLPUn3Yz3CWKd2cf8IpKzXhZhbRK2AkYnt40lLYgvZRyFc3ITtwNPYZyalTuCYWRakZMQVbPeV8jCSXKb5Mbdahb5ZbZ8izxuqlfdobX824lrIdZZHtTpM1EszHrkHcFxVwZQoyN44oht7mgeeaAuz8gHaYXieANYLSb66pcrjvhaWSKSkC48a4O6Ewwf5lD5LacLiopm3KGYziDjSoslckG1ucpls3t7HbSLJ5JTBhYIx3d5VbJuz8B1evas3";

    Map<String, String> headers = {

      'X-API-KEY': "AYTWEB@12345678",
      'authorization': 'Basic ' +
          base64Encode(utf8.encode('aytadmin:12345678')),
    };

    String body = jsonEncode({"page": page,"search":search});

    print("object all232" + body);

    var response = await http.post(Uri.parse(requestUrl), body: body, headers: headers);

    //print("object all" );
    print("object all" + response.body);

    var jasonDataOffer = jsonDecode(response.body);
    print( jasonDataOffer);
   if (response.statusCode == 200) {
    /* Fluttertoast.showToast(
         msg: "successfully",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.SNACKBAR,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.green,
         textColor: Colors.white,
         fontSize: 16.0);

     */
     return TypeModel.fromJson(jasonDataOffer);
    }else {
   /*  Fluttertoast.showToast(
         msg: "error",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.SNACKBAR,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.green,
         textColor: Colors.white,
         fontSize: 16.0);

    */
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