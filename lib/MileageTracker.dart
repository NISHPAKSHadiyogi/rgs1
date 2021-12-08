import 'dart:async';
import 'dart:convert';
//import 'dart:html';

import 'dart:io';
// import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:rgs/Models/Person.dart';
import 'package:rgs/mileageTrackerstop.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart'as http;
import 'BottomBar.dart';
import 'ConnectionStatus.dart';
import 'Login.dart';
import 'Models/Employee.dart';
// import 'package:get_storage/get_storage.dart';
var color = const Color(0xFF563B5A);
var pdf;
List<Employee> employees = <Employee>[];
DateTime selectedDate = DateTime.now();
DateTime selectedDate1 = DateTime.now();
final DataGridController _dataGridController = DataGridController();

late File f;
var  imageUrl="https://www.itl.cat/pngfile/big/10-100326_desktop-wallpaper-hd-full-screen-free-download-full.jpg";
bool downloading=true;
String downloadingStr="No data";
double download=0.0;
class MileageTrackerPage extends StatefulWidget {

  var  frombottom;
MileageTrackerPage(this.frombottom);
  @override
  _MileageTrackerPageState createState() => _MileageTrackerPageState();
}

class _MileageTrackerPageState extends State<MileageTrackerPage> {

 // List<Employee>getdata;
  late EmployeeDataSource employeeDataSource;
  var trackids;
  var loginid;


  int? helloAlarmID =1;
  var flag=1;
  bool flagstatus=false;
var textstatus="Start";
  getPrefance() async {
    //await Permission.locationAlways.request();
    // print(Permission.locationAlways.status.then((value) => print(value)));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var loginid01 = sharedPreferences.getString('LoginId');
    setState(() {
      loginid = loginid01;
    });
    userTracker(loginid);
  }

