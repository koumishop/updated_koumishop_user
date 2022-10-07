import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:koumishop/pages/menu/menu_principale.dart';
import 'package:koumishop/utils/connexion.dart';
import 'package:http/http.dart' as http;

class AccueilController extends GetxController with StateMixin<Map> {
  Connexion connexion = Connexion();
  getService2(Map service, String id) async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
      'Cookie': 'PHPSESSID=dd5ada4e6fec6b4f1a8dce91317ae0d2'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/get-service-data.php'));
    request.fields.addAll({
      'accesskey': '90336',
      'service_id': id,
      'get_category_by_service': '1'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map rep = jsonDecode(await response.stream.bytesToString());
      print(rep["data"]);
      Get.back();
      Get.to(MenuPrincipal(rep["data"]));
    } else {
      print(response.reasonPhrase);
      Get.back();
      Get.snackbar("Serveur erreur",
          "un problème est survenu code d'erreur: ${response.statusCode}");
    }
    //
  }

  getService1(int service) async {
    ////////
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network. // I am connected to a wifi network.

      ////////
      var headers = {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
        'Cookie': 'PHPSESSID=dd5ada4e6fec6b4f1a8dce91317ae0d2'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://webadmin.koumishop.com/api-firebase/get-service-data.php'));
      request.fields.addAll({
        'accesskey': '90336',
        'all_service': '1',
        'get_category_by_service': '1'
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        Map rep = jsonDecode(await response.stream.bytesToString());
        //print(rep);
        // change({
        //   "data": rep['data'],
        // }, status: RxStatus.success());
        getPub(rep['data']);
      } else {
        print(response.reasonPhrase);
        change({}, status: RxStatus.error("serveur"));
      }
    } else {
      change({}, status: RxStatus.error("connexion"));
    }
  }

  getPub(var data) async {
    //
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
      'Cookie': 'PHPSESSID=a6b5f863201f275ee9536f9940068ac5'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/slider-images.php'));
    request.fields.addAll({'get-slider-images': '1', 'accesskey': '90336'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String d = await response.stream.bytesToString();
      Map map = jsonDecode(d);
      print(map);
      //
      change({
        "data": data,
        "pub": map['data'],
      }, status: RxStatus.success());
      //
    } else {
      print(response.reasonPhrase);
    }
  }
}
/**
 * 

 */