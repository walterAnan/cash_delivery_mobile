
import 'package:flutter/material.dart';

class NoInternetScreen extends StatefulWidget {
  @override
  _NoInternetScreenState createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/newIcons/ic_wifi.png",scale: 2.1,),
                SizedBox(height: 24,),
                //No Internet Connection
                Container(
                  child: Text("No Internet Connection",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'medium',
                      color: Theme.of(context).textTheme.headline1.color
                    ),),
                ),
                SizedBox(height: 10,),
                //Make sure ...........
                Container(
                  child: Text("Make sure your Wifi or data in enable\n"
                      "Turn on mobile data or Wifi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline3.color,
                        fontSize: 13,
                        fontFamily: 'medium'
                    ),),
                ),
                SizedBox(height: 18,),
                //Try Again
                Container(
                  child: Text("Try Again",
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
