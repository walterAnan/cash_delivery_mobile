
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'MyDrawer.dart';
import 'MyOrders.dart';
import 'SelectVehicle.dart';
class ManageVehicle extends StatefulWidget {
  @override
  _ManageVehicleState createState() => _ManageVehicleState();
}

class _ManageVehicleState extends State<ManageVehicle> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String vehicle;
  int index;
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return WillPopScope(
      onWillPop: (){
        return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context)=>MyOrders()
        ), (route) => false);
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: MyDrawer(title: "Manage Vehicle",),
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
                          child: Text("Manage Vehicle",
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

                Expanded(
                  child: Container(
                      child: LayoutBuilder(
                          builder: (BuildContext context,BoxConstraints viewportConstraints){
                            return ListView(
                              reverse: false,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(bottom: bottom),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        minHeight: viewportConstraints.maxHeight,
                                        maxHeight: viewportConstraints.maxHeight),
                                    child: Column(
                                      children: [
                                        //ListView
                                        Expanded(
                                          child: ListView(
                                            children: [
                                              SizedBox(height: 2,),
                                              //Vehicle Type
                                              InkWell(
                                                onTap: ()async{
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                          var  returnValue = await Navigator.push(context, SlidePageRoute(page: SelectVehicle(index: index,)));
                                                 setState(() {
                                                   vehicle = returnValue["vehicle"];
                                                   index = returnValue["index"];
                                                 });
                                                },
                                                child: Container(
                                                  height: 56,
                                                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              width: 1,
                                                              color: Theme.of(context).primaryTextTheme.headline3.color
                                                          )
                                                      )
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Positioned.directional(
                                                        textDirection: Directionality.of(context),
                                                        start: 0,
                                                        top: 8,
                                                        child: Container(
                                                          child: Text("Vehicle Type",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: 'medium',
                                                              color: Theme.of(context).textTheme.headline1.color
                                                            ),),
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        enabled: false,
                                                        decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          enabledBorder: InputBorder.none,
                                                          focusedBorder:InputBorder.none,
                                                          focusedErrorBorder: InputBorder.none,
                                                          errorBorder:  InputBorder.none,
                                                          disabledBorder: InputBorder.none,
                                                          contentPadding: EdgeInsets.only(top: 25),
                                                          hintText: vehicle==null?"Select Vehicle":vehicle,
                                                          hintStyle: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily: 'medium',
                                                            color: Theme.of(context).hintColor
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned.directional(
                                                          textDirection: Directionality.of(context),
                                                          end: -21,
                                                          top: 0,
                                                          bottom: 0,
                                                          child: Image.asset("assets/newIcons/ic_forward.png",scale: 5.3,)
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              //Manufacture
                                              Container(
                                                height: 56,
                                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color: Theme.of(context).primaryTextTheme.headline3.color
                                                        )
                                                    )
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned.directional(
                                                      textDirection: Directionality.of(context),
                                                      start: 0,
                                                      top: 8,
                                                      child: Container(
                                                        child: Text("Manufacture",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily: 'medium',
                                                              color: Theme.of(context).textTheme.headline1.color
                                                          ),),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        enabledBorder: InputBorder.none,
                                                        focusedBorder:InputBorder.none,
                                                        focusedErrorBorder: InputBorder.none,
                                                        errorBorder:  InputBorder.none,
                                                        disabledBorder: InputBorder.none,
                                                        contentPadding: EdgeInsets.only(top: 25),
                                                        hintText: "Enter Manufacture Company",
                                                        hintStyle: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: 'medium'
                                                        ),
                                                      ),
                                                      style:  TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: 'medium'
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //Model
                                              Container(
                                                height: 56,
                                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color: Theme.of(context).primaryTextTheme.headline3.color
                                                        )
                                                    )
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned.directional(
                                                      textDirection: Directionality.of(context),
                                                      start: 0,
                                                      top: 8,
                                                      child: Container(
                                                        child: Text("Model",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily: 'medium',
                                                              color: Theme.of(context).textTheme.headline1.color
                                                          ),),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        enabledBorder: InputBorder.none,
                                                        focusedBorder:InputBorder.none,
                                                        focusedErrorBorder: InputBorder.none,
                                                        errorBorder:  InputBorder.none,
                                                        disabledBorder: InputBorder.none,
                                                        contentPadding: EdgeInsets.only(top: 25),
                                                        hintText: "Enter Model Number",
                                                        hintStyle: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: 'medium'
                                                        ),
                                                      ),
                                                      style:  TextStyle(
                                                         fontSize: 13,
                                                          fontFamily: 'medium',
                                                          color: Theme.of(context).textTheme.headline1.color
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //Year
                                              Container(
                                                height: 56,
                                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color: Theme.of(context).primaryTextTheme.headline3.color
                                                        )
                                                    )
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned.directional(
                                                      textDirection: Directionality.of(context),
                                                      start: 0,
                                                      top: 8,
                                                      child: Container(
                                                        child: Text("Year",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily: 'medium',
                                                              color: Theme.of(context).textTheme.headline1.color
                                                          ),),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        enabledBorder: InputBorder.none,
                                                        focusedBorder:InputBorder.none,
                                                        focusedErrorBorder: InputBorder.none,
                                                        errorBorder:  InputBorder.none,
                                                        disabledBorder: InputBorder.none,
                                                        contentPadding: EdgeInsets.only(top: 25),
                                                        hintText: "Enter Year of Manufacture",
                                                        hintStyle: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: 'medium'
                                                        ),
                                                      ),
                                                      style:  TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: 'medium',
                                                          color: Theme.of(context).textTheme.headline1.color
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //License Plate
                                              Container(
                                                height: 56,
                                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color: Theme.of(context).primaryTextTheme.headline3.color
                                                        )
                                                    )
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned.directional(
                                                      textDirection: Directionality.of(context),
                                                      start: 0,
                                                      top: 8,
                                                      child: Container(
                                                        child: Text("License Plate",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily: 'medium',
                                                              color: Theme.of(context).textTheme.headline1.color
                                                          ),),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        enabledBorder: InputBorder.none,
                                                        focusedBorder:InputBorder.none,
                                                        focusedErrorBorder: InputBorder.none,
                                                        errorBorder:  InputBorder.none,
                                                        disabledBorder: InputBorder.none,
                                                        contentPadding: EdgeInsets.only(top: 25),
                                                        hintText: "Enter License Plate",
                                                        hintStyle: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: 'medium'
                                                        ),
                                                      ),
                                                      style:  TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: 'medium',
                                                          color: Theme.of(context).textTheme.headline1.color
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //Color
                                              Container(
                                                height: 54,
                                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color: Theme.of(context).primaryTextTheme.headline3.color
                                                        )
                                                    )
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned.directional(
                                                      textDirection: Directionality.of(context),
                                                      start: 0,
                                                      top: 8,
                                                      child: Container(
                                                        child: Text("Color",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily: 'medium',
                                                              color: Theme.of(context).textTheme.headline1.color
                                                          ),),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        enabledBorder: InputBorder.none,
                                                        focusedBorder:InputBorder.none,
                                                        focusedErrorBorder: InputBorder.none,
                                                        errorBorder:  InputBorder.none,
                                                        disabledBorder: InputBorder.none,
                                                        contentPadding: EdgeInsets.only(top: 25),
                                                        hintText: "Enter Vehical Color",
                                                        hintStyle: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: 'medium'
                                                        ),
                                                      ),
                                                      style:  TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: 'medium',
                                                          color: Theme.of(context).textTheme.headline1.color
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //Submit Button
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 18,vertical: 12),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: MaterialButton(
                                                  height: 44,
                                                  onPressed: () {
                                                    FocusScope.of(context).requestFocus(FocusNode());
                                                    //     Navigator.of(context).push(_verificationCodeScreenRoute());
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(2)
                                                  ),
                                                  color: Theme.of(context).accentTextTheme.headline1.color,
                                                  elevation: 0,
                                                  highlightElevation: 0,
                                                  child: Text(
                                                    "Submit",
                                                    style: TextStyle(
                                                        color: Theme.of(context).accentTextTheme.bodyText2.color,
                                                        fontSize: 14,
                                                        fontFamily: 'medium'
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })
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
