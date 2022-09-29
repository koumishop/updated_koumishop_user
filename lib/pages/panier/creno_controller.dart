import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CrenoHoraireController extends GetxController with StateMixin<List> {
  getCrenoHoraire() async {
    //
    change([], status: RxStatus.loading());
    //
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://webadmin.koumishop.com/api-firebase/settings.php'));
    request.fields.addAll({'accesskey': '90336', 'get_time_slots': '1'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map rep = jsonDecode(await response.stream.bytesToString());
      print(rep);
      List l = rep['time_slots'] ?? [];
      change(l, status: RxStatus.success());
    } else {
      change([], status: RxStatus.empty());
      print(response.reasonPhrase);
    }
  }
}
