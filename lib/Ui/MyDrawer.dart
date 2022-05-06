import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Account/Login.dart';
import 'Documents.dart';
import 'GetStarted.dart';
import 'History.dart';
import 'ManageVehicle.dart';
import 'MyOrders.dart';
import 'Profile.dart';
import 'Setting.dart';
// ignore: must_be_immutable


class MyDrawer extends StatefulWidget {
  String title;
  MyDrawer({this.title});

  @override
  _MyDrawerState createState() => _MyDrawerState(title: title);
}

class _MyDrawerState extends State<MyDrawer> {
  String title;
  _MyDrawerState({this.title});


  @override
  void initState() {
    initData();
  }

  var nom = '';

  initData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.6,
      child: Drawer(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 25,),
              //Profile Scetion
              InkWell(
                  onTap: () {
                    if (title == "Profile") {
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        SlidePageRoute(page: Profile()));
                    }
                  },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      //Prof Img
                      Container(
                        height: 49,
                        width: 49,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).accentTextTheme.bodyText1.color
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/newIcons/ic_newProfile.png")
                          )
                        ),
                        child: Stack(
                          children: [
                            Positioned.directional(
                              textDirection: Directionality.of(context),
                              end: 1.5,
                              bottom: 1,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).accentTextTheme.bodyText2.color
                                  ),
                                    color: Theme.of(context).textTheme.headline3.color,
                                  shape: BoxShape.circle
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(width: 10,),
                      //Prof Name
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 3,),
                            Container(
                              child: Text(nom,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'medium',
                                color: Theme.of(context).textTheme.headline1.color,
                              ),),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32,),
              //items
              Container(
                child: Column(
                  children: [
                    //Home
                    InkWell(
                      onTap: (){
                        if(title=="Home"){
                          Navigator.pop(context);
                        }else {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (context) => MyOrders()
                          ), (route) => false);
                        }
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 20),
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
                            Image.asset("assets/newIcons/ic_home.png",scale: 5,
                              color: Theme.of(context).iconTheme.color,),
                            SizedBox(width: 8,),
                            Container(
                              child: Text("Accueil",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'medium',
                                  color: Theme.of(context).textTheme.headline1.color,
                                ),),
                            )
                          ],
                        ),
                      ),
                    ),
                    //My profile
                    InkWell(
                      onTap: (){
                        if(title=="Profile"){
                          Navigator.pop(context);
                        }else {
                          Navigator.pop(context);
                          Navigator.of(context).push(SlidePageRoute(page: Profile()));
                        }
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 20),
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
                            Image.asset("assets/newIcons/ic_profile.png",scale: 5,
                              color: Theme.of(context).iconTheme.color,),
                            SizedBox(width: 8,),
                            Container(
                              child: Text("Mon Profile",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'medium',
                                color: Theme.of(context).textTheme.headline1.color,
                              ),),
                            )
                          ],
                        ),
                      ),
                    ),
                    //Manage Vehicle
                    //Documents
                    //History
                    InkWell(
                      onTap: (){
                        if(title=="History"){
                          Navigator.pop(context);
                        }else {
                          Navigator.pop(context);
                          Navigator.of(context).push(SlidePageRoute(page: History()));
                        }
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 20),
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
                            Image.asset("assets/newIcons/ic_history.png",scale: 5,
                              color: Theme.of(context).iconTheme.color,),
                            SizedBox(width: 8,),
                            Container(
                              child: Text("Historique",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'medium',
                                  color: Theme.of(context).textTheme.headline1.color,
                                ),),
                            )
                          ],
                        ),
                      ),
                    ),
                    //Setting
                    InkWell(
                      onTap: (){
                        if(title=="Paramètres"){
                          Navigator.pop(context);
                        }else {
                          Navigator.pop(context);
                          Navigator.of(context).push(SlidePageRoute(page: Setting()));
                        }
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 20),
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
                            Image.asset("assets/newIcons/ic_setting.png",scale: 5,
                              color: Theme.of(context).iconTheme.color,),
                            SizedBox(width: 8,),
                            Container(
                              child: Text("Paramètres",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'medium',
                                  color: Theme.of(context).textTheme.headline1.color,
                                ),),
                            )
                          ],
                        ),
                      ),
                    ),
                    //Logout
                    InkWell(
                      onTap: (){
                        _logout();
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 20),
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
                            Image.asset("assets/newIcons/ic_logout.png",scale: 5,
                              color: Theme.of(context).iconTheme.color,),
                            SizedBox(width: 8,),
                            Container(
                              child: Text("Déconnexion",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'medium',
                                  color: Theme.of(context).textTheme.headline1.color,
                                ),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Version
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(bottom: 25),
                  alignment: Alignment.bottomCenter,
                  child: Text("V 1.0",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'medium',
                    color: Theme.of(context).textTheme.headline3.color,
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Logout dialouge
  void _logout() {
    showDialog(
        context: context,
      builder: (BuildContext ctx){
      return   Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2)
        ),
        child: Container(
          height: 95,
          padding: EdgeInsets.only(left: 20,right: 16,top: 15,bottom: 9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Container(
               alignment: Alignment.centerLeft,
               child: Text("Êtes-vous Sûr de quitter?",
               style: TextStyle(
                 fontSize: 14,
                 fontFamily: "medium",
                 color: Theme.of(context).textTheme.headline1.color,
               ),),
             ) ,
              //CANCEL AND LOGOUT BUTTON
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                      Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text("ANNULER",
                        style: TextStyle(
                        color: Theme.of(context).accentTextTheme.headline1.color,
                          fontSize: 13,
                          fontFamily: "medium"
                        ),),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.remove('tel');
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (context)=>Login()
                        ), (route) => false);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text("DECONNECTER",
                          style: TextStyle(
                              color: Theme.of(context).accentTextTheme.headline1.color,
                              fontSize: 13,
                              fontFamily: "medium"
                          ),),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
      },
    );
  }
}
