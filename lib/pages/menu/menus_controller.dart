import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class MenuController extends GetxController with StateMixin<List> {
  Rx vue = Rx(Container());
  RxBool showMiniPanier = RxBool(false);
  RxList listeProduit = [].obs;

  Future<List> getMenu(String subcategory_id) async {
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
      'accesskey': '90336',
      'subcategory_id': subcategory_id,
      'offset': '0',
      'accesskey': '90336',
      'limit': '10',
      ' get_all_products': '1'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      Map map = jsonDecode(rep);
      List l = map["data"] ?? [];
      print("-------:$l");
      change(l, status: RxStatus.success());
      return l;
    } else {
      print(response.reasonPhrase);
      change([], status: RxStatus.empty());
      return [];
    }

    //
    //change([], status: RxStatus.loading());
    // Timer(Duration(seconds: 2), () {
    //   change([], status: RxStatus.success());
    // });
  }
}
