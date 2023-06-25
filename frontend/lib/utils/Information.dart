import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prueba/constants.dart';
import 'package:prueba/models/User.dart';

class Api {
  static Future<User> getUserData(String token) async {
    var url = Uri.parse(APIUSER);
    print("imprimiendo token");
    print(token);
    var headers = {"Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      // La solicitud fue exitosa, puedes obtener la respuesta
      var responseData = jsonDecode( response.body);
      
      return User.fromJson(responseData['user']);
    } else {
      print(response.body);
      // Ocurrió un error en la solicitud
      throw Exception('No es posible cargar los datos del usuario.');
    }
  }

  static Future<String> postVisit(String token, Map<String, dynamic> reqParams) async{
    var uri = Uri.parse(APIPOSTVISIT);
    var response = await http.post((uri)
    .replace(queryParameters: reqParams),headers: {"Content-Type": "application/json",
                      "Authorization": 'Bearer $token'
            });
    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['qr_id'];
    }else{
      print("Error al registrar visita");
      throw Exception('No es posible registrar visita.');
    }
}
  
}
