
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:godelivery_rider/Tabs/DeliveredTabPage.dart';
import 'package:godelivery_rider/Tabs/NewTabPage.dart';
import 'package:godelivery_rider/Tabs/ProcessingTabPage.dart';

import 'MyDrawer.dart';
class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> with SingleTickerProviderStateMixin{
  TabController tb;
  @override
  void initState() {
    super.initState();
    tb=TabController(length: 3, vsync: this);
    tb.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
    });
  }

  //


  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: MyDrawer(title: "Home",),
          body: Container(
            padding: EdgeInsets.only(bottom: 12),
            child: Stack(
              children: [
                Container(
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
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
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
                                child: Text("Mes Livraisons",
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
                      SizedBox(height: 5,),
                      //TabBar
                      Container(
                        height: 30,
                        padding: EdgeInsets.only(left: 9,right: 9),
                        child: TabBar(
                          unselectedLabelColor: Theme.of(context).accentTextTheme.bodyText1.color,
                          indicatorWeight: 0.1,
                          indicatorSize: TabBarIndicatorSize.tab,
                        dragStartBehavior: DragStartBehavior.start,
                          labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        //  isScrollable: true,

                          tabs: [
                            Tab(
                              child: tabItem(0,"Nouvelles")
                            ),
                            Tab(
                              child: tabItem(1,"En cours")
                            ),
                            Tab(
                              child: tabItem(2,"Effectuée")
                            ),
                          ],
                          controller: tb,
                        ),
                      ),
                      //Tababar View
                      SizedBox(height: 7),
                      Expanded(
                        child: Container(
                          child: TabBarView(
                            physics: ClampingScrollPhysics(),
                            children: [
                              NewTabPage(),
                              ProcessingTabPage(),
                              DeliveredTabPage()
                            ],
                            controller: tb,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //Floating Action Button
                /*Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 5,
                  bottom: 25,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 18.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, SlidePageRoute(page: Chat()));
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentTextTheme.headline1.color,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/newIcons/ic_chat.png",)
                            )
                        ),
                      ),
                    ),
                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
  Container tabItem(int index,String title){
    double width = MediaQuery.of(context).size.width;
    double tabWidth = width/3;
    return Container(
      width: tabWidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: tb.index == index
              ? Colors.green
              : Theme.of(context).primaryTextTheme.headline5.color
      ),
      child: Text(title,
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'medium',
        ),),
    );
  }
}