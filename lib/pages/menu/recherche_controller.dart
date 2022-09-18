import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RechercheController extends GetxController with StateMixin<List> {
  getRecherche(String text) async {
    //
    change([], status: RxStatus.loading());
    //
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/get-products.php'));
    request.fields.addAll({
      'search': text,
      ' offset': '0',
      'accesskey': '90336',
      'service_id': '1',
      'limit': '10',
      'get_all_products': '1'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      Map map = jsonDecode(rep);
      List l = map["data"] ?? [];
      print("-------:$l");
      if (l.isEmpty) {
        change(l, status: RxStatus.empty());
      } else {
        change(l, status: RxStatus.success());
      }
    } else {
      print(response.reasonPhrase);
      change([], status: RxStatus.empty());
    }
  }
}
