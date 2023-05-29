import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NoInternetActionScreen extends StatefulWidget {
  const NoInternetActionScreen({Key? key}) : super(key: key);

  @override
  _NoInternetActionScreenState createState() => _NoInternetActionScreenState();
}

class _NoInternetActionScreenState extends State<NoInternetActionScreen> {
  bool _isInAsyncCall = false;
  bool _isTap = false;
  static ValueNotifier<bool> connectionCheck = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No Internet Connection",),
              const Spacer(),
              Container(
                  height: size.height * 0.2,
                  child: Center(
                      child: Image.asset(
                          'assets/noInternet.png'))),
              const Spacer(),
              Text("No Internet Connection found",),
              Text("Please check your connection",),
              const Spacer(),
              Center(
                child: _isTap?CircularProgressIndicator():
                ElevatedButton(
                  onPressed: _isInAsyncCall?null:() {
                    setState(() {
                      _isTap=false;
                      _isInAsyncCall = true;
                      startTimer();
                    });
                    checkNetworkConnectivity().then((value){
                      setState(() {
                        _isTap=true;
                        _isInAsyncCall = false;
                      });
                    });

                  },
                  child: Text("Try Again"),
                ),
              ),

            ],
          )
      ),
    );
  }
  void startTimer() {
    Timer.periodic(const Duration(seconds: 2), (t) {
      setState(() {
        _isTap = false; //set loading to false
      });
      t.cancel(); //stops the timer
    });
  }

  Future checkNetworkConnectivity()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.

      connectionCheck.value = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      connectionCheck.value = true;
    }
    else if(connectivityResult == ConnectivityResult.none){
      connectionCheck.value = false;
    }
    return connectionCheck;
  }
}
