import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:godelivery_rider/Tabs/DeliveredTabPage.dart';
import 'package:godelivery_rider/Utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../animation/SlidePageRoute.dart';


class Opt1 extends StatefulWidget {
  var order;
  Opt1({Key key, this.order}) : super(key: key);

  @override
  _Opt1State createState() => _Opt1State(this.order);
}

class _Opt1State extends State<Opt1> {
  // 4 text editing controllers that associate with the 4 input fields
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();

  var order;
  _Opt1State(this.order);

  // This is the entered code
  // It will be displayed in a Text widget
  String _otp;

  String reponse = "C'est bien lui le Bénéficiaire";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cash Delivery', style: TextStyle(
          fontSize: 16,
          color: Colors.green
        ),),
        elevation: 0,
      ),

      body:SingleChildScrollView(
    physics: AlwaysScrollableScrollPhysics(),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              shape: BoxShape.rectangle,

              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 10,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),

            child: Image.asset(
              'assets/images/Delivery address-pana.png',

            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text("Entrer Code Livraison", style: TextStyle(
            fontSize:20,
              fontWeight: FontWeight.bold
          ),),
          const SizedBox(
            height: 30,
          ),
          // Implement 4 input fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OtpInput(_fieldOne, true),
              OtpInput(_fieldTwo, false),
              OtpInput(_fieldThree, false),
              OtpInput(_fieldFour, false),
              OtpInput(_fieldFive, false)
            ],
          ),
          const SizedBox(
            height: 30,
          ),
      SizedBox(
        width: 250,
          height: 50,

          child:ElevatedButton(
              style: ButtonStyle(
                foregroundColor:
                MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.green),
                shape:
                MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
              onPressed: () async {
                _otp = _fieldOne.text +
                    _fieldTwo.text +
                    _fieldThree.text +
                    _fieldFour.text + _fieldFive.text;
                print(_otp);

                final prefs = await SharedPreferences.getInstance();
                var id = this.order['id'].toString();
                var queryResponse = await http.post(
                  Uri.parse('https://dev-cashdelivery.ventis.group/api/check_otp'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'demande_id' : id,
                    'otp' : _otp
                  }),
                ).catchError((onError){
                  showErrorToast(context, 'Vérifiez votre Connexion Internet ');
                });
                if(queryResponse.statusCode == 200){
                  var items = json.decode(queryResponse.body)['list_livraison'];
                  print('check_otp');
                  final prefs = await SharedPreferences.getInstance();
                  print('je suis ici');
                  var agentCode = prefs.getString('agent_agent');
                  var agentId = prefs.getInt('agent_id');
                  print('Code agent : ' + agentCode);
                  print('Identifiant agent : ' + '$agentId');
                  initData();
                }else{
                  showErrorToast(context, 'Code Livraison Invalide');
                  print('Erreur');
                }
                setState(() {
                  _fieldOne.text = "";
                  _fieldTwo.text = "";
                  _fieldThree.text = "";
                  _fieldFour.text = "";
                  _fieldFive.text = "";

                });
              },
              child: const Text('Vérifier', style: TextStyle(
                fontSize: 24
              ),))),
          const SizedBox(
            height: 30,
          ),
          // Display the entered OTP code
        ],
      ),
    ));
  }

  Future<void> initData() async {
    var id = this.order['id'];
    print(id);
    var queryResponse = await http.put(
      Uri.parse('https://dev-cashdelivery.ventis.group/api/update_status_effectue'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'id' : id
      }),
    );

    print(queryResponse.statusCode);
    print(queryResponse.body);


    if(queryResponse.statusCode == 200){
      setState(() {
        print('je suis à nouveau ici ');
        showSuccessToast(context, 'Code Livraison Valide');
        Navigator.of(context).push(SlidePageRoute(page: DeliveredTabPage()));

      });
    } else {
      print('Erreur 2');
      print(queryResponse.body);
    }
  }

}

// Create an input widget that takes only one digit
class OtpInput extends StatelessWidget {

  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}