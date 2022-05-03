import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Account/ChangeEmail.dart';
import '../Account/ChangeNumber.dart';
import 'MyDrawer.dart';
import 'MyOrders.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'package:godelivery_rider/Ui/SelectCountry.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool isOnline = false;
  void toggle(){
    setState(() {
      isOnline=!isOnline;
    });
  }

  @override
  void initState() {
    initData();
  }

  var nom = '';
  var tel = '';
  var adress = '';
  var date = '';

  initData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom');
      tel = prefs.getString('tel');
      adress = prefs.getString('adress');
      date = prefs.getString('date');

    });
  }


  //
  File imageFile;
  openGallery() async{
    // ignore: deprecated_member_use
    var imagePicker = new ImagePicker();
    var picture = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = picture as File;
    });
  }
  var selected;
  var countryCode;
  String country;
  int index;
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: (){
        return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context)=>MyOrders()
        ), (route) => false);
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: MyDrawer(title: "Profile",),
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
                          child: Text("Profile",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'medium',
                              color: Theme.of(context).textTheme.headline1.color
                            ),),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15,),
                //Profile Scetion
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: <Widget>[
                      //Prof Img
                      InkWell(
                        onTap: (){
                          openGallery();
                        },
                        child: Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).textTheme.headline1.color
                              ),
                              color: Theme.of(context).textTheme.headline1.color
                          ),
                          child: Stack(
                            clipBehavior: Clip.none, fit: StackFit.expand,
                            children: [
                             Container(
                               height: 54,
                               width: 54,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                               ),
                               child: (imageFile == null)?
                               Container(
                                   decoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                     image: DecorationImage(
                                       fit: BoxFit.fill,
                                       image: AssetImage("assets/newIcons/ic_newProfile.png")
                                     )
                                   ),
                                   ):
                               Image.file(imageFile,fit: BoxFit.fill,),
                             ),
                              Positioned.directional(
                                textDirection: Directionality.of(context),
                                end: -1,
                                bottom: -1,
                                width: 15,
                                height: 15,
                                child:Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                        color: Theme.of(context).textTheme.headline1.color
                                    ),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage("assets/newIcons/ic_edit.png")
                                    )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 14,),
                      //Prof Name
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text("Nom",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'medium',
                                  height: 1.2,
                                    color: Theme.of(context).textTheme.headline1.color
                                ),),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(nom,
                                style: TextStyle(
                                    color: Theme.of(context).textTheme.headline3.color,
                                    fontSize: 13,
                                    fontFamily: 'medium'
                                ),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 42,),
                //ListView
                Expanded(
                  child: ListView(
                    children: [
                      //Phone Number
                      InkWell(
                        onTap: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => Profile(),
                          //       //settings: RouteSettings(name: '/profile')),
                          // );
                          // Navigator.push(context, SlidePageRoute(page: ChangeNumber(countryCode: countryCode,)));
                        },
                        child: Container(
                          height: 60,
                            padding: EdgeInsets.only(left: 18,right: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                      color: Theme.of(context).primaryTextTheme.headline3.color
                                  )
                              )
                            ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(
                                   child: Text("Téléphone",
                                   style: TextStyle(
                                    fontSize: 12,
                                     fontFamily: 'medium',
                                       color: Theme.of(context).textTheme.headline1.color
                                   ),),
                                 ),
                                 SizedBox(height: 5,),
                                 Container(
                                   child: Text(tel,
                                     style: TextStyle(
                                         color: Theme.of(context).textTheme.headline3.color,
                                         fontSize: 13,
                                         fontFamily: 'medium'
                                     ),),
                                 ),
                               ],
                             ),
                            ],
                          ),
                        ),
                      ),
                      //Email
                      InkWell(
                        // onTap: (){
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Profile(),
                        //         settings: RouteSettings(name: '/profile')),
                        //   );
                        //   Navigator.push(context, SlidePageRoute(page: ChangeEmail()));
                        // },
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.only(left: 18,right: 8),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Theme.of(context).primaryTextTheme.headline3.color
                                  )
                              )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text("Adresse",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'medium',
                                          color: Theme.of(context).textTheme.headline1.color
                                      ),),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    child: Text(adress,
                                      style: TextStyle(
                                          color: Theme.of(context).textTheme.headline3.color,
                                          fontSize: 13,
                                          fontFamily: 'medium'
                                      ),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Country
                      // InkWell(
                      //   onTap: ()async{
                      //   var returnVal = await  Navigator.push(context, SlidePageRoute(page: SelectCountry(index: index,)));
                      //   setState(() {
                      //    country = returnVal["country"];
                      //    countryCode = returnVal["c_code"];
                      //    index = returnVal["index"];
                      //   });
                      //   },
                      //   child: Container(
                      //     height: 60,
                      //     padding: EdgeInsets.only(left: 18,right: 8),
                      //     decoration: BoxDecoration(
                      //         border: Border(
                      //             bottom: BorderSide(
                      //                 width: 1,
                      //                 color: Theme.of(context).primaryTextTheme.headline3.color
                      //             )
                      //         )
                      //     ),
                      //     child: Stack(
                      //       clipBehavior: Clip.none, fit: StackFit.expand,
                      //       children: [
                      //         Positioned.directional(
                      //           textDirection: Directionality.of(context),
                      //           start: 0,
                      //           top: 0,
                      //           bottom: 0,
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Container(
                      //                 child: Text("Country",
                      //                   style: TextStyle(
                      //                       fontSize: 12,
                      //                       fontFamily: 'medium',
                      //                       color: Theme.of(context).textTheme.headline1.color
                      //                   ),),
                      //               ),
                      //               SizedBox(height: 5,),
                      //               Container(
                      //                 child: Text(country==null?"Select Country":country,
                      //                   style: TextStyle(
                      //                       color: Theme.of(context).textTheme.headline3.color,
                      //                       fontSize: 13,
                      //                       fontFamily: 'medium'
                      //                   ),),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         Positioned.directional(
                      //           textDirection: Directionality.of(context),
                      //           end: 0,
                      //           top: 0,
                      //           bottom: 0,
                      //           child: Container(
                      //             alignment: Alignment.center,
                      //             padding: EdgeInsets.only(left: 8,right: 8,),
                      //             child: Text("Change",
                      //               style: TextStyle(
                      //                   color: Theme.of(context).accentTextTheme.headline1.color,
                      //                   fontSize: 12,
                      //                   fontFamily: 'medium'
                      //               ),),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // //Online Status
                      // InkWell(
                      //   onTap: (){
                      //     toggle();
                      //   },
                      //   child: Container(
                      //     height: 60,
                      //     padding: EdgeInsets.only(left: 18,right: 7),
                      //     decoration: BoxDecoration(
                      //         border: Border(
                      //             bottom: BorderSide(
                      //                 width: 1,
                      //                 color: Theme.of(context).primaryTextTheme.headline3.color
                      //             )
                      //         )
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Container(
                      //               child: Text("Online Status",
                      //                 style: TextStyle(
                      //                     fontSize: 12,
                      //                     fontFamily: 'medium',
                      //                     color: Theme.of(context).textTheme.headline1.color
                      //                 ),),
                      //             ),
                      //             SizedBox(height: 5,),
                      //             Container(
                      //               child: Text(isOnline?"Online":"Offline",
                      //                 style: TextStyle(
                      //                     color: Theme.of(context).textTheme.headline3.color,
                      //                     fontSize: 13,
                      //                     fontFamily: 'medium'
                      //                 ),),
                      //             ),
                      //           ],
                      //         ),
                      //         Container(
                      //           margin: EdgeInsets.only(left: 2),
                      //           padding: EdgeInsets.all(10),
                      //           child: isOnline?Image.asset("assets/newIcons/ic_switchOn.png",scale: 3,):
                      //           Image.asset("assets/newIcons/ic_switchOff.png",scale: 3,)
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // //Member Since
                      // Container(
                      //   height: 60,
                      //   padding: EdgeInsets.only(left: 18,right: 8),
                      //   decoration: BoxDecoration(
                      //       border: Border(
                      //           bottom: BorderSide(
                      //               width: 1,
                      //               color: Theme.of(context).primaryTextTheme.headline3.color
                      //           )
                      //       )
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Container(
                      //             child: Text("Employé depuis...",
                      //               style: TextStyle(
                      //                   fontSize: 12,
                      //                   fontFamily: 'medium',
                      //                   color: Theme.of(context).textTheme.headline1.color
                      //
                      //               ),),
                      //           ),
                      //           SizedBox(height: 5,),
                      //           Container(
                      //             child: Text(date,
                      //               style: TextStyle(
                      //                   color: Theme.of(context).textTheme.headline3.color,
                      //                   fontSize: 13,
                      //                   fontFamily: 'medium'
                      //               ),),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