  getPrefanceStop() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var loginid01 = sharedPreferences.getString('LoginId');
    setState(() {
      loginid = loginid01;
    });
    userTrackerStop(loginid);
  }
  userTracker(loginid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var  search="";
   // taxtable_id = id;
    String requestUrl = "http://taxrgs.adiyogitechnology.com//api/user_tracker";

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

   // String body = jsonEncode({"taxtable_id" : taxtable_id});

    print("object all232----" + loginid);




    var response = await http.post(Uri.parse(requestUrl), body: {"user_id": loginid.toString()}, headers: headers);
    //print("object all" );
  /*  print("object all" + response.body);
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["data"];


    print(loginid);
    var headers = {
      'X-API-KEY': 'AYTWEB@12345678',
      'Authorization': 'Basic YXl0YWRtaW46MTIzNDU2Nzg=',
      'Content-Type': 'application/json',
    };
    var body;
    print("#########"+loginid);
    body= jsonEncode({"user_id": loginid});

    print("body : "+body.toString());
    var response =
        await http.post(Uri.parse("https://technolite.in/staging/taxrjs/api/user_tracker"), body:{"user_id": loginid}
        ,headers: headers);

   */

    print("Response" + response.body);
    print("Response 2 " + response.statusCode.toString());
   var jsonData = jsonDecode(response.body);
      var msg =jsonData['message'];
    if (response.statusCode == 200) {
      print("Success --> "+jsonData['data']['tracker_id'].toString());
      setState(() {
        AndroidAlarmManager.periodic( Duration(seconds:10 ), helloAlarmID, getlatdata);
        sharedPreferences.setInt("flag", 2);
        flag = sharedPreferences.getInt("flag")!;

        var trackerId = jsonData['data']['tracker_id'].toString();
        sharedPreferences.setString("trackerId", trackerId);
        final newData = GetStorage();
        newData.write("trackerid", trackerId);
        var trackid01 =newData.read('trackerid');
        //API WayPoints call
        newData.write("freshtrack", trackid01);
        var trackid02 =newData.read('freshtrack');
        print("before New Tracked id "+trackid01.toString());
        print("before fresh Tracked id "+trackid02.toString());
        Fluttertoast.showToast(msg: "Tracker started");
        Navigator.pop(context);




        if(trackids==null){

        }else{
          // sharedPreferences.remove("trackerId");
          // newData.remove("trackerid");
          canceltimer();
        }
        getdata();
      });
    }
    else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: msg);
      print(response.reasonPhrase);
    }

  }

  userTrackerStop(loginid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String requestUrl = "http://taxrgs.adiyogitechnology.com//api/user_tracker";

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

    // String body = jsonEncode({"taxtable_id" : taxtable_id});

    print("object all232----" + loginid);




    var response = await http.post(Uri.parse(requestUrl), body: {"user_id": loginid.toString(),"stop":"1","tracker_id":trackids.toString()}, headers: headers);
/*
    print(loginid);
    var headers = {
      'X-API-KEY': 'AYTWEB@12345678',
      'Authorization': 'Basic YXl0YWRtaW46MTIzNDU2Nzg=',
      'Content-Type': 'application/json',
    };
    var body;
      body= jsonEncode({"user_id": loginid.toString(),"stop":"1","tracker_id":trackids.toString()});


    print("body : "+body.toString());
    var response =
    await http.post(Uri.parse("https://technolite.in/staging/taxrjs/api/user_tracker"), body:body,headers: headers);
    print("Response" + response.body);

 */


    var jsonData = jsonDecode(response.body);
    var msg =jsonData['message'];
    if (response.statusCode == 200) {
      print("Success --> "+jsonData['data']['tracker_id'].toString());
      setState(() {
        AndroidAlarmManager.periodic( Duration(seconds:10 ), helloAlarmID, getlatdata);
        sharedPreferences.setInt("flag", 1);
        flag = sharedPreferences.getInt("flag")!;
        var trackerId = jsonData['data']['tracker_id'].toString();
        sharedPreferences.setString("trackerId", trackerId);
        final newData = GetStorage();
        newData.write("trackerid", trackerId);
        var trackid01 =newData.read('trackerid');
        //API WayPoints call
        newData.write("freshtrack", trackid01);
        var trackid02 =newData.read('freshtrack');
        print("before New Tracked id "+trackid01.toString());
        print("before fresh Tracked id "+trackid02.toString());
        Fluttertoast.showToast(msg: "Tracker stoped");
        typeBy();
        Navigator.pop(context);


        if(trackids==null){

        }else{

          // sharedPreferences.remove("trackerId");
          // newData.remove("trackerid");
          canceltimer();
        }
        getdata();
      });
    }
    else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: msg);
      print(response.reasonPhrase);
    }

  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate1,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate1)
      setState(() {
        if(selectedDate.day<=picked.day) {
          selectedDate1 = picked;
        }
        else{
          Fluttertoast.showToast(
              msg: "select larger Date from Date",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }

      });
  }
  Future<void> downloadppdf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString("LoginId");
    var  search="";
    // var  page= Controlleruserold.text ;
    // var  page1= Controllerusernew.text ;
    // var  page2= Controlleruserconfirm.text ;

    String requestUrl = "https://technolite.in/staging/taxrjs/api/tracker_list";
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

    String body = jsonEncode({"email_id":"page" });
    var fdate=selectedDate.toLocal().toString().split(' ')[0];
    var todate=selectedDate1.toLocal().toString().split(' ')[0];
    var response = await http.post(Uri.parse(requestUrl),  body:{

      'from_date': fdate,
      'to_date': todate,
      'user_id': id,
      'isdownload': '1'
    },headers: headers
    );

    print("object all" + response.body);

    var jasonDataOffer = jsonDecode(response.body);
    print("object all###" + jasonDataOffer["message"].toString());
    if (response.statusCode == 200) {
      var jasonDataOffer = jsonDecode(response.body);
      pdf=jasonDataOffer["data"];
      imageUrl=pdf;
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar(bottom: 2)));
      Dio dio=Dio();
      var dir=await getApplicationDocumentsDirectory();
      f=File("${dir.path}/myimagepath.pdf");
    //  File("images/user.png");

      String fileName=imageUrl.substring(imageUrl.lastIndexOf("/")+1);
      dio.download(imageUrl, "${dir.path}/$fileName",onReceiveProgress: (rec,total)
      {
        setState(() {
          downloading = true;
          download = (rec / total) * 100;
          print(fileName);
          downloadingStr =
              "Downloading Image : " + (download).toStringAsFixed(0);
        });
      });
        Fluttertoast.showToast(
            msg: jasonDataOffer["message"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        //  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Login()),);

        //Fluttertoast(,jasonDataOffer["message"],)
        //return TypeModel.fromJson(jasonDataOffer);

    }
          else{
          Fluttertoast.showToast(
          msg:jasonDataOffer["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
          }

          return jasonDataOffer;


    }
          @override
  void initState() {

   // employees = getEmployeeData();


    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
   // getPermission();
      employeeDataSource = EmployeeDataSource(employees: employees);
      employeeDataSource.dataGridRow.clear();
      typeBy();
      getdata();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Size size =  MediaQuery.of(context).size;
    // TextEditingController Controlleruser = TextEditingController();
    bool hidepassword = true;
    const color = const Color(0xFF563B5A);
    const color2 = const Color(0xFF162037);

    List<Person> _personList = [Person(id:0,name:"",email:"",phone:"")];
    // startTimer();
    return Scaffold(
      appBar: AppBar(


    backgroundColor: color,
    title: Text("Mileage Tracker",style:TextStyle(color: Colors.white,fontSize: 22) ,),

    leading: widget.frombottom==1?GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back)):Container(),
    centerTitle: true,
    actions: [
      IconButton(
          icon: ImageIcon(
            AssetImage('images/Logout 1@2x.png'),
          ),
          onPressed: () async{
            // SharedPreferences preference = await SharedPreferences.getInstance() ;
            // await preference.clear();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
            //code to execute when this button is pressed
          }
      ),
    ],
      ),
      body: SafeArea(
      child: Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return model.isOnline
            ? Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ Text("| Mileage Tracker ",
                  style: TextStyle(color: color,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),),
                  Container(child:
                  RaisedButton(
                    color: color,
                    textColor: Colors.white,
                    // onPressed: () => _selectDate(context),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) =>
                              Dialog(
                                backgroundColor: Colors.transparent,

                                child: Container(
                                  width: size.width * 0.7,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    color: Colors.white,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Wrap(
                                      children: <Widget>[

                                        Center(
                                          child: Container(
                                            height: size.height * .27,
                                            width: size.width * .75,
                                            padding: EdgeInsets.all(2.3),
                                            child: Column(

                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 3),

                                                  height: 50,
                                                  width: size.width * .85,
                                                  //alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF563B5A),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(0)
                                                    ),
                                                    border: Border.all(
                                                      color: Color(0xFF563B5A),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text("Confirmation",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight
                                                              .w700),),
                                                  ),

                                                ),
                                                SizedBox(height: 15,),
                                                Center(
                                                  child: flag == 1 ? Text(
                                                    'Do you want to start your journey',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15),) : Text(
                                                    'Do you want to Stop your journey',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15),),
                                                ),
                                                SizedBox(height: 7,),
                                                // Center(child: Text('Are you sure?',
                                                //   style: TextStyle(color: Colors.grey,fontSize: 15),)),
                                                SizedBox(height: 25,),


                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (flag == 1) {
                                                          getPrefance();
                                                        }
                                                        else {
                                                          getPrefanceStop();
                                                        }


                                                        // Navigator.push(context, MaterialPageRoute(builder: (context) =>MileageTrackerstopPage(null)));
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 5),

                                                        height: 40,
                                                        width: size.width * .25,
                                                        //alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF563B5A),
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius.circular(5)
                                                          ),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFF563B5A),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text("Yes",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),),
                                                        ),

                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 30,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },

                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 5),

                                                        height: 40,
                                                        width: size.width * .25,
                                                        //alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius.circular(5)
                                                          ),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFF563B5A),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text("No",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF563B5A),
                                                                fontSize: 15),),
                                                        ),

                                                      ),
                                                    ),
                                                  ],
                                                ),


                                                //Text(_selectedGender == 'male' ? 'Hello gentlement!' : 'Hi lady!')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    },

                    child: Text(flag == 1 ? textstatus : "Stop"),

                  )
                  ),
                ],),
              SizedBox(height: 10,),


              Text("Mileage Tracker   ",
                style: TextStyle(color: Colors.grey, fontSize: 14,),),
              SizedBox(height: 7,),
              Text(" Search Record    ", style: TextStyle(color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),),
              Card(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("${selectedDate.toLocal()}".split(' ')[0]),
                      SizedBox(height: 30.0, width: 15,),

                      IconButton(


                        icon: ImageIcon(AssetImage('images/date.png'),),
                        onPressed: () => _selectDate(context),

                      ),
                      Text("${selectedDate1.toLocal()}".split(' ')[0]),
                      SizedBox(height: 30.0, width: 25,),
                      IconButton(


                        icon: ImageIcon(AssetImage('images/date.png'),),
                        color: color2,
                        onPressed: () => _selectDate1(context),

                      ),

                    ],
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //  crossAxisAlignment: CrossAxisAlignment.center,
                children: [Container(child:
                RaisedButton(
                  color: color,
                  textColor: Colors.white,
                  onPressed: () => typeBy(),
                  child: Text('Go'),

                )
                ),
                  SizedBox(width: 10,),
                  Container(child:
                  RaisedButton(

                      color: color,
                      textColor: Colors.white,
                      onPressed: () => downloadppdf(),
                      child: Row(children: [
                        ImageIcon(AssetImage('images/download.png')),
                        Text('Download'),
                      ],)

                  )
                  ),
                ],),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: color,
                    border: Border.all(color: color
                        , width: 0.5),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: SfDataGridTheme(
                    data: SfDataGridThemeData(
                        headerColor: Colors.grey.shade300),
                    child: SfDataGrid(
                      source: employeeDataSource,
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,


                      columnWidthMode: ColumnWidthMode.auto,
                      columns: <GridColumn>[

                        GridColumn(
                            columnName: 'id',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'Date',
                                ))),
                        GridColumn(
                            columnName: 'name',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                alignment: Alignment.center,
                                child: Text('Start Time'))),
                        GridColumn(
                            columnName: 'designation',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'End Time',

                                ))),
                        GridColumn(
                            columnName: 'salary',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                alignment: Alignment.center,
                                child: Text('Run Miles'))),
                      ],
                      controller: _dataGridController,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ) : Container(
          height: size.height * 0.8,
          width: size.width * 1.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Container(height: 10),
                    Icon(Icons.network_check,
                        color: Colors.red.shade400, size: 80),
                    Container(height: 10),
                    Text(
                      "No Internet Connection",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red.shade400,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(height: 10),
                  ],
                ),
              )
            ],
          ),
        );
      }else
      return Center(
      child: CircularProgressIndicator());

      })
    )// bottomNavigationBar: bottomNavigationBar,
    );

  }
  List<Employee> getEmployeeData() {
    return [
      Employee("10-12-2021", '11:00AM', '11:00AM ', "20 Miles"),
      Employee("10-12-2021", '11:00AM', '11:00AM ', "20 Miles"),
      Employee("10-12-2021", '11:00AM', '11:00AM ', "20 Miles"),
      Employee("10-12-2021", '11:00AM', '11:00AM ', "20 Miles"),
      Employee("10-12-2021", '11:00AM', '11:00AM ', "20 Miles"),
      Employee("10-12-2021", '11:00AM', '11:00AM ', "20 Miles"),
      Employee("10-12-2021", '11:00AM', '11:00AM ', "20 Miles"),
      Employee("10-12-2021", '11:00AM', '11:00AM ', "20 Miles"),
      Employee("10-12-2021", '11:00AM', '11:00AM ', "20 Miles"),
      Employee("10-12-2021", '11:00AM', '11:00AM ', "20 Miles"),
      Employee("10-12-2021", '11:00AM', '11:00AM ', "20 Miles"),
      Employee("10-12-2021", '11:00AM', '11:00AM ', "20 Miles"),


    ];
  }

  Future<void> getdata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      flag= sharedPreferences.getInt("flag")!;
     trackids= sharedPreferences.getString("trackerId");

     print("trackids : "+trackids.toString());

    });
  }

  Future<void> canceltimer() async {
    await AndroidAlarmManager.cancel(helloAlarmID);
  }

  Future<void> typeBy() async {
    //  SharedPreferences preferences = await SharedPreferences.getInstance();
    //var language_id = preferences.getString("language_id");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var loginid01 = sharedPreferences.getString('LoginId');
    var  search="";
    var  page=0;
    String requestUrl = "http://taxrgs.adiyogitechnology.com/api/tracker_list";

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
    var fdate=selectedDate.toLocal().toString().split(' ')[0];
    var todate=selectedDate1.toLocal().toString().split(' ')[0];
    String body = jsonEncode({
      'limit': '10',
      'offset': '0',
      'from_date': fdate,
      'to_date': todate,
      'user_id':loginid01
    });

    print("object all232" + body);

    var response = await http.post(Uri.parse(requestUrl), body: {
      'limit': '10',
      'offset': '0',
      'from_date': fdate,
      'to_date': todate,
      'user_id':loginid01
    }, headers: headers);

    //print("object all" );
    print("object all" + response.body);

    var jasonDataOffer = jsonDecode(response.body);
    print( jasonDataOffer);
    print(response.statusCode.toString() );
    if (response.statusCode == 200) {
      employees.clear();
print(jasonDataOffer["data"].length.toString());
      for(int i=0;i<jasonDataOffer["data"].length;i++) {
        var date=jasonDataOffer["data"][i]["date"];
        var start_time=jasonDataOffer["data"][i]["start_time"];
        var end_time=jasonDataOffer["data"][i]["end_time"];
        var total_miles=jasonDataOffer["data"][i]["total_miles"];
        if(start_time==null){
          start_time="-";
        }
        if(end_time==null){
          end_time="-";
        }
        if(total_miles==null){
          total_miles="-";
        }
        employees.insert(i, Employee(date,
            start_time,
            end_time,
            total_miles),);
      }
setState(() {

  employeeDataSource.dataGridRow.clear();
  employeeDataSource=EmployeeDataSource(employees: employees);

});

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


    // return jasonDataOffer;

    //  return  TypeModel(status: "status", code: "code", message: "message",data: "hfjhd");
  }


}
Future<void> getlatdata()async {
  print("New Tracked id 1 ");
  // final newData = GetStorage();
  // var trackid02 =newData.read('freshtrack');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var trackid02= sharedPreferences.getString("trackerId");
  //API WayPoints call
  print("New Tracked id 1 "+trackid02.toString());
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition = Position();
  //
  // Timer(
  //     Duration(seconds: 3),
  //         () => );

  getGeoData(){
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      // await Future.delayed(Duration(seconds: 1));
      _currentPosition = position;
      print("hey Position : " +
          _currentPosition.latitude.toString() +
          "<--:-->" +
          _currentPosition.longitude.toString());

      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // trackid= sharedPreferences.getString("trackerId");
      // var trackid02 =newData.read('freshtrack');
      //API WayPoints call
      print("New Tracked id 2 "+trackid02.toString());

      var headers = {
        'X-API-KEY': 'AYTWEB@12345678',
        'Authorization': 'Basic YXl0YWRtaW46MTIzNDU2Nzg=',
        'Cookie': 'session=397jop3gue5hr986kko83um75gnp3875'
      };
      var request = http.MultipartRequest('POST', Uri.parse('http://taxrgs.adiyogitechnology.com/api/waypoints'));
      request.fields.addAll({
        'tracker_id': trackid02.toString(),
        'latitude': _currentPosition.latitude.toString(),
        'longitude': _currentPosition.longitude.toString()
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print("Success Waypoints"+await response.stream.bytesToString());
      }
      else {
        print("failed "+ response.reasonPhrase.toString());
      }


    }).catchError((e) {
      print(e);
    });
  }
  Future<void> sendWayPoints() async {

  }

  if (_currentPosition.latitude == null){
    getGeoData();
  }
  else{
    print("hey Position : 0 " +
        _currentPosition.latitude.toString() +
        "<--:-->" +
        _currentPosition.longitude.toString());
  }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition();
  // }
}

