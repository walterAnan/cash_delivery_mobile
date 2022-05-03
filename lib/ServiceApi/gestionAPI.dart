import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:godelivery_rider/ModelClasses/Livraison.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiGestion{

  Future <List<Map<String, dynamic>>> getLivraisons(agent_id, status) async {
    // Api pour recevoir les données sur les livraisns à effectuer par l'agent
    // https://sfe-fid/demande_livraison

    // Await the http get response, then decode the json-formatted response.
    var queryUrl = 'https://bocashdelivery.ventis.group/api/liste_livraison?agent_livreur_id=$agent_id';
    if(status!=null) queryUrl +='status=$status';
    var response = await http.get(Uri.parse(queryUrl));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List<Map<String, dynamic>>;
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }

  }


  Future<Map<String, dynamic>> getLivraisonsHistorique() async {
    // Api pour recevoir les données sur les livraisns à effectuer par l'agent
    // https://sfe-fid/demande_livraison


    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse('https://bocashdelivery.ventis.group/api/historique_livraison'),);
    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      var jsonResponseHistorique = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponseHistorique;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  Stream<String> livraisons = (() async* {

    const url = "http://jsonplaceholder.typicode.com/todos/1";
    var dio = Dio();

    final prefs = await SharedPreferences.getInstance();

    var agentCode = prefs.getString('agent_agent');
    var agentId = prefs.getInt('agent_id');

    //Infinite loop is not good, but I have a simple example
    while (true) {
      try {

        var response = await dio.get('https://bocashdelivery.ventis.group/api/liste_livraison?agent_livreur_id=$agentId', queryParameters: {'id': 12, 'name': 'wendu'});

        if (response.statusCode == 200) {

          //remote api data does not change, so i will add a timestamp
          yield response.data.toString() +
              DateTime.now().millisecondsSinceEpoch.toString();

        }

        //Pause of 1 second after each request
        await Future.delayed(const Duration(seconds: 1));

      } catch (e) {
        print(e);
      }
    }
  })();
}