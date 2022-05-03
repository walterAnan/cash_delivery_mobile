
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:godelivery_rider/ModelClasses/Livraison.dart';
import 'package:godelivery_rider/Tabs/ProcessingTabPage.dart';
import 'package:godelivery_rider/Ui/OrderDetails.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Utils/functions.dart';
class NewTabPage extends StatefulWidget {
  @override
  _NewTabPageState  createState() => _NewTabPageState() ;
}

class  _NewTabPageState extends State<NewTabPage> {

  bool bothButtonsInvisible=false;
  List users = [];
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    this.fectData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: ListView.builder(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: 3,

            itemBuilder: (BuildContext ctxt, int index) {

              return new Container(
                margin: EdgeInsets.symmetric(vertical: 8,horizontal: 18),
                child: InkWell(
                  onTap: (){
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //1st Row
                          Container(
                            padding: EdgeInsets.only(top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("Order #176",
                                    style: TextStyle(
                                      fontFamily: 'medium',
                                      fontSize: 16,
                                      color: Theme.of(context).textTheme.headline1.color,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text("23-11-2020",
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
                          //2nd Row
                          Container(
                            padding: EdgeInsets.only(top: 12),
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
                            padding: EdgeInsets.only(top: 12),
                            child: Row(
                              children: [
                                Container(
                                  child: Text("Pickup Time:",
                                    style: TextStyle(
                                      fontFamily: 'medium',
                                      fontSize: 12,
                                      color: Theme.of(context).textTheme.headline1.color,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(" 25 Nov 02:46 am",
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
                            padding: EdgeInsets.only(top: 12),
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
                          //5th Row
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                MaterialButton(
                                  onPressed: () async {
                                    final prefs = await SharedPreferences.getInstance();

                                    var agentCode = prefs.getString('agent_agent');
                                    var agentId = prefs.getInt('agent_id');
                                    print('Code agent : ' + agentCode);
                                    print('Identifiant agent : ' + '$agentId');

                                    var queryResponse = await http.put(
                                      Uri.parse('https://bocashdelivery.ventis.group/api/update_status_livraison'),
                                      headers: <String, String>{
                                        'Content-Type': 'application/json; charset=UTF-8',
                                      },
                                      body: jsonEncode(<String, int>{
                                        'agent_id' : agentId
                                      }),
                                    );
                                    if(queryResponse.statusCode==200){
                                      Fluttertoast.showToast(msg: "Ok Bonne Livraison");
                                      Navigator.of(context).push(SlidePageRoute(page: ProcessingTabPage()));
                                    }else{
                                      showErrorToast(context, 'Infos invalid');
                                    }

                                  },
                                  height: 25,
                                  elevation: 0,
                                  highlightElevation: 0,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  color: Theme.of(context).accentTextTheme.headline2.color,
                                  child: Container(
                                    child: Text("Livrer",
                                      style: TextStyle(
                                          color: Theme.of(context).accentTextTheme.bodyText2.color,
                                          fontSize: 12,
                                          fontFamily: 'medium'
                                      ),),
                                  ),
                                ),

                                ButtonTheme(
                                  height: 25,
                                  child: MaterialButton(
                                    onPressed: (){
                                      Navigator.of(context).push(SlidePageRoute(page: OrderDetails(bothButtonsinvisible: bothButtonsInvisible,)));
                                    },
                                    highlightElevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side:BorderSide(color:Theme.of(context).textTheme.headline1.color),
                                    ),
                                    child: Container(
                                      child: Text("Details",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'medium'
                                        ),),
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
                ),
              );
            }
        )
    );
  }

  Future<Livraison> fectData() async {


    final prefs = await SharedPreferences.getInstance();

    var agentCode = prefs.getString('agent_agent');
    print('ok' + agentCode);
    var agentId = prefs.getInt('agent_id');
    var id = agentId.toString();
    print('ok' + id);
    print( 'alloooo'+ id);
    var uri = Uri.parse('https://bocashdelivery.ventis.group/api/liste_livraison', ).replace(queryParameters: {'agent_livreur_id': id});
    var queryResponse = await http.get(uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

    );
    try {

      if (queryResponse.statusCode == 200) {

        setState(() {
          var items = json.decode(queryResponse.body)['list_livraison'];
          users = items;
          isLoading = false;
          print('retour API : ' + '${queryResponse.body}');
        });
        await Future.delayed(const Duration(seconds: 1));
      }
      else{
        users = [];
        isLoading = false;
      }
    } catch (e) {
      print(e);
    }
  }
}
