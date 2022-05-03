
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:godelivery_rider/Theme/DarkThemeProvider.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Account/ChangePassword.dart';
import 'MyDrawer.dart';
import 'MyOrders.dart';
import 'SelectLanguage.dart';
import 'WebViewScreen.dart';
class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  //Open gmail App
  _sendMail() async {
    // Android and iOS
    const uri =
        'mailto:suppprt@gmail.com.org?';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
   //
  String langVal;
  int index;
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    setState(() {
      isSwitched = themeChange.darkTheme;
    });
    return WillPopScope(
      onWillPop: (){
        return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context)=>MyOrders()
        ), (route) => false);
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: MyDrawer(title: "Parmètres",),
          body: Container(
            child: Column(
              children: [
                //AppBar
                Container(
                  height: 50,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      //back bt
                      Positioned.directional(
                        textDirection: Directionality.of(context),
                        top: 0,
                        bottom: 0,
                        start: 7,
                        child: InkWell(
                          onTap: (){
                            _scaffoldKey.currentState.openDrawer();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: new Image.asset("assets/newIcons/ic_menu.png",width: 25,
                            color: Theme.of(context).iconTheme.color,),
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
                          child: Text("Paramètres",
                            style: TextStyle(
                             fontSize: 14,
                              fontFamily: 'medium',
                              color: Theme.of(context).textTheme.headline1.color,
                            ),),
                        ),
                      ),
                    ],
                  ),
                ),
                //Dark Mode
                // InkWell(
                //   onTap: (){
                //     setState(() {
                //       isSwitched = !isSwitched;
                //       themeChange.darkTheme = isSwitched;
                //     });
                //   },
                //   child: Container(
                //     height: 60,
                //     padding: EdgeInsets.only(left: 18,right: 7),
                //     decoration: BoxDecoration(
                //       border: Border(
                //         bottom: BorderSide(
                //           width: 1,
                //           color: Theme.of(context).primaryTextTheme.headline3.color,
                //         )
                //       )
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         //Dark Mode
                //         Container(
                //           child: Text("Dark Mode",
                //           style: TextStyle(
                //             fontSize: 13,
                //             fontFamily: "medium",
                //             color: Theme.of(context).textTheme.headline1.color,
                //           ),),
                //         ),
                //         //toggle Icon
                //         Container(
                //             margin: EdgeInsets.only(left: 2),
                //             padding: EdgeInsets.all(10),
                //             child: isSwitched
                //                 ?
                //             Image.asset(
                //               "assets/newIcons/ic_switchOn.png", scale: 3,):
                //             Image.asset(
                //               "assets/newIcons/ic_switchOff.png", scale: 3,)
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                //Change Password
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(SlidePageRoute(page: ChangePassword()));
                  },
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 18,right: 7),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                              color: Theme.of(context).primaryTextTheme.headline3.color,
                            )
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Change Password
                        Container(
                          child: Text("Changer son Code Secret",
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: "medium",
                              color: Theme.of(context).textTheme.headline1.color,
                            ),),
                        ),
                        //toggle Icon
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/newIcons/ic_forward.png",scale: 5.3,),
                        )
                      ],
                    ),
                  ),
                ),
                //Privacy Policy
                InkWell(
                  onTap: (){
                    Navigator.push(context, SlidePageRoute(page: WebViewScreen(title: "Privacy Policy",)));
                  },
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 18,right: 7),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                              color: Theme.of(context).primaryTextTheme.headline3.color,
                            )
                        )
                    ),
                    child: Row(
                      children: [
                        //Privacy Policy
                        Container(
                          child: Text("Politiques de confidentialité",
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: "medium",
                              color: Theme.of(context).textTheme.headline1.color,
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),
                //Terms & Condition
                InkWell(
                  onTap: (){
                    Navigator.push(context, SlidePageRoute(page: WebViewScreen(title: "Terms & Condition",)));
                  },
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 18,right: 7),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                              color: Theme.of(context).primaryTextTheme.headline3.color,
                            )
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Terms & Condition
                        Container(
                          child: Text("Termes et Conditions",
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: "medium",
                              color: Theme.of(context).textTheme.headline1.color,
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),
                //Contact Us
                InkWell(
                  onTap: _sendMail,
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 18,right: 8,top: 5,bottom: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                              color: Theme.of(context).primaryTextTheme.headline3.color,
                            )
                        )
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text("Contactez nous",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'medium',
                                  color: Theme.of(context).textTheme.headline1.color,
                                ),),
                            ),
                            Container(
                              child: Text("benjamin.kamana@ventis.group",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'medium',
                                  color: Theme.of(context).textTheme.headline3.color,
                                ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //Change Language
                // InkWell(
                //   onTap: ()async{
                //   var   returnVal = await  Navigator.push(context, SlidePageRoute(page: SelectLanguage(index: index,)));
                //   langVal = returnVal["langVal"];
                //   index = returnVal["index"];
                //   },
                //   child: Container(
                //     height: 60,
                //     padding: EdgeInsets.only(left: 18,right: 8,top: 5,bottom: 5),
                //     decoration: BoxDecoration(
                //         border: Border(
                //             bottom: BorderSide(
                //                 width: 1,
                //               color: Theme.of(context).primaryTextTheme.headline3.color,
                //             )
                //         )
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             Container(
                //               child: Text("Change Language",
                //                 style: TextStyle(
                //                     fontSize: 13,
                //                     fontFamily: 'medium',
                //                   color: Theme.of(context).textTheme.headline1.color,
                //                 ),),
                //             ),
                //             Container(
                //               child: Text(langVal==null?"English":langVal,
                //                 style: TextStyle(
                //                     fontSize: 13,
                //                     fontFamily: 'medium',
                //                   color: Theme.of(context).textTheme.headline3.color,
                //                 ),),
                //             ),
                //           ],
                //         ),
                //         Container(
                //           padding: EdgeInsets.all(10),
                //           child: Text("Change",
                //             style: TextStyle(
                //                 color: Theme.of(context).accentTextTheme.headline1.color,
                //                 fontSize: 13,
                //                 fontFamily: 'medium'
                //             ),),
                //         )
                //       ],
                //     ),
                //   ),
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
