
import 'package:flutter/services.dart';
import 'package:godelivery_rider/Ui/AddSignature.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'MyDrawer.dart';
// ignore: must_be_immutable
class OrderDetails extends StatefulWidget {
  //When Navigate from New Tab
  bool bothButtonsinvisible;
  //When Navigate from Processing Tab
  bool getSignatureButton;
  String buttonvalue;
  //When Navigate from Delivered Tab
  bool orderDelivered;
  String orderDeliveredSuccessfully;

  var order;
  //When Navigate from History Screen
  OrderDetails({this.bothButtonsinvisible,this.getSignatureButton,this.buttonvalue,this.orderDeliveredSuccessfully, this.order});
  @override
  _OrderDetailsState createState() => _OrderDetailsState(bothButtonsinvisible,getSignatureButton,
      this.orderDelivered,this.buttonvalue,orderDeliveredSuccessfully, this.order);
}

class _OrderDetailsState extends State<OrderDetails> {
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
  //When Navigate from New Tab
  bool bothButtonsinvisible=true;
  //When Navigate from Processing Tab
  bool getSignatureButton;
  String buttonvalue;
  //When Navigate from Delivered Tab
  bool orderDelivered;
  String orderDeliveredSuccessfully="Order Delivered Successfully";
  var order;
 _OrderDetailsState(this.bothButtonsinvisible,this.getSignatureButton,this.orderDelivered,this.buttonvalue,
     this.orderDeliveredSuccessfully, this.order);
 //key For Drawer
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  //Open Map
  void _launchMapsUrl(String originPlaceId, String destinationPlaceId)   async {
    String mapOptions = [
      'origin=$originPlaceId',
      'origin_place_id=$originPlaceId',
      'destination=$destinationPlaceId',
      'destination_place_id=$destinationPlaceId',
      'dir_action=navigate'
    ].join('&');

    final url = 'https://www.google.com/maps/dir/api=1&$mapOptions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  String _originPlaceId = "ORIGIN PLACE ID";
  String _destinationPlaceId = "DESTINATION PLACE ID";
  bool showAddSignature=false;
  double height=68;
  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
  @override
  Widget build(BuildContext context) {
    var fontSize = 13.0;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Détails livraison'),
        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        centerTitle: true,
      ),
      endDrawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/transport.png', scale: 2.5,
                )
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child:
                      TextButton(
                        onPressed: () {
                          _launchMapsUrl(_originPlaceId, _destinationPlaceId);
                        },
                        child: Text(
                          'Map',
                          style: TextStyle(
                            color: Colors.green
                          ),
                        )
                      )
                  ),
                  Card(
                    elevation: 6.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Référence',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              ),
                              Text(
                                this.order['ref_operation'],
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Date',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              ),
                              Text(
                                this.order['date_livraison'].toString(),
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Bénéficiaire',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              ),
                              Text(
                                this.order['nom_beneficiaire'],
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Contact',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              ),
                              Text(
                                this.order['tel_beneficiaire'],
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Adresse',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              ),
                              Text(
                                this.order['adresse_livraison'],
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: 15.0,),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Détais client',
                          style: TextStyle(
                              fontSize: 14.5
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 6.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Nom',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              ),
                              Text(
                                this.order['nom_client'],
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Contact',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              ),
                              Text(
                                this.order['tel_client'].toString(),
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: 15.0,),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Information du cash',
                          style: TextStyle(
                              fontSize: 14.5
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 6.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Type paiement',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              ),
                              Text(
                                'Cash',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Nbre billets 10 000',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              ),
                              Text(
                                '${this.order['nombreBillet10000']}',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Nbre billets 5 000',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              ),
                              Text(
                                '${this.order['nombreBillet5000']}',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Montant',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              ),
                              Text(
                                this.order['montant_livraison'].toString(),
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: fontSize,
                                ),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      // body: Container(
      //   child: Column(
      //     children: [
      //       //AppBar
      //       Container(
      //         height: 70,
      //         child: Stack(
      //           fit: StackFit.expand,
      //           children: [
      //             //Drawer
      //             Positioned.directional(
      //               textDirection: Directionality.of(context),
      //               top: 0,
      //               bottom: 0,
      //               start: 7,
      //               child: InkWell(
      //                 onTap: (){
      //                   _scaffoldKey.currentState.openDrawer();
      //                 },
      //                 child: Container(
      //                   padding: const EdgeInsets.all(10.0),
      //                   child: new Image.asset("assets/newIcons/ic_menu.png",width: 25,
      //                     color: Theme.of(context).iconTheme.color,),
      //                 ),
      //               ),
      //             ),
      //             //Center Widget
      //             Positioned.directional(
      //               textDirection: Directionality.of(context),
      //               top: 0,
      //               bottom: 0,
      //               start: 0,
      //               end: 0,
      //               child: Container(
      //                 alignment: Alignment.center,
      //                 child: Text('#' + this.order['ref_operation'],
      //                   style: TextStyle(
      //                     fontSize: 14,
      //                     fontFamily: 'medium',
      //                     color: Colors.green,
      //                   ),),
      //               ),
      //             ),
      //             //Option
      //             Positioned.directional(
      //               textDirection: Directionality.of(context),
      //               top: 0,
      //               bottom: 0,
      //               end: 2,
      //               child:InkWell(
      //                 onTap: (){
      //                   _showPopupMenu(context);
      //                 },
      //                 child: Container(
      //                   padding: const EdgeInsets.all(10.0),
      //                   // child: new Image.asset("assets/newIcons/ic_option.png",width: 20,
      //                   //   color: Theme.of(context).iconTheme.color,),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       //Listview
      //       Expanded(
      //         child: ListView(
      //           children: [
      //             SizedBox(height: 14,),
      //             //Profile
      //             Container(
      //               padding: EdgeInsets.only(left: 18,right: 10),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Row(
      //                     children: <Widget>[
      //                       //Prof Img
      //                       Container(
      //                         height: 80,
      //                         width: 54,
      //                         decoration: BoxDecoration(
      //                             shape: BoxShape.circle,
      //                             image: DecorationImage(
      //                                 fit: BoxFit.fill,
      //                                 image: AssetImage("assets/newIcons/ic_newProfile.png")
      //                             )
      //                         ),
      //                       ),
      //                       SizedBox(width: 7,),
      //                       //Prof Name
      //                       Container(
      //                         child: Text(nom,
      //                           style: TextStyle(
      //                               fontSize: 13,
      //                               fontFamily: 'medium',
      //                             color: Theme.of(context).textTheme.headline1.color,
      //                           ),),
      //                       )
      //                     ],
      //                   ),
      //                   //phone and chat icon
      //                   Visibility(
      //                     visible: orderDeliveredSuccessfully==null?true:false,
      //                     child: Container(
      //                       child: Row(
      //                         children: [
      //                           InkWell(
      //                             onTap: (){
      //                              launchUrl("tel:065988685");
      //                             },
      //                             child: Padding(
      //                               padding: const EdgeInsets.all(8.0),
      //                               child: Image.asset("assets/newIcons/ic_pink_phone.png",scale: 5.0, color: Colors.green,),
      //                             ),
      //                           ),
      //
      //                           // InkWell(
      //                           //   onTap: (){
      //                           //     Navigator.push(context, SlidePageRoute(page: Chat()));
      //                           //   },
      //                           //   child: Padding(
      //                           //     padding: const EdgeInsets.all(8.0),
      //                           //     child: Image.asset("assets/newIcons/ic_chat2.png",scale: 4,),
      //                           //   ),
      //                           // ),
      //                         ],
      //                       ),
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //
      //             SizedBox(height: 5,),
      //             //Pickup information
      //             Container(
      //               padding: EdgeInsets.only(left: 20,right: 13),
      //               height: 150,
      //               decoration: BoxDecoration(
      //                 border: Border(
      //                   bottom: BorderSide(
      //                       width: 1,
      //                       color: Colors.green,
      //                   )
      //                 )
      //               ),
      //
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   //1st Row
      //                   SizedBox(height: 6,),
      //                   Container(
      //                     height:20,
      //                     child: Stack(
      //                       children: [
      //                         Positioned.directional(
      //                           textDirection: Directionality.of(context),
      //                           start: 0,
      //                           bottom: 0,
      //                           child: Container(
      //                             child: Text("Détails de la livraison",
      //                               style: TextStyle(
      //                                 fontSize: 13,
      //                                 fontFamily: 'medium',
      //                                 color: Colors.green,
      //                               ),),
      //                           ),
      //                         ),
      //                         Positioned.directional(
      //                           textDirection: Directionality.of(context),
      //                           end: 0,
      //                           bottom: -4,
      //                           child: InkWell(
      //                             onTap:() {
      //                               _launchMapsUrl(_originPlaceId, _destinationPlaceId);
      //                             },
      //                             child: Container(
      //                               padding: EdgeInsets.all(5),
      //                               child: Text("Parcours Map",
      //                                 style: TextStyle(
      //                                   color: Colors.lightGreen,
      //                                   fontSize: 12,
      //                                   fontFamily: 'medium',
      //                                 ),),
      //                             ),
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                   //2nd Row
      //
      //
      //               Card(
      //                 shape: BeveledRectangleBorder(
      //                   borderRadius: BorderRadius.circular(10.0),
      //                 ),
      //                   child:Column(
      //                     mainAxisAlignment: MainAxisAlignment.end,
      //                     children: <Widget>[
      //                       Container(
      //                         padding: EdgeInsets.only(top: 12),
      //                         child: Row(
      //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Container(
      //                               child: Text("Agence",
      //                                 style: TextStyle(
      //                                   fontFamily: 'medium',
      //                                   fontSize: 14,
      //                                   color: Theme.of(context).textTheme.headline1.color,
      //                                 ),
      //                               ),
      //                             ),
      //                             Container(
      //                               child: Text(this.order['code_agence'],
      //                                 style: TextStyle(
      //                                   color: Theme.of(context).textTheme.headline3.color,
      //                                   fontFamily: 'medium',
      //                                   fontSize: 14,
      //                                 ),
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //
      //
      //                       Container(
      //                         padding: EdgeInsets.only(top: 12),
      //                         child: Row(
      //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Container(
      //                               child: Text('Adresse',
      //                                 style: TextStyle(
      //                                   fontFamily: 'medium',
      //                                   fontSize: 14,
      //                                   color: Theme.of(context).textTheme.headline1.color,
      //                                 ),
      //                               ),
      //                             ),
      //                             Container(
      //                               child: Text(this.order['adresse_livraison'],
      //                                 style: TextStyle(
      //                                   color: Theme.of(context).textTheme.headline3.color,
      //                                   fontFamily: 'medium',
      //                                   fontSize: 14,
      //                                 ),
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //
      //
      //
      //                       Container(
      //                         padding: EdgeInsets.only(top: 12),
      //                         child: Row(
      //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Container(
      //                               child: Text('Bénéficiaire',
      //                                 style: TextStyle(
      //                                   fontFamily: 'medium',
      //                                   fontSize: 14,
      //                                   color: Theme.of(context).textTheme.headline1.color,
      //                                 ),
      //                               ),
      //                             ),
      //                             Container(
      //                               child: Text(this.order['nom_beneficiaire'],
      //                                 style: TextStyle(
      //                                   color: Theme.of(context).textTheme.headline3.color,
      //                                   fontFamily: 'medium',
      //                                   fontSize: 14,
      //                                 ),
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //
      //
      //
      //                       Container(
      //                         padding: EdgeInsets.only(top: 12),
      //                         child: Row(
      //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Container(
      //                               child: Text('Tel Bénéficiare',
      //                                 style: TextStyle(
      //                                   fontFamily: 'medium',
      //                                   fontSize: 14,
      //                                   color: Theme.of(context).textTheme.headline1.color,
      //                                 ),
      //                               ),
      //                             ),
      //                             Container(
      //                               child: Text(this.order['tel_beneficiaire'],
      //                                 style: TextStyle(
      //                                   color: Theme.of(context).textTheme.headline3.color,
      //                                   fontFamily: 'medium',
      //                                   fontSize: 14,
      //                                 ),
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //
      //
      //
      //                     ],
      //                   ),
      //             ),
      //
      //
      //
      //             //
      //             //       Container(
      //             //         child: Row(
      //             //           children: [
      //             //             Container(
      //             //               child: Text('Tel Bénéficiaire ----->'+this.order['tel_beneficiaire'],
      //             //                 style: TextStyle(
      //             //                   color: Theme.of(context).textTheme.headline3.color,
      //             //                   fontSize: 13,
      //             //                   fontFamily: 'medium',
      //             //                 ),),
      //             //             ),
      //             //           ],
      //             //         ),
      //             //       ),
      //             //
      //             //   //4th Row
      //             //       //5th Row
      //             //     ],
      //             //   ),
      //             // ),
      //             // //Delivery information
      //             //
      //             // Container(
      //             //   padding: EdgeInsets.only(left: 20,right: 13),
      //             //   height: 135,
      //             //   decoration: BoxDecoration(
      //             //       border: Border(
      //             //           bottom: BorderSide(
      //             //               width: 1,
      //             //             color: Colors.green,
      //             //           )
      //             //       )
      //             //   ),
      //             //   child: Column(
      //             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             //     children: [
      //             //       //1st Row
      //             //       Container(
      //             //         height: 30,
      //             //         child: Stack(
      //             //           children: [
      //             //             Positioned.directional(
      //             //               textDirection: Directionality.of(context),
      //             //               start: 0,
      //             //               bottom: 0,
      //             //               child: Container(
      //             //                 child: Text("Détails sur le Client",
      //             //                   style: TextStyle(
      //             //                    fontSize: 13,
      //             //                     fontFamily: 'medium',
      //             //                     color: Colors.green,
      //             //                   ),),
      //             //               ),
      //             //             ),
      //             //             Positioned.directional(
      //             //               textDirection: Directionality.of(context),
      //             //               end: 0,
      //             //               bottom: -4,
      //             //               child: InkWell(
      //             //                 onTap:() {
      //             //                   _launchMapsUrl(_originPlaceId, _destinationPlaceId);
      //             //                 },
      //             //                 child: Container(
      //             //                   padding: EdgeInsets.all(2),
      //             //                   child: Text("Parcours Map",
      //             //                     style: TextStyle(
      //             //                       color: Colors.green,
      //             //                       fontSize: 12,
      //             //                       fontFamily: 'medium',
      //             //                     ),),
      //             //                 ),
      //             //               ),
      //             //             )
      //             //           ],
      //             //         ),
      //             //       ),
      //             //       //2nd Row
      //             //
      //             //       Container(
      //             //         child: Row(
      //             //           children: [
      //             //             Container(
      //             //               child: Text("Nom ----> " +this.order['nom_client'],
      //             //                 style: TextStyle(
      //             //                   color: Theme.of(context).textTheme.headline3.color,
      //             //                   fontSize: 12,
      //             //                   fontFamily: 'medium',
      //             //                 ),),
      //             //             ),
      //             //           ],
      //             //         ),
      //             //       ),
      //             //       //3rd Row
      //             //       Container(
      //             //         child: Row(
      //             //           children: [
      //             //             Container(
      //             //               child: Text("Numero ----> " +this.order['tel_client'],
      //             //                 style: TextStyle(
      //             //                   color: Theme.of(context).textTheme.headline3.color,
      //             //                   fontSize: 12,
      //             //                   fontFamily: 'medium',
      //             //                 ),),
      //             //             ),
      //             //           ],
      //             //         ),
      //             //       ),
      //             //       //4th Row
      //             //       //5th Row
      //             //       SizedBox(height: 6,),
      //             //     ],
      //             //   ),
      //             // ),
      //             //
      //             // //Item Name
      //             // Container(
      //             //   padding: EdgeInsets.symmetric(horizontal: 20),
      //             //   decoration: BoxDecoration(
      //             //       border: Border(
      //             //           bottom: BorderSide(
      //             //               width: 1,
      //             //             color: Colors.green,
      //             //           )
      //             //       )
      //             //   ),
      //             //   child: Column(
      //             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             //     children: [
      //             //       SizedBox(height: 8,),
      //             //       //1st Row
      //             //       Container(
      //             //         alignment: Alignment.centerLeft,
      //             //         child: Text("Informations sur le Cash",
      //             //           style: TextStyle(
      //             //             fontSize: 13,
      //             //             fontFamily: 'medium',
      //             //             color: Colors.green,
      //             //           ),),
      //             //       ),
      //             //       Container(
      //             //         padding: EdgeInsets.symmetric(vertical: 10,),
      //             //         height: 100,
      //             //         decoration: BoxDecoration(
      //             //             border: Border(
      //             //                 bottom: BorderSide(
      //             //                   width: 1,
      //             //                   color: Theme.of(context).primaryTextTheme.headline3.color,
      //             //                 )
      //             //             )
      //             //         ),
      //             //         child: Column(
      //             //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             //           children: [
      //             //             SizedBox(height: 5,),
      //             //             //1st Row
      //             //             Container(
      //             //               alignment: Alignment.centerLeft,
      //             //               child: Text("Type de Payement",
      //             //                 style: TextStyle(
      //             //                   fontSize: 13,
      //             //                   fontFamily: 'medium',
      //             //                   color: Theme.of(context).textTheme.headline3.color,
      //             //                 ),),
      //             //             ),
      //             //             //2nd Row
      //             //             Container(
      //             //               child: Row(
      //             //                 children: [
      //             //                   Container(
      //             //                     child: Text("Cash delivery",
      //             //                       style: TextStyle(
      //             //                           color: Theme.of(context).textTheme.headline3.color,
      //             //                           fontSize: 12,
      //             //                           fontFamily: 'medium',
      //             //                           height: 2
      //             //                       ),),
      //             //                   ),
      //             //                 ],
      //             //               ),
      //             //             ),
      //             //
      //             //             Container(
      //             //               child: Row(
      //             //                 children: [
      //             //                   Container(
      //             //                     child: Text("Montant du cash --->" + this.order['montant_livraison'] + 'F XAF',
      //             //                       style: TextStyle(
      //             //                         fontSize: 13,
      //             //                         fontFamily: 'medium',
      //             //                         color: Theme.of(context).textTheme.headline3.color,
      //             //                       ),),
      //             //                   ),
      //             //                 ],
      //             //               ),
      //             //             ),
      //             //             SizedBox(height: 5,),
      //             //           ],
      //             //         ),
      //             //       )
      //             //     ],
      //             //   ),
      //             // ),
      //             //
      //             // //payment Type
      //             // Container(
      //             //   padding: EdgeInsets.symmetric(horizontal: 20),
      //             //
      //             // ),
      //             //
      //             // //Total Amount
      //             // Container(
      //             //   padding: EdgeInsets.symmetric(horizontal: 20),
      //             //   height: 80,
      //             //   decoration: BoxDecoration(
      //             //   ),
      //             //   child: Column(
      //             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             //     children: [
      //             //       SizedBox(height: 5,),
      //             //       //1st Row
      //             //
      //             //       Container(
      //             //         alignment: Alignment.centerLeft,
      //             //         child: Text("Billetage",
      //             //           style: TextStyle(
      //             //             fontSize: 13,
      //             //             fontFamily: 'medium',
      //             //             color: Colors.green,
      //             //           ),),
      //             //       ),
      //             //
      //             //       SizedBox(height: 5,),
      //             //
      //             //       Container(
      //             //         child: Row(
      //             //           children: [
      //             //             Container(
      //             //               child: Text("Nombre de billet 10.000 --->" + this.order['nombreBillet10000'].toString(),
      //             //                 style: TextStyle(
      //             //                   fontSize: 13,
      //             //                   fontFamily: 'medium',
      //             //                   color: Theme.of(context).textTheme.headline1.color,
      //             //                 ),),
      //             //             ),
      //             //           ],
      //             //         ),
      //             //       ),
      //             //
      //             //       SizedBox(height: 5,),
      //             //       Container(
      //             //         child: Row(
      //             //           children: [
      //             //             Container(
      //             //               child: Text("Nombre de billet de 5.000 F --->" + this.order['nombreBillet5000'].toString(),
      //             //                 style: TextStyle(
      //             //                   fontSize: 13,
      //             //                   fontFamily: 'medium',
      //             //                   color: Theme.of(context).textTheme.headline1.color,
      //             //                 ),),
      //             //             ),
      //             //           ],
      //             //         ),
      //             //       ),
      //                   //2nd Row
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   elevation: 0,
      //   child: Visibility(
      //     visible: bothButtonsinvisible==null?true:bothButtonsinvisible,
      //     child: Container(
      //       height:height,
      //       color: Colors.transparent,
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           //1st Button
      //           Container(
      //             padding: EdgeInsets.only(left: 18,right: 18,top: 8,bottom: 8),
      //             child: Row(
      //               children: [
      //                 Expanded(
      //                   child: MaterialButton(
      //                     height: 44,
      //                     onPressed: () {
      //                       setState(() {
      //                         if(buttonvalue.contains("On The Way To Pickup")){
      //                          buttonvalue="Order Picked";
      //                         }else if(buttonvalue.contains("Order Picked")){
      //                           buttonvalue="On the Way to Dropoff";
      //                         }else if(buttonvalue.contains("On the Way to Dropoff")){
      //                           buttonvalue="Delivered";
      //                         }else if(buttonvalue.contains("Delivered")){
      //                           showAddSignature=true;
      //                           height=124;
      //                           buttonvalue="Order Delivered Successfully";
      //                         }
      //                       });
      //                     },
      //                     shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(2)
      //                     ),
      //                     color:orderDeliveredSuccessfully== "Order Delivered Successfully"||showAddSignature==true?
      //                     Theme.of(context).accentTextTheme.headline2.color:
      //                     Theme.of(context).accentTextTheme.headline1.color,
      //                     elevation: 0,
      //                     highlightElevation: 0,
      //                     child: Text(
      //                       (getSignatureButton==null)? "$orderDeliveredSuccessfully":"$buttonvalue",
      //                       style: TextStyle(
      //                           color: Theme.of(context).accentTextTheme.bodyText2.color,
      //                           fontSize: 14,
      //                           fontFamily: 'medium'
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           //Get Signature of user
      //           Visibility(
      //             visible: getSignatureButton==null&&getSignatureButton==false?true:showAddSignature,
      //             child: Container(
      //               padding: EdgeInsets.only(left: 18,right: 18,bottom: 12,),
      //               child: Row(
      //                 children: [
      //                   Expanded(
      //                     child: MaterialButton(
      //                       height: 44,
      //                       onPressed: () {
      //                         Navigator.push(context, SlidePageRoute(page: AddSignature()));
      //                       },
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(2)
      //                       ),
      //                       color: Theme.of(context).accentTextTheme.headline1.color,
      //                       elevation: 0,
      //                       highlightElevation: 0,
      //                       child: Text(
      //                         "Get Signature of user",
      //                         style: TextStyle(
      //                             color: Theme.of(context).accentTextTheme.bodyText2.color,
      //                             fontSize: 14,
      //                             fontFamily: 'medium'
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  //_showPopupMenu
  void _showPopupMenu(BuildContext context)
  {
    showMenu<String>(
        context: context,
        position: new RelativeRect.fromLTRB(120.0, 65.0, 22.0, 100.0),
        items: <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            height: 40,
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
                //Navigator.push(context, SlidePageRoute(page: Chat()));
              },
              child: Container(
                height: 40,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10,),
                child: Text("Report a Problem",
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: "medium",
                    color: Theme.of(context).textTheme.headline1.color,
                  ),),
              ),
            ),
          ),
        ]
    );
  }
}
