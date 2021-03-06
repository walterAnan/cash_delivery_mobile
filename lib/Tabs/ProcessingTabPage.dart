import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:godelivery_rider/Ui/OrderDetails.dart';
import 'package:godelivery_rider/Ui/opt1.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Utils/functions.dart';


class ProcessingTabPage extends StatefulWidget {
  @override
  _ProcessingTabPageState  createState() => _ProcessingTabPageState() ;
}

class  _ProcessingTabPageState extends State<ProcessingTabPage> {
  List Livraisons = [];
  bool isLoading = false;
  bool bothButtonsInvisible=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
    print('je suis dans la bonne page');
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
    var uri = Uri.parse('https://dev-cashdelivery.ventis.group/api/livraison_en_cours', ).replace(queryParameters: {'agent_livreur_id': id});
    var response = await http.get(uri).catchError((onError){
      showErrorToast(context, 'Vérifiez votre Connexion Internet ');
    });
    // print(response.body);
    if(response.statusCode == 200){
      var items = json.decode(response.body)['list_livraison'];
      print(items);
      setState(() {
        Livraisons = items;
        isLoading = false;
      });
    }else{
      print('pas de livraison en cours');
      print(response.statusCode);
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
        child: Text('Aucune Livraison en cours !!!', style: TextStyle(fontSize: 14),),
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

    var fontSize = 12.0;
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
                    NumberFormat.currency(locale: 'EUR', symbol: 'XAF').format(double.parse(montant)),
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
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Adresse',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: fontSize,
                    ),
                  ),

                  SizedBox(width: 20,),

                  // Container(
                  //   // color: Colors.blue,
                  //   width: MediaQuery.of(context).size.width * 0.6,
                  //   child: Flexible(
                  //     // color: Colors.blue,
                  //     child: Text(
                  //       adresse,
                  //       style: TextStyle(
                  //         color: Colors.black54,
                  //         fontSize: fontSize,
                  //       ),
                  //       maxLines: 5,
                  //       overflow: TextOverflow.ellipsis,
                  //     ),
                  //   ),
                  // )

                  Container(
                    // color: Colors.blue,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: FittedBox(
                      child: Text(
                        adresse,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: fontSize,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
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
                    onPressed: () {
                      Navigator.of(context).push(SlidePageRoute(page: Opt1(order: item,)));

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
                      'Terminer la livraison',
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
}