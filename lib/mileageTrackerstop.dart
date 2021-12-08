import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rgs/MileageTracker.dart';
import 'package:rgs/Models/Person.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'Login.dart';
import 'Models/Employee.dart';

var color = const Color(0xFF563B5A);


class MileageTrackerstopPage extends StatefulWidget {

  var  frombottom;
  MileageTrackerstopPage(this.frombottom);
  @override
  _MileageTrackerstopPageState createState() => _MileageTrackerstopPageState();
}

class _MileageTrackerstopPageState extends State<MileageTrackerstopPage> {
  DateTime selectedDate = DateTime.now();
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;
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
  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employees: employees);
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                SharedPreferences preference = await SharedPreferences.getInstance() ;
                await preference.clear();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                //code to execute when this button is pressed
              }
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0,top: 10.0,right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ Text("| Mileage Tracker ",
                  style:TextStyle(color: color,fontSize: 22,fontWeight: FontWeight.bold) ,),
                  Container( child:
                  RaisedButton(
                    color: color,
                    textColor: Colors.white,
                     onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MileageTrackerPage(null))),

                    child: Text('Stop'),

                  )
                  ),
                ],),
              SizedBox(height: 10,),


              Text("Mileage Tracker  Mileage Tracker Mileage Tracker Mileage Tracker Mileage Tracker "
                  "Mileage Tracker  ",
                style:TextStyle(color: Colors.grey,fontSize: 14,) ,),
              SizedBox(height: 7,),
              Text(" Search Record    ",style:TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.bold) ,),
              Card(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("${selectedDate.toLocal()}".split(' ')[0]),
                      SizedBox(height: 30.0,width: 15,),

                      IconButton(


                        icon: ImageIcon( AssetImage('images/date.png'),),
                        onPressed: () => _selectDate(context),

                      ),
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      SizedBox(height: 30.0,width: 25,),
                      IconButton(


                        icon: ImageIcon( AssetImage('images/date.png'),),
                        color: color2,
                        onPressed: () => _selectDate(context),

                      ),

                    ],
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //  crossAxisAlignment: CrossAxisAlignment.center,
                children: [Container( child:
                RaisedButton(
                  color: color,
                  textColor: Colors.white,
                  onPressed: () => _selectDate(context),
                  child: Text('Go'),

                )
                ),
                  SizedBox(width: 10,),
                  Container( child:
                  RaisedButton(

                      color: color,
                      textColor: Colors.white,
                      onPressed: () => null,
                      child: Row(children: [
                        ImageIcon(AssetImage('images/download.png')),
                        Text('Download'),],)

                  )
                  ),
                ],),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(color:color,
                    border: Border.all(color: color
                        ,width: 0.5),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: SfDataGridTheme(
                    data: SfDataGridThemeData(headerColor:  Colors.grey.shade300),
                    child:SfDataGrid(
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: bottomNavigationBar,
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

}