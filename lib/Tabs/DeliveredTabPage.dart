import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:godelivery_rider/Ui/OrderDetails.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Utils/functions.dart';


class DeliveredTabPage extends StatefulWidget {
  @override
  _DeliveredTabPageState createState() => _DeliveredTabPageState();
}

class _DeliveredTabPageState extends State<DeliveredTabPage> {
  List users = [];
  bool isLoading = false;
  bool bothButtonsInvisible=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
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
    var uri = Uri.parse('https://dev-cashdelivery.ventis.group/api/historique_livraison', ).replace(queryParameters: {'agent_livreur_id': id});
    var response = await http.get(uri).catchError((onError){
      showErrorToast(context, 'Vérifiez votre Connexion Internet ');
    });
    // print(response.body);
    if(response.statusCode == 200){
      var items = json.decode(response.body)['list_livraison'];
      setState(() {
        users = items;
        isLoading = false;
      });
    }else{
      users = [];
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
    if(users.contains(null) || users.length < 0 || isLoading){
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){
          return getCard(users[index]);
        });
  }
  Widget getCard(item){
    var nomClient = item['nom_client'];
    var nomBenef = item['nom_beneficiaire'];
    var reference = item['ref_operation'];
    var date = item['date_livraison'];
    var adresse = item['adresse_livraison'];
    var montant = item['montant_livraison'];

    // return Card(
    //   elevation: 5,
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(5)),
    //   child: Container(
    //       padding: const EdgeInsets.all(10.0),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: <Widget>[
    //           Container(
    //             padding: EdgeInsets.only(top: 12),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Container(
    //                   child: Text("Livraison" + '  '+'#'+ reference,
    //                     style: TextStyle(
    //                       fontFamily: 'medium',
    //                       fontSize: 14,
    //                       color: Theme.of(context).textTheme.headline1.color,
    //                     ),
    //                   ),
    //                 ),
    //                 Container(
    //                   child: Text(date,
    //                     style: TextStyle(
    //                       color: Theme.of(context).textTheme.headline3.color,
    //                       fontFamily: 'medium',
    //                       fontSize: 14,
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //
    //
    //           Container(
    //             padding: EdgeInsets.only(top: 12),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Container(
    //                   child: Text('Montant',
    //                     style: TextStyle(
    //                       fontFamily: 'medium',
    //                       fontSize: 14,
    //                       color: Theme.of(context).textTheme.headline1.color,
    //                     ),
    //                   ),
    //                 ),
    //                 Container(
    //                   child: Text(montant + 'XAF',
    //                     style: TextStyle(
    //                       color: Theme.of(context).textTheme.headline3.color,
    //                       fontFamily: 'medium',
    //                       fontSize: 14,
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //
    //
    //
    //           Container(
    //             padding: EdgeInsets.only(top: 12),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Container(
    //                   child: Text('Bénéficiaire',
    //                     style: TextStyle(
    //                       fontFamily: 'medium',
    //                       fontSize: 14,
    //                       color: Theme.of(context).textTheme.headline1.color,
    //                     ),
    //                   ),
    //                 ),
    //                 Container(
    //                   child: Text(nomBenef,
    //                     style: TextStyle(
    //                       color: Theme.of(context).textTheme.headline3.color,
    //                       fontFamily: 'medium',
    //                       fontSize: 14,
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //
    //
    //
    //           Container(
    //             padding: EdgeInsets.only(top: 12),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Container(
    //                   child: Text('Adresse',
    //                     style: TextStyle(
    //                       fontFamily: 'medium',
    //                       fontSize: 14,
    //                       color: Theme.of(context).textTheme.headline1.color,
    //                     ),
    //                   ),
    //                 ),
    //                 Container(
    //                   child: Text(adresse,
    //                     style: TextStyle(
    //                       color: Theme.of(context).textTheme.headline3.color,
    //                       fontFamily: 'medium',
    //                       fontSize: 14,
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //
    //
    //
    //
    //           Container(
    //             padding: EdgeInsets.only(top: 10),
    //             child: TextButton(
    //                 onPressed: () {},
    //                 child: ButtonTheme(
    //                   height: 25,
    //                   child: MaterialButton(
    //                     onPressed: (){
    //                        Navigator.of(context).push(SlidePageRoute(page: OrderDetails(bothButtonsinvisible: bothButtonsInvisible, order: item,)));
    //                     },
    //                     child: Container(
    //                       child: Text("Voir les Details",
    //                         style: TextStyle(
    //                           color: Colors.green,
    //                             fontSize: 22,
    //                             fontFamily: 'medium'
    //                         ),),
    //                     ),
    //                   ),
    //                 ),
    //             ),
    //           )
    //
    //
    //
    //         ],
    //       )
    //
    //   ),
    // );

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
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(SlidePageRoute(page: OrderDetails(bothButtonsinvisible: bothButtonsInvisible, order: item,)));
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
                      'Voir les Détails',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.5
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
}