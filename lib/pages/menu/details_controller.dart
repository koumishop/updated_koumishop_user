import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailsController extends GetxController {
  //
  Future<List> getSimilaire(String id, String idProduit) async {
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
      'category_id': id,
      ' accesskey': '90336',
      'user_id': '',
      'product_id': idProduit,
      'limit': '10',
      'get_similar_products': '1'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      Map map = jsonDecode(rep);
      List l = map["data"] ?? [];
      print("-------:$l");
      if (l.isEmpty) {
        return [];
      } else {
        return l; //(l, status: RxStatus.success());
      }
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }

  //
  Future<List> getComplementaire(String id, String idProduit) async {
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
      ' get_complementary_products': '1',
      ' category_id': id,
      'accesskey': '90336',
      'user_id': '',
      'product_id': idProduit,
      'limit': '10'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      Map map = jsonDecode(rep);
      List l = map["data"] ?? [];
      print("-------:$l");
      if (l.isEmpty) {
        return [];
      } else {
        return l; //(l, status: RxStatus.success());
      }
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }
}
