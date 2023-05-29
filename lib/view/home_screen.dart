import 'package:flutter/material.dart';
import 'package:smiley/view/favourite_jokes.dart';
import 'package:smiley/view/joke_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(""),),
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Stack(children: <Widget>[ //stack overlaps widgets
              Opacity( //semi red clippath with more height and with 0.5 opacity
                opacity: 0.5,
                child: ClipPath(
                  clipper:WaveClipper(heightVal: 0.15), //set our custom wave clipper
                  child:Container(
                    color:Colors.cyan[100],
                    height:240,
                  ),
                ),
              ),

              ClipPath(  //upper clippath with less height
                clipper:WaveClipper(heightVal: 0.07), //set our custom wave clipper.
                child:Container(
                  padding: EdgeInsets.only(bottom: 50),
                  color:Colors.cyan[200],
                  height:200,
                  alignment: Alignment.center,
                ),
              ),
              ClipPath(  //upper clippath with less height
                clipper:WaveClipper(heightVal: 0.01), //set our custom wave clipper.
                child:Container(
                  padding: EdgeInsets.only(bottom: 50),
                  color:Colors.cyan,
                  height:150,
                  alignment: Alignment.center,
                ),
              ),
            ],),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                ClipPath(  //upper clippath with less height
                  clipper:BottomWaveClipper(heightVal: 100), //set our custom wave clipper.
                  child:Container(
                    padding: EdgeInsets.only(top: 50),
                    color:Colors.cyan[100],
                    height:120,
                    alignment: Alignment.center,
                  ),
                ),
                ClipPath(  //upper clippath with less height
                  clipper:BottomWaveClipper(heightVal: 60), //set our custom wave clipper.
                  child:Container(
                    padding: EdgeInsets.only(top: 50),
                    color:Colors.cyan[200],
                    height:170,
                    alignment: Alignment.center,
                  ),
                ),
                ClipPath(  //upper clippath with less height
                  clipper:BottomWaveClipper(heightVal: 40), //set our custom wave clipper.
                  child:Container(
                    padding: EdgeInsets.only(top: 50),
                    color:Colors.cyan,
                    height:230,
                    alignment: Alignment.center,
                  ),
                ),


              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Icon(Icons.mic,size: 85,),
                Text("Me: Siri tell me a joke",style: TextStyle(fontSize: 30),),
                Text("Siri: 'turn on front\nfacing camera'",style: TextStyle(fontSize: 30),),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.amberAccent),
                      ),
                      height: 70,
                      width: 70,
                      child:
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>JokePage()));

                      },
                          icon: Icon(Icons.home,size: 50,color: Colors.amberAccent,)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red),
                      ),
                      height: 70,
                      width: 70,
                      child:
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FavouriteJokes()));

                      },
                          icon: Icon(Icons.favorite_border,size: 50,color: Colors.red,)),
                    ),
                  ],
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}


class WaveClipper extends CustomClipper<Path>{
  double heightVal;
  WaveClipper({required this.heightVal});
  @override
  Path getClip(Size size) {

    var path = new Path();
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 1);
    var firstStart = Offset(size.width * 0.45, size.height * heightVal);
    var firstEnd = Offset(size.width, size.height * 1);
    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    path.lineTo(size.width, size.height * 1);
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

class BottomWaveClipper extends CustomClipper<Path>{
  double heightVal;
  BottomWaveClipper({required this.heightVal});
  @override
  Path getClip(Size size) {

    var path = new Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.4);
    var firstStart = Offset(size.width * 0.55, size.height-1);
    var firstEnd = Offset(size.width, size.height* 0.4);
    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    path.lineTo(size.width, size.height * 0.4);
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
