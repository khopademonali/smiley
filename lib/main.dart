import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:smiley/view/home_screen.dart';
import 'package:smiley/view/no_internet_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  Stream<ConnectivityResult> connectivityStream = Connectivity().onConnectivityChanged;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.cyan
        ),
        primaryColor: Color(0xFF4DD0E1),
        primaryColorDark: Color(0xFF4DD0E1),
        primaryColorLight: Color(0xFF00ACC1),
      ),
      home: HomeScreen(),
      builder: (context, child) {
        return StreamBuilder<ConnectivityResult>(
            stream: connectivityStream,
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const CircularProgressIndicator();
              }
              else if(snapshot.connectionState==ConnectionState.active
                  || snapshot.connectionState==ConnectionState.done){
                var connectivityResult = snapshot.data;
                if (connectivityResult == ConnectivityResult.none ||
                    connectivityResult == null) {
                  return NoInternetActionScreen();
                }
                // else
                  return child!;
              }
              return child!;
            }
        );
      },
    );
  }
}

