
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'MyDrawer.dart';
import 'MyOrders.dart';
import 'RequiredDocuments.dart';
class Documents extends StatefulWidget {
  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

 List<Items> list =[
  Items(title: "Driving License",subTitle: "Approved"),
  Items(title: "Vehicle Insurance",subTitle: "Pending"),
  Items(title: "Vehicle Registration",subTitle: "Approved"),
  Items(title: "National ID/Passport",subTitle: "Pending"),
 ];


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
          drawer: MyDrawer(title: "Documents",),
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
                          child: Text("Documents",
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
                //
                Expanded(
                  child: Container(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        //ListView
                        //Body
                        ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (ctx,index){
                              return InkWell(
                                onTap: (){
                                },
                                child: Container(
                                  height: 58,
                                  padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 5),
                                  decoration: BoxDecoration(
                                    border:Border(
                                     bottom: BorderSide(
                                       width: 1,
                                       color: Theme.of(context).primaryTextTheme.headline3.color,
                                     )
                                    )
                                  ),
                                  child:    Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text("${list[index].title}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: "medium",
                                            color: Theme.of(context).textTheme.headline1.color,
                                          ),),
                                      ),
                                      Container(
                                        child: Text("${list[index].subTitle}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: "medium",
                                            color: Theme.of(context).textTheme.headline3.color,
                                          ),),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        //Floating Action Button
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          end: 5,
                          bottom: 25,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 18.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(SlidePageRoute(page: RequiredDocuments()));
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentTextTheme.headline1.color,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/newIcons/ic_upload_floating.png",)
                                  )
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
class Items{
  String title;
  String subTitle;
  Items({this.title,this.subTitle});
}