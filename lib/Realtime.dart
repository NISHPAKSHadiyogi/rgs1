import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rgs/tools.dart';

import 'message.dart';



class Chatscreen extends StatefulWidget {
  var frobottom1;
  Chatscreen(this.frobottom1);


  @override
  _ChatscreenState createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  static const color = const Color(0xFF563B5A);
  final TextEditingController inputController = new TextEditingController();
  ScrollController scrollController = new ScrollController();
  bool showSend = false;
  List<Message> items = [];
  void insertSingleItem(Message msg) {
    int insertIndex = items.length;
    items.insert(insertIndex, msg);
    scrollController.animateTo(
        scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOut
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text("Rajendra singh Rathore",style:TextStyle(color: Colors.white,) ,),
        leading: widget.frobottom1 == 2?
        GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)):Container(),

        centerTitle: false,
       // toolbarHeight: 70,


      ),
      body: Container(
        width: double.infinity, height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Expanded(
                child:ListView.builder(itemCount: items.length,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    Message item = items[index];
                    return buildListItemView(index, item);
                  },
                )
            ),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50),),

              margin: EdgeInsets.all(20),
              
              child: Container(
                padding: EdgeInsets.all(5.5),

                decoration: BoxDecoration( color: color,
                  borderRadius: BorderRadius.circular(80)
                ),
                // height: 40,
                // margin: EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[

                    Expanded(

                      child: TextField(
                        controller: inputController,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),

                        maxLines: 1, minLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: new InputDecoration.collapsed(
                          fillColor: Colors.white,
                          hintStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                            hintText: ' Type a message....',


                        ),
                        onChanged: (term){
                          setState(() { showSend = (term.length > 0); });
                        },
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          if(showSend) sendMessage();

                        });

                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        child: Icon(Icons.arrow_forward,color: Colors.white,),
                      ),

                    ),


                    /*IconButton(icon: Icon(showSend ? Icons.send : Icons.mic, color: Colors.blue), onPressed: () {
                      if(showSend) sendMessage();
                    }),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void sendMessage(){
    String message = inputController.text;
    inputController.clear();
    showSend = false;
    setState(() {
      insertSingleItem(
          Message.time(getItemCount(), message, true,
              getItemCount() % 5 == 0,
              Tools.getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch)
          )
      );
    });
    generateReply(message);
  }
  int getItemCount() => items.length;
  void generateReply(String msg){
    Timer(Duration(seconds: 1), () {
      setState(() {
        insertSingleItem(
            Message.time(getItemCount(), msg, false, getItemCount() % 5 == 0,
                Tools.getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch)
            )
        );
      });
    });
  }
  Widget buildListItemView(int index, Message item){
    bool isMe = item.fromMe;
    return Wrap(
      alignment: isMe ? WrapAlignment.end : WrapAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Card(
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5),),
                margin: EdgeInsets.fromLTRB(isMe ? 20 : 10, 5, isMe ? 10 : 20, 5),
                color: isMe ? color : Colors.white, elevation: 1,
                child : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[

                      Container(
                        constraints: BoxConstraints(minWidth: 150),
                        child: Text(item.content, style: TextStyle(fontWeight: FontWeight.w600,
                            color: isMe ? Colors.white : Colors.black)
                        ),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(item.date,
                              textAlign: TextAlign.end, style: TextStyle(fontSize: 12, color: isMe ? Colors.white :Colors.grey)),
                          Container(width: 3),
                          isMe ? Icon(Icons.done_all, size: 12, color: Colors.white) : Container(width: 0, height: 0)
                        ],
                      )
                    ],
                  ),
                )
            ),
             Container(

              margin: EdgeInsets.fromLTRB(isMe ? 20 : 10, 5, isMe ? 10 : 20, 5),
              child: CircleAvatar(
                radius: 10,
                backgroundImage: AssetImage('images/otp.png'),
              ),
            )
          ],
        )
      ],
    );
  }

}


