import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//ignore: import_of_legacy_library_into_null_safe


import 'CapitalGainsTax.dart';
import 'IncomeTax.dart';
import 'Login.dart';
import 'Models/typeModel.dart';
class KeyTaxDates extends StatefulWidget {
  static TextEditingController Controlleruser = TextEditingController();
  @override
  _KeyTaxDatesState createState() => _KeyTaxDatesState();

}

class _KeyTaxDatesState extends State<KeyTaxDates> {
  late Timer _timer;
  int _start = 60;
  var _start1 ;

  var title;
  var shortDes;
  var numberList;
  Future<void> getKeyTaxData() async {

    var headers = {
      'X-API-KEY': 'AYTWEB@12345678',
      'Authorization': 'Basic YXl0YWRtaW46MTIzNDU2Nzg=',
      'Cookie': 'session=6n02d43hlaik0m87u07cku9fmjn30vfb'
    };
    var response =
    await http.post(Uri.parse("https://technolite.in/staging/taxrjs/api/all_taxkeydate"),headers: headers);
    print("Response" + response.body);

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["data"];

    if (response.statusCode == 200) {
      print("Success");
      var title01= data[0]["name"];
      var shortDes01=data[0]["sort_description"];
      var id=data[0]["id"];
      setState(() {
        title= title01;
        shortDes= shortDes01;
        numberList = int.parse(id);
      });
    }
    else {
      print(response.reasonPhrase);
    }


  }

  @override
  void initState() {
    super.initState();
    getKeyTaxData();

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
        title: Text("Key Tax Dates",style:TextStyle(color: Colors.white,) ,),
        centerTitle: true,
        automaticallyImplyLeading: true,
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

          // Container(
          //   height: 460,
          //   child: Container(
          //     child: FutureBuilder<TypeModel>(
          //         future: typeBy(),
          //         builder: (BuildContext context, AsyncSnapshot<TypeModel> snapshot) {
          //           if (snapshot.hasData) {
          //             print("objectPrint" +
          //                 snapshot.data!.data
          //                     .toString());
          //             return ListView.builder(
          //                 scrollDirection:
          //                 Axis.vertical,
          //                 itemCount: snapshot
          //                     .data!.data.length,
          //                 itemBuilder:
          //                     (context, index) {
          //                   var bestSellerProducts =
          //                   snapshot.data!
          //                       .data[index];
          //                   print(
          //                       "objectPrintdfgdfh" +
          //                           snapshot.data!
          //                               .data[index]
          //                               .toString());
          //                   return Container(
          //                       child: Card(
          //                           shadowColor: color,
          //                           elevation: 2,
          //                           child:
          //
          //                               Container( decoration: BoxDecoration(color:Colors.white,
          //
          //                                 //borderRadius: BorderRadius.circular(25.0),
          //                               ),
          //                                   margin: const EdgeInsets.all(0),
          //                                   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          //                                 child:
          //                                   Row(
          //                                     children:  <Widget>[
          //
          //                                   Container(color: color,width: 5, height: 300,),
          //
          //                                   SizedBox(width: 10,),
          //                                   Expanded(
          //                                   child:
          //
          //                           ListTile(
          //                             title: Text('${snapshot.data!
          //                                 .data[index].name} '),
          //                            subtitle:Text('${snapshot.data!
          //                                .data[index].sort_description} '),
          //                             trailing: Image(image:
          //                            AssetImage('images/tax.png')),
          //                             contentPadding:EdgeInsets.fromLTRB(0, -10, 0, 0),
          //                            onTap: () => {
          //                               Navigator.push(
          //                                 context,
          //                            MaterialPageRoute(builder: (context) =>  IncomeTax()),
          //                                              ),
          //                            },
          //
          //                         )
          //                                   )
          //
          //                                     ]
          //                                   ),
          //
          //                               )
          //
          //
          //
          //
          //                       )
          //                       );
          //                 });
          //           } else
          //             return Center(
          //                 child:
          //
          //                 Text("No data found"));
          //         }),
          //   ),
          // ),
          FutureBuilder<TypeModel>(
    future: typeBy(),
    builder: (BuildContext context, AsyncSnapshot<TypeModel> snapshot) {
      if (snapshot.hasData) {
        print("objectPrint----" +
            snapshot.data!.data
                .toString());
        return

          Expanded(
            child: ListView.builder(
                itemCount: snapshot.data!.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5.0,
                    margin: EdgeInsets.all(8.0),

                    child: Container(
                      padding: EdgeInsets.only(left: 5),
                      color: color,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        color: Colors.white,
                        child: GestureDetector(
                          onTap: () =>
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CapitalGainsTax(snapshot.data!.data[index].id)),
                            ),
                          },

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.7,
                                    padding: EdgeInsets.all(0.8),
                                    child: Text(
                                      snapshot.data!
                                          .data[index].name??"-",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,

                                      ),

                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    width: size.width * 0.7,

                                    padding: EdgeInsets.all(0.8),
                                    child: Text(snapshot.data!
                                        .data[index].sort_description??="-",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),),
                                  ),
                                  SizedBox(height: 15,),
                                ],
                              ),
                              SizedBox(width: 20,),
                              GestureDetector(
                                onTap: () =>
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CapitalGainsTax(snapshot.data!
                                    .data[index].id)
                                )
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
                  );
                }),
          );
      }
      else if(snapshot.hasError){
        return Center(
            child:

           SizedBox( height:height/2,child:Text("No data found",style: TextStyle(color: Colors.red,fontSize: 14))));

      }else

      {return

          SizedBox(height:height*0.50,width: width,child: Center(
      child:Text("Loading")));
          }
    } ),



        ],

      ),
      //bottomNavigationBar: bottomNavigationBar,
    ); // showing the route
  }
  Future<TypeModel> typeBy() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var language_id = preferences.getString("language_id");
    var  search="";
    var  page="";
    String requestUrl = "https://technolite.in/staging/taxrjs/api/all_taxkeydate";
    //print("SliderUrl--> " + endpointUrl);
    //  Map<String, String> queryParameter = {
    //    routeKey: routeProductType,
    //  };
    // String queryString = Uri(queryParameters: queryParameter).query;
    // var requestUrl = url + '?' + queryString;
    // print("listEmployeeurl--> " + requestUrl);
    Map<String, String> headers = {

      'X-API-KEY': "AYTWEB@12345678",
      'Authorization': 'Basic YXl0YWRtaW46MTIzNDU2Nzg=',
      'Cookie': 'session=6n02d43hlaik0m87u07cku9fmjn30vfb'
    };

    String body = jsonEncode({"page": page,"search":search});

    var response = await http.post(Uri.parse(requestUrl),  headers: headers
    );

    print("object all" + response.body);

    var jasonDataOffer = jsonDecode(response.body);
    print("object all" + response.statusCode.toString());
    if (response.statusCode == 200) {
      return TypeModel.fromJson(jasonDataOffer);
    }

    return jasonDataOffer;

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