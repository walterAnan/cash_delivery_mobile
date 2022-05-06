import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:godelivery_rider/Tabs/ProcessingTabPage.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:unique_identifier/unique_identifier.dart';

import '../Ui/OrderDetails.dart';
import '../Utils/functions.dart';


class NewTabPage extends StatefulWidget {
  @override
  _NewTabPageState  createState() => _NewTabPageState() ;
}

class  _NewTabPageState extends State<NewTabPage> {
  bool bothButtonsInvisible=false;
  List Livraisons = [];
  bool isLoading = false;
  var token1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print('je suis le token '+ token);
      setState(() {
        token1 = token;
      });
    });
  }
  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();

    var agentCode = prefs.getString('agent_agent');
    print('ok' + agentCode);
    var agentId = prefs.getInt('agent_id');
    var id = agentId.toString();
    var uri = Uri.parse('https://dev-cashdelivery.ventis.group/api/liste_livraison', ).replace(queryParameters: {'agent_livreur_id': id});
    var response = await http.get(uri).catchError((onError){
      showErrorToast(context, 'Vérifiez votre Connexion Internet ');
    });
    // print(response.body);
    if(response.statusCode == 200){
      var items = json.decode(response.body)['list_livraison'];
      notifyMethod();
      // var uri1 = Uri.parse('https://fcm.googleapis.com/fcm/send',);
      setState(() {
        Livraisons = items;
        isLoading = false;
      });
      // http.post(uri1,
      //   headers: <String, String>{
      //     'Content-Type': 'application/json',
      //     'Authorization': 'key=AAAAgr7iOR8:APA91bE_QmF1co-htcVgK6HwrgYRUp6a5JBNkA-YV4ArCIVairMPDDbGcvwuAI_colGobLj-mB6GW92l8KbC4ijFn9KhmUvfiWmlggSMRj5yKKyVLGCLnXlvW-mG_ktXaSFfQvsxc6Ho',
      //   },
      //   body: jsonEncode(
      //     <String, dynamic>{
      //       'notification': <String, dynamic>{
      //         'body': 'this is a body',
      //         'title': 'this is a title'
      //       },
      //       'priority': 'high',
      //       'data': <String, dynamic>{
      //         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      //         'id': '1',
      //         'status': 'done'
      //       },
      //       'to': token1,
      //     },
      //   ),
      // );
    }else{
      Livraisons = [];
      isLoading = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }
  Widget getBody(){
    if(Livraisons.contains(null) || Livraisons.length < 0 || isLoading){
      return Center(child: CircularProgressIndicator());
    }

    if( Livraisons.length==0){
      return Center(
        child: Text('Aucune Livraison ne vous a été assignée !!!', style: TextStyle(fontSize: 14),),
      );
    }
    return ListView.builder(
        itemCount: Livraisons.length,
        itemBuilder: (context,index){
          return getCard(Livraisons[index]);
        });
  }
  Widget getCard(item){
    var id = item['id'];
    var nomClient = item['nom_client'];
    var nomBenef = item['nom_beneficiaire'];
    var reference = item['ref_operation'];
    var date = item['date_livraison'];
    var montant = item['montant_livraison'];
    var adresse = item['adresse_livraison'];

    // return Card(
    //   elevation: 5,
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(5)),
    //   child: Container(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: <Widget>[
    //               Container(
    //                 padding: EdgeInsets.only(top: 12),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Container(
    //                       child: Text("Livraison" + '  '+'#'+ reference,
    //                         style: TextStyle(
    //                           fontFamily: 'medium',
    //                           fontSize: 14,
    //                           color: Theme.of(context).textTheme.headline1.color,
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       child: Text(date,
    //                         style: TextStyle(
    //                           color: Theme.of(context).textTheme.headline3.color,
    //                           fontFamily: 'medium',
    //                           fontSize: 14,
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //
    //
    //               Container(
    //                 padding: EdgeInsets.only(top: 12),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Container(
    //                       child: Text('Montant',
    //                         style: TextStyle(
    //                           fontFamily: 'medium',
    //                           fontSize: 14,
    //                           color: Theme.of(context).textTheme.headline1.color,
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       child: Text(montant + ' XAF',
    //                         style: TextStyle(
    //                           color: Theme.of(context).textTheme.headline3.color,
    //                           fontFamily: 'medium',
    //                           fontSize: 14,
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //
    //
    //
    //               Container(
    //                 padding: EdgeInsets.only(top: 12),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Container(
    //                       child: Text('Bénéficiaire',
    //                         style: TextStyle(
    //                           fontFamily: 'medium',
    //                           fontSize: 14,
    //                           color: Theme.of(context).textTheme.headline1.color,
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       child: Text(nomBenef,
    //                         style: TextStyle(
    //                           color: Theme.of(context).textTheme.headline3.color,
    //                           fontFamily: 'medium',
    //                           fontSize: 14,
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //
    //
    //
    //               Container(
    //                 padding: EdgeInsets.only(top: 12),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Container(
    //                       child: Text('Adresse',
    //                         style: TextStyle(
    //                           fontFamily: 'medium',
    //                           fontSize: 14,
    //                           color: Theme.of(context).textTheme.headline1.color,
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       child: Text(adresse,
    //                         style: TextStyle(
    //                           color: Theme.of(context).textTheme.headline3.color,
    //                           fontFamily: 'medium',
    //                           fontSize: 14,
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //
    //
    //                     Container(
    //                   padding: EdgeInsets.only(top: 10),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                     MaterialButton(
    //                       onPressed: () async {
    //
    //                         var queryResponse = await http.put(
    //                           Uri.parse('https://dev-cashdelivery.ventis.group/api/update_status_livraison'),
    //                           headers: <String, String>{
    //                             'Content-Type': 'application/json; charset=UTF-8',
    //                           },
    //                           body: jsonEncode(<String, int>{
    //                             'id' : id
    //                           }),
    //                         ).catchError((onError){
    //                           showErrorToast(context, 'Vérifiez votre Connexion Internet ');
    //                         });
    //                         if(queryResponse.statusCode==200){
    //                           print(queryResponse.body);
    //                           Fluttertoast.showToast(msg: "Ok Bonne Livraison");
    //                           Navigator.of(context).push(SlidePageRoute(page: ProcessingTabPage()));
    //                         }else{
    //                           showErrorToast(context, 'Infos invalid');
    //                         }

    //                       },
    //                       height: 25,
    //                       elevation: 0,
    //                       highlightElevation: 0,
    //                       splashColor: Colors.transparent,
    //                       highlightColor: Colors.transparent,
    //                       shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(50)
    //                       ),
    //                       color: Theme.of(context).accentTextTheme.headline2.color,
    //                       child: Container(
    //                         child: Text("Commencer la livraison",
    //                           style: TextStyle(
    //                               color: Theme.of(context).accentTextTheme.bodyText2.color,
    //                               fontSize: 12,
    //                               fontFamily: 'medium'
    //                           ),),
    //                       ),
    //                     ),
    //
    //                     ButtonTheme(
    //                       height: 25,
    //                       child: MaterialButton(
    //                         onPressed: (){
    //                          Navigator.of(context).push(SlidePageRoute(page: OrderDetails(bothButtonsinvisible: bothButtonsInvisible, order: item,)));
    //                         },
    //                         highlightElevation: 0,
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(50),
    //                           side:BorderSide(color:Theme.of(context).textTheme.headline1.color),
    //                         ),
    //                         child: Container(
    //                           child: Text("Details",
    //                             style: TextStyle(
    //                                 fontSize: 12,
    //                                 color: Colors.green,
    //                                 fontFamily: 'medium'
    //                             ),),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                     )
    //
    //
    //
    //             ],
    //           )
    //
    //       ),
    //     );

    var fontSize = 14.0;
    return Card(
      elevation: 8.0,
      shadowColor: Colors.grey.withOpacity(0.5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                    reference,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: fontSize,
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                    date,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: fontSize,
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                    montant,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: fontSize,
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                    nomBenef,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: fontSize,
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                    adresse,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: fontSize,
                    ),
                  )
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () async {
                      var queryResponse = await http.put(
                        Uri.parse('https://dev-cashdelivery.ventis.group/api/update_status_livraison'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, int>{
                          'id' : id
                        }),
                      ).catchError((onError){
                        showErrorToast(context, 'Vérifiez votre Connexion Internet ');
                      });
                      if(queryResponse.statusCode==200){
                        print(queryResponse.body);
                        Fluttertoast.showToast(msg: "Ok Bonne Livraison");
                        Navigator.of(context).push(SlidePageRoute(page: ProcessingTabPage()));
                      }else{
                        showErrorToast(context, 'Infos invalid');
                      }

                    },
                    height: 30,
                    elevation: 8,
                    color: Colors.green,
                    highlightElevation: 0,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      'Commencer la livraison',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.5
                      ),
                    ),
                  ),

                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(SlidePageRoute(page: OrderDetails(bothButtonsinvisible: bothButtonsInvisible, order: item,)));
                    },
                    height: 30,
                    elevation: 8,
                    color: Colors.grey,
                    highlightElevation: 0,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      'Détails',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.5
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }

  Future notifyMethod() async {
    var uri1 = Uri.parse('https://dev-cashdelivery.ventis.group/demandes');
    if(token1!=null){
    var response = await http.post(uri1);
    return jsonEncode(response.body);
    }
    else{
      print("Token is null");
    }
  }
}