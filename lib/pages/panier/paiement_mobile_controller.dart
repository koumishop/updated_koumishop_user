import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaiementMobileController extends GetxController {
  verificationCommande() async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://koumishop.com/pay/traitement.ajax.php?phone=243815824641&reference=10'));
    request.fields.addAll({
      'promotion': '1',
      'accesskey': '90336',
      'mobile': '813999922',
      ' type': 'verify-user'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      Map r = jsonDecode(rep);
      if (r['error']) {
        //Pas cool
        Get.snackbar("Erreur", "${r['message']}");
      } else {
        //Cool commande...

      }
      print(r);
    } else {
      print(response.reasonPhrase);
    }
  }
}
