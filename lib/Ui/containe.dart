
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MyDrawer.dart';
import 'MyOrders.dart';
import 'OrderDetails.dart';
import 'package:http/http.dart' as http;


class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}



class _HistoryState extends State<History> {
  String orderDeliveredSuccessfully= "Order Delivered Successfully";
  bool bothButtonsInvisible=false;
  List users = [];
  bool isLoading = false;

  @override
  void initState() {
    initData();
  }

  void initData() async{
    final prefs = await SharedPreferences.getInstance();

    var agentCode = prefs.getString('agent_agent');
    print('ok' + agentCode);
    var agentId = prefs.getInt('agent_id');
    var id = agentId.toString();
    var uri = Uri.parse('https://bocashdelivery.ventis.group/api/historique_livraison', ).replace(queryParameters: {'agent_livreur_id': id});
    var response = await http.get(uri);
    print(response.body);
    if(response.statusCode == 200){
      var items = json.decode(response.body)['list_livraison'];
      setState(() {
        users = items;
        isLoading = false;
      });
    }else{
      users = [];
      isLoading = false;
    };
  }

  //Recent Orders Details
  Widget _recentOrderDetails(context){
    return ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        physics: ClampingScrollPhysics(),
    itemBuilder: (BuildContext ctxt, int index) {
    return new Container(
    padding : EdgeInsets.symmetric(vertical: 5,horizontal: 18),
    child: InkWell(
    onTap: (){
    Navigator.of(context).push(SlidePageRoute(page: OrderDetails(orderDeliveredSuccessfully: orderDeliveredSuccessfully,)));
    },
    child: Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5)
    ),
    child: Container(
    padding: EdgeInsets.only(top: 10,bottom: 10),
    child: Column(
    children: [
    //1st Row
    Container(
    padding: EdgeInsets.only(left: 16,),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Container(
    child: Text("Order",
    style: TextStyle(
    fontFamily: 'medium',
    fontSize: 14,
    color: Theme.of(context).textTheme.headline1.color,
    ),
    ),
    ),
    Container(
    padding: EdgeInsets.symmetric(horizontal: 2,vertical: 2),
    decoration: BoxDecoration(
    color: Theme.of(context).accentTextTheme.headline2.color,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(50),
    bottomLeft: Radius.circular(50)
    )
    ),
    child: Row(
    children: [
    Container(
    padding: EdgeInsets.only(left: 4),
    child: Image.asset("assets/newIcons/ic_delivered.png",scale: 8.3,)),
    Container(
    child: Text("Livrée !!!",
    style: TextStyle(
    color: Theme.of(context).accentTextTheme.bodyText2.color,
    fontFamily: 'medium',
    fontSize: 10,
    ),
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    //Deliverd

    //2nd Row
    Container(
    padding: EdgeInsets.only(top: 6,left: 16,right: 16),
    child: Row(
    children: [
    Container(
    child: Text("Name: ",
    style: TextStyle(
    fontFamily: 'medium',
    fontSize: 12,
    color: Theme.of(context).textTheme.headline1.color,
    ),
    ),
    ),
    Container(
    child: Text("John Doe",
    style: TextStyle(
    color: Theme.of(context).textTheme.headline3.color,
    fontFamily: 'medium',
    fontSize: 12,
    ),
    ),
    )
    ],
    ),
    ),
    //3rd Row
    Container(
    padding: EdgeInsets.only(top: 10,left: 16,right: 16),
    child: Row(
    children: [
    Container(
    child: Text("Delivery Time:",
    style: TextStyle(
    fontFamily: 'medium',
    fontSize: 12,
    color: Theme.of(context).textTheme.headline1.color,
    ),
    ),
    ),
    Container(
    child: Text(" 10 June 3 Pm",
    style: TextStyle(
    color: Theme.of(context).textTheme.headline3.color,
    fontFamily: 'medium',
    fontSize: 12,
    ),
    ),
    )
    ],
    ),
    ),
    //4th Row
    Container(
    padding: EdgeInsets.only(top: 10,left: 16,right: 16),
    child: Row(
    children: [
    Container(
    child: Text("Pickup Location:",
    style: TextStyle(
    fontFamily: 'medium',
    fontSize: 12,
    color: Theme.of(context).textTheme.headline1.color,
    ),
    ),
    ),
    Container(
    width: MediaQuery.of(context).size.width*0.5-2,
    child: Text(" 781 Eastern Pkwy, Brooklyn Ny ...",
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
    color: Theme.of(context).textTheme.headline3.color,
    fontFamily: 'medium',
    fontSize: 12,
    ),
    ),
    )
    ],
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    );
    }
    );
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
          drawer: MyDrawer(title: "History",),
          body: Container(
            padding: EdgeInsets.only(bottom: 12),
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
                          child: Text("Histor",
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
                //Total Earning & Completed Orders
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      SizedBox(height: 4,),
                      //Total Earning & Completed Orders
                      _totalEarningNCompletedOrders(context),
                      //Recent Orders
                      Container(
                        padding: EdgeInsets.only(left: 18,top: 10),
                        child: Text("Les Livraisons les plus récesntes",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'medium',
                            color: Theme.of(context).textTheme.headline1.color,
                          ),),
                      ),
                      //ListView
                      //Recent Orders Details
                      _recentOrderDetails(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Total Earning & Completed Orders
Widget _totalEarningNCompletedOrders(context){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 18.0),
    child: Row(
      children: [
        //Total Earnings
        Expanded(
          child: Container(
            height: 162,
            decoration: BoxDecoration(
              color: Theme.of(context).accentTextTheme.headline4.color,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                //1st Row
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  start: 8,
                  top: 12,
                  child: Container(
                    child: Image.asset("assets/newIcons/ic_dollars.png",scale: 3,),
                  ),
                ),
                //2nd Row
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  start: 8,
                  top: 48,
                  child: Container(
                    child: Text("TOTAL EARNINGS",
                      style: TextStyle(
                          color: Theme.of(context).accentTextTheme.bodyText2.color,
                          fontSize: 12,
                          fontFamily: 'regular'
                      ),),
                  ),
                ),
                //3rd Row
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  start: 8,
                  top: 87,
                  child: Container(
                    child: Text("\$2500.95",
                      style: TextStyle(
                          color: Theme.of(context).accentTextTheme.bodyText2.color,
                          fontSize: 13,
                          fontFamily: 'medium'
                      ),),
                  ),
                ),
                //4th Row
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  start: 0,
                  bottom: 0,
                  child: Container(
                    height: 25,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 8),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentTextTheme.bodyText1.color.withOpacity(0.2),
                    ),
                    child: Text("USD",
                      style: TextStyle(
                          color: Theme.of(context).accentTextTheme.bodyText2.color,
                          fontSize: 12,
                          fontFamily: 'regular'
                      ),),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12,),
        //Completed Orders
        Expanded(
          child: Container(
            height: 162,
            decoration: BoxDecoration(
              color: Theme.of(context).accentTextTheme.headline5.color,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                //1st Row
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  start: 8,
                  top: 12,
                  child: Container(
                    child: Image.asset("assets/newIcons/ic_orders.png",scale: 3,),
                  ),
                ),
                //2nd Row
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  start: 8,
                  top: 48,
                  child: Container(
                    child: Text("COMPLETED ORDERS",
                      style: TextStyle(
                          color: Theme.of(context).accentTextTheme.bodyText2.color,
                          fontSize: 12,
                          fontFamily: 'regular'
                      ),),
                  ),
                ),
                //3rd Row
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  start: 8,
                  top: 87,
                  child: Container(
                    child: Text("103",
                      style: TextStyle(
                          color: Theme.of(context).accentTextTheme.bodyText2.color,
                          fontSize: 13,
                          fontFamily: 'medium'
                      ),),
                  ),
                ),
                //4th Row
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  start: 8,
                  bottom: 35,
                  child: Container(
                    child: Text("Latest Delivery",
                      style: TextStyle(
                          color: Theme.of(context).accentTextTheme.bodyText2.color,
                          fontSize: 10,
                          fontFamily: 'regular'
                      ),),
                  ),
                ),
                //5th Row
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  start: 8,
                  bottom: 14,
                  child: Container(
                    child: Text("Yesterday at 2 pm",
                      style: TextStyle(
                          color: Theme.of(context).accentTextTheme.bodyText2.color,
                          fontSize: 12,
                          fontFamily: 'medium'
                      ),),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
