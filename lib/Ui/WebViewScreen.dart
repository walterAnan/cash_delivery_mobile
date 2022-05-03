import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:godelivery_rider/Ui/CheckInternet.dart';
import 'dart:async';
import 'package:data_connection_checker/data_connection_checker.dart';

// ignore: must_be_immutable
class WebViewScreen extends StatefulWidget {
  String title;
  WebViewScreen({this.title});
  @override
  _WebViewScreenState createState() => _WebViewScreenState(title: title);
}

class _WebViewScreenState extends State<WebViewScreen> {
  String title;
  _WebViewScreenState({this.title});

  //webView
  Widget webViwScreen() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          //Appbar
          Container(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                //back btn
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  start: 4,
                  top: 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/newIcons/ic_back.png",
                        width: 15,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                ),
                //Center Widget
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  top: 0,
                  bottom: 0,
                  start: 0,
                  end: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      title==null?"":title,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'medium',
                        color: Theme.of(context).textTheme.headline1.color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: WebView(
              initialUrl: 'https://envato.com/privacy/',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          )
        ],
      ),
    );
  }

  StreamSubscription<DataConnectionStatus> listener;
  Widget intWidget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _updateConnectionStatus();
    checkInternet();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listener.cancel();
    super.dispose();
  }

   checkInternet() async {
    // actively listen for status updates
    listener =  DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          intWidget = webViwScreen();
          print('Data connection is available.');
          setState(() {});
          break;
        case DataConnectionStatus.disconnected:
          intWidget = NoInternetScreen();
          print('You are disconnected from the internet.');
          setState(() {});
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
//    await Future.delayed(Duration(seconds: 30));
//    await listener.cancel();
    return await DataConnectionChecker().connectionStatus;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: //WebView
            intWidget == null
                ? Center(
                    child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    backgroundColor: Colors.black,
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                  ))
                : intWidget,
      ),
    );
  }
}