/*
Future<void> getPermission() async {
  final serviceStatus = await PermissionHandler()
      .checkServiceStatus(PermissionGroup.locationWhenInUse);
  print("-+--");

  print(serviceStatus);
  final isGpsOn = serviceStatus == ServiceStatus.enabled;
  print("Enable" + isGpsOn.toString());
  if (!isGpsOn) {
    print('Turn on location services before requesting permission.');
    String titls = "Location";
    String content = "Enable your location is disable";
    print("Enable -+--");
    // _showDialog(title,content);
    showDialog(
        context: context,
        builder: (_) => CustomEventDialog(title: titls, content: content));
    return isGpsOn;
  }else{
    var geolocator = Geolocator();

    GeolocationStatus geolocationStatus =
    await geolocator.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case GeolocationStatus.disabled:
        print('ok- Disabled');
        var titls = "Permission";
        var content = "your permission is disabled";
        // _showDialog(title,content);
        showDialog(
            context: context,
            builder: (_) => CustomEventDialog(title: titls, content: content));
        break;

      case GeolocationStatus.restricted:
        print('ok- Restricted');

        var titls = "Permission";
        var content = "your permission is restricted";
        // _showDialog(title,content);
        showDialog(
            context: context,
            builder: (_) => CustomEventDialog(title: titls, content: content));
        break;

      case GeolocationStatus.denied:
        print('ok- Denied');
        var titls = "Permission";
        var content = "your permission is denied";
        // _showDialog(title,content);
        showDialog(
            context: context,
            builder: (_) => CustomEventDialog(title: titls, content: content));
        break;
      case GeolocationStatus.unknown:
        print('ok- Unknown');
        var titls = "Permission";
        var content = "your permission is unknown";
        // _showDialog(title,content);
        showDialog(
            context: context,
            builder: (_) => CustomEventDialog(title: titls, content: content));
        break;

      case GeolocationStatus.granted:
        print('ok- Granted --> ');
        _getCurrentLocation();
        break;
    }

  }
}

class CustomEventDialog extends StatefulWidget {
  String title;
  String content;
  CustomEventDialog({this.title, this.content});

  @override
  CustomEventDialogState createState() => new CustomEventDialogState();
}

class CustomEventDialogState extends State<CustomEventDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 160,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                color: Colors.red[300],
                child: Column(
                  children: <Widget>[
                    Container(height: 10),
                    Icon(
                        widget.title == "Location"
                            ? Icons.cloud_off
                            : widget.title == "Refresh Location"
                            ? Icons.refresh
                            : Icons.perm_device_info_rounded,
                        color: Colors.white,
                        size: 80),
                    Container(height: 10),
                    Text(
                      widget.title == null ? "" : widget.title,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Text(widget.content == null ? "" : widget.content,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade700)),
                    Container(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[300],
                        padding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0)),
                      ),
                      child: Text("Setting",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (widget.title == "Location") {
                          AppSettings.openLocationSettings();
                        } else {
                          AppSettings.openAppSettings();
                        }
                        // Navigator.of(context).pop();
                        // Toast.show("Retry clicked", context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 */



