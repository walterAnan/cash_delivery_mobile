import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MyOrders.dart';
class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(
        seconds: 1
    ),(){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (BuildContext context)=>MyOrders()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/newIcons/ic_location.png",scale: 2.1,),
                SizedBox(height: 24,),
                //Enable Your Location
                Container(
                  child: Text("Enable Your Location",
                  style: TextStyle(
                   fontSize: 14,
                    fontFamily: 'medium',
                    color: Theme.of(context).textTheme.headline1.color,
                  ),),
                ),
                SizedBox(height: 10,),
                //Choose Your Location
                Container(
                  child: Text("Choose your location to start find the\n"
                      "request around you.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline3.color,
                        fontSize: 13,
                        fontFamily: 'medium'
                    ),),
                ),
                SizedBox(height: 18,),
                //Enable Location
                Container(
                  child: Text("Enable Location",
                    style: TextStyle(
                        color: Theme.of(context).accentTextTheme.headline1.color,
                        fontSize: 14,
                        fontFamily: 'medium'
                    ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
