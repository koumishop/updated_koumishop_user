import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
//import 'package:get/get_connect/http/src/request/request.dart';

class Connexion extends GetConnect {
  String first_url = "https://webadmin.koumishop.com";
  // @override
  // void onInit() {
  //   // All request will pass to jsonEncode so CasesModel.fromJson()
  //   httpClient.defaultDecoder = CasesModel.fromJson;
  //   httpClient.baseUrl = 'https://api.covid19api.com';
  //   // baseUrl = 'https://api.covid19api.com'; // It define baseUrl to
  //   // Http and websockets if used with no [httpClient] instance

  //   // It's will attach 'apikey' property on header from all requests
  //   httpClient.addRequestModifier((Request request) {
  //     request.headers['apikey'] = '12345678';
  //     return request;
  //   });

  //   // Even if the server sends data from the country "Brazil",
  //   // it will never be displayed to users, because you remove
  //   // that data from the response, even before the response is delivered
  //   httpClient.addResponseModifier<CasesModel>((request, response) {
  //     CasesModel model = response.body;
  //     if (model.countries.contains('Brazil')) {
  //       model.countries.remove('Brazilll');
  //     }
  //   });

  //   httpClient.addAuthenticator((Request request) async {
  //     final response = await get("http://yourapi/token");
  //     final token = response.body['token'];
  //     // Set the header
  //     request.headers['Authorization'] = "$token";
  //     return request;
  //   });

  //   //Autenticator will be called 3 times if HttpStatus is
  //   //HttpStatus.unauthorized
  //   httpClient.maxAuthRetries = 3;
  // }
  // }

  Future<Response> getE(
    int url,
    String path,
    Map<String, String> headers,
    Map<String, String> query,
  ) async {
    return get(
      "${url == 1 ? first_url : url == 2 ? '' : ''}/$path",
      headers: headers,
      query: query,
    );
  }

  //
  Future<Response> postE(String path, var object) async {
    return post(path, object);
  }

  //
  Future<Response> putE(String path, var object) async {
    return put(path, object);
  }

  //
  Future<Response> deleteE(String path) async {
    return get(path);
  }

  //
  Future<Map> getElement(String url, int service) async {
    //
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    //https://webadmin.koumishop.com/api-firebase/get-products.php
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'accesskey': '90336',
      'get_all_products': '1',
      'service_id': '$service'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map rep = jsonDecode(await response.stream.bytesToString());
      print(rep);
      // Get.back();
      // Get.to(MenuPrincipal(rep['data']));
      return rep;
    } else {
      // print(response.reasonPhrase);
      // Get.back();
      return {};
    }
  }
}
