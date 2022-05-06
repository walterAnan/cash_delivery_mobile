import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:godelivery_rider/Tabs/NewTabPage.dart';
import 'package:godelivery_rider/Ui/History.dart';
import 'package:godelivery_rider/Utils/functions.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/background.dart';
import 'MyOrders.dart';


class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  var hauteur;
  var largeur;

  void initState() {
    EasyLoading.init();
  }

  @override
  Widget build(BuildContext context) {
    hauteur = MediaQuery
        .of(context)
        .size
        .height;
    largeur = MediaQuery
        .of(context)
        .size
        .width;
    return Stack(
      children: <Widget>[
        const BackgroundImage(
          imageUrl: 'assets/images/getStarted.jpg',
        ),

        Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child: Container(
                      height: hauteur * 0.35,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          backgroundBlendMode: BlendMode.hardLight
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 45.0, sigmaY: 45.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Etes-vous disponible pour la livraison ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17.0,),

                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                MaterialButton(
                                  onPressed: () async {
                                    print('je suis ici');
                                    final prefs = await SharedPreferences.getInstance();
                                    print('je suis ici1');
                                    var id = prefs.getInt('agent_id');
                                    print('je suis ici2');
                                    print('je suis id' + id.toString());
                                    var queryResponse = await http.put(
                                      Uri.parse('https://dev-cashdelivery.ventis.group/api/update_status_dispo'),
                                      headers: <String, String>{
                                        'Content-Type': 'application/json; charset=UTF-8',
                                      },
                                      body: jsonEncode(<String, int>{
                                        'agent_id' : id
                                      }),

                                    ).catchError((onError) {
                                      showErrorToast(context,
                                          'Vérifiez votre Connexion Internet ');
                                    });
                                    print('retour API : ' +
                                        '${queryResponse.body}');
                                    var queryResponseBody = json.decode(queryResponse.body);
                                    EasyLoading.dismiss();
                                    if (queryResponse != null && queryResponse.statusCode == 200) {
                                      if (queryResponseBody['statut'] == 'OK') {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => MyOrders()
                                        ));
                                      } else {
                                        showErrorToast(context,
                                            '${queryResponseBody['message_content']}');
                                      }
                                    } else {
                                      showErrorToast(context,
                                          'Verifiez votre connexion internet');
                                    }
                                  },

                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: Text('Disponible'),
                                  textColor: Colors.white,
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  elevation: 5.0,
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    Navigator.push(context, SlidePageRoute(page: History()));

                                    final prefs = await SharedPreferences.getInstance();
                                    var id = prefs.getString('agent_id');
                                    var queryResponse = await http.post(
                                      Uri.parse(
                                          'https://dev-cashdelivery.ventis.group/api/update_status_indispo')
                                          .replace(queryParameters: {
                                        'agent_id': id
                                      }),
                                      headers: <String, String>{
                                        'Content-Type': 'application/json; charset=UTF-8',
                                      },

                                    ).catchError((onError) {
                                      showErrorToast(context,
                                          'Vérifiez votre Connexion Internet ');
                                    });


                                    print('retour API : ' +
                                        '${queryResponse.body}');
                                    EasyLoading.dismiss();
                                    if (queryResponse != null &&
                                        queryResponse.statusCode == 200) {
                                      var queryResponseBody = json.decode(
                                          queryResponse.body);
                                      if (queryResponseBody['status'] == 'OK') {
                                        Navigator.push(context,
                                            SlidePageRoute(page: History()));
                                      } else {
                                        showErrorToast(context,
                                            '${queryResponseBody['message_content']}');
                                      }
                                    } else {
                                      showErrorToast(context,
                                          'Verifiez votre connexion internet');
                                    }
                                  },
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: Text('Indisponible'),
                                  textColor: Colors.black,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  elevation: 5.0,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        )
      ],
    );
  }
}








