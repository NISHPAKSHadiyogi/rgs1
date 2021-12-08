import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ConnectivityProvider with ChangeNotifier{
  Connectivity _connectivity =new Connectivity();
  late bool _isOnline;
  bool get isOnline =>_isOnline;
  startMonitoring()async{
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen((status)async {
      if(status==ConnectivityResult.none){
        _isOnline =false;
        notifyListeners();
      }else if(status == ConnectivityResult.mobile){
        await _updateConnection().then((bool value)  {
          _isOnline = value;
          notifyListeners();
        });

      }else if(status == ConnectivityResult.wifi){
        await _updateConnection().then((bool value)  {
          _isOnline = value;
          notifyListeners();
        });
      }
    });
  }
  Future<void> initConnectivity()async{
    try{
      var status= await _connectivity.checkConnectivity();
      if(status==ConnectivityResult.none){
        _isOnline =false;
        notifyListeners();
      }else if(status == ConnectivityResult.mobile){
        _isOnline =true;
        notifyListeners();
      }else if(status == ConnectivityResult.wifi){
        _isOnline =true;
        notifyListeners();
      }
    }on PlatformException catch(e){
      print(e);
    }
  }
  Future<bool>_updateConnection()async{
    bool isConnected=false;
    try{
      final List<InternetAddress> result=await InternetAddress.lookup("google.com");
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        isConnected =true;
      }
    }on SocketException catch(e){
      isConnected =false;
      print(e);
    }
    return isConnected;
  }
}