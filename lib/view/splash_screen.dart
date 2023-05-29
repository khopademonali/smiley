import 'package:flutter/material.dart';
import 'package:smiley/view/favourite_jokes.dart';
import 'package:smiley/view/joke_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(""),),
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(  //upper clippath with less height
                clipper:WaveClipper(), //set our custom wave clipper.
                child:Container(
                  padding: EdgeInsets.only(bottom: 50),
                  color:Colors.cyan[100],
                  height:350,
                  alignment: Alignment.center,
                ),
              ),
              ClipPath(  //upper clippath with less height
                clipper:WaveClipper2(), //set our custom wave clipper.
                child:Container(
                  padding: EdgeInsets.only(bottom: 50),
                  color:Colors.cyan[200],
                  height:450,
                  alignment: Alignment.center,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    var path = new Path();
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 1);
    var firstStart = Offset(size.width * 0.25, size.height *1);
    var firstEnd = Offset(size.width * 0.55, size.height * 0.6);
    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart = Offset(size.width * 0.8, size.height *0.6);
    var secondEnd = Offset(size.width * 0.9, size.height * 0.65);
    path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, size.height * 0.68);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}

class WaveClipper2 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    var path = new Path();
    path.moveTo(0, size.height-10);
    path.lineTo(0, size.height * 1);
    var firstStart = Offset(size.width * 0.25, size.height *0.5);
    var firstEnd = Offset(size.width * 0.65, size.height * 0.6);
    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart = Offset(size.width * 0.8, size.height *0.3);
    var secondEnd = Offset(size.width * 0.9, size.height * 0.35);
    path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, size.height * 0.36);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}