// class CustomEventDialog extends StatefulWidget {
//   final title;
//   final  content;
//   CustomEventDialog({this.title, this.content});
//
//   @override
//   CustomEventDialogState createState() => new CustomEventDialogState();
// }
//
// class CustomEventDialogState extends State<CustomEventDialog> {
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Dialog(
//         backgroundColor: Colors.transparent,
//
//         child: Container(
//           width: size.width*0.7,
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(4),
//             ),
//             color: Colors.white,
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             child: Wrap(
//               children: <Widget>[
//
//                 Center(
//                   child: Container(
//                     height: size.height*.27,
//                     width: size.width*.75,
//
//                     child: Column(
//
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(top: 3),
//
//                           height: 50,
//                           width: size.width*.85,
//                           //alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: Color(0xFF563B5A),
//                             borderRadius: BorderRadius.all(
//                                 Radius.circular(0)
//                             ),
//                             border: Border.all(
//                               color: Color(0xFF563B5A),
//                             ),
//                           ),
//                           child: Center(
//                             child: Text("Confirmation",
//                               style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.w700),),
//                           ),
//
//                         ),
//                         SizedBox(height: 15,),
//                         Center(
//                           child: Text('Do you want to start your journey',
//                             style: TextStyle(color: Colors.grey,
//                                 fontSize: 15),),
//                         ),
//                         SizedBox(height: 7,),
//                         // Center(child: Text('Are you sure?',
//                         //   style: TextStyle(color: Colors.grey,fontSize: 15),)),
//                         SizedBox(height: 25,),
//
//
//
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             GestureDetector(
//                               onTap: (){
//                                 // getPrefance();
//                                 // Navigator.push(context, MaterialPageRoute(builder: (context) =>MileageTrackerstopPage(null)));
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(top: 5),
//
//                                 height: 40,
//                                 width: size.width*.25,
//                                 //alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   color:Color(0xFF563B5A),
//                                   borderRadius: BorderRadius.all(
//                                       Radius.circular(5)
//                                   ),
//                                   border: Border.all(
//                                     color: Color(0xFF563B5A),
//                                   ),
//                                 ),
//                                 child: Center(
//                                   child: Text("Yes",
//                                     style: TextStyle(color:Colors.white,fontSize: 15),),
//                                 ),
//
//                               ),
//                             ),
//                             SizedBox(
//                               width: 30,
//                             ),
//                             GestureDetector(
//                               onTap: (){
//                                 Navigator.of(context).pop();
//                               },
//
//                               child: Container(
//                                 margin: EdgeInsets.only(top: 5),
//
//                                 height: 40,
//                                 width: size.width*.25,
//                                 //alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.all(
//                                       Radius.circular(5)
//                                   ),
//                                   border: Border.all(
//                                     color: Color(0xFF563B5A),
//                                   ),
//                                 ),
//                                 child: Center(
//                                   child: Text("No",
//                                     style: TextStyle(color:Color(0xFF563B5A),fontSize: 15),),
//                                 ),
//
//                               ),
//                             ),
//                           ],
//                         ),
//
//
//
//
//
//
//
//                         //Text(_selectedGender == 'male' ? 'Hello gentlement!' : 'Hi lady!')
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }