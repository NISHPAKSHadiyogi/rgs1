class Message {
  int id=0;
  String date="";
  String content="";
  bool fromMe=false;
  bool showTime = true;

  Message(int id, String content, bool fromMe, String date) {
    this.id = id;
    this.date = date;
    this.content = content;
    this.fromMe = fromMe;
  }

  Message.time(int id, String content, bool fromMe, bool showTime, String date) {
    this.id = id;
    this.date = date;
    this.content = content;
    this.fromMe = fromMe;
    this.showTime = showTime;
  }
}