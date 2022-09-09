import 'dart:convert';

import 'package:get/get.dart';
import 'package:koumishop/pages/menu/menu_principale.dart';
import 'package:koumishop/utils/connexion.dart';
import 'package:http/http.dart' as http;

class AccueilController extends GetxController {
  Connexion connexion = Connexion();
  getService(int service) async {
    //
    // var headers = {
    //   'Authorization':
    //       'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    // };
    // var request = http.MultipartRequest(
    //     'POST',
    //     Uri.parse(
    //         'https://webadmin.koumishop.com/api-firebase/get-products.php'));
    // request.fields.addAll({
    //   'accesskey': '90336',
    //   'get_all_products': '1',
    //   'service_id': '$service'
    // });

    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();
    Map rep = await connexion.getElement(
        "https://webadmin.koumishop.com/api-firebase/get-products.php",
        service);
    print(rep);

    if (!rep["error"]) {
      //Map rep = jsonDecode(await response.stream.bytesToString());
      print(rep);
      Get.back();
      Get.to(MenuPrincipal(rep['data']));
    } else {
      //print(response.reasonPhrase);
      Get.back();
    }
  }
}
