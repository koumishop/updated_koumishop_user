import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:koumishop/controllers/profile_controller.dart';

class FavoritesController extends GetxController with StateMixin<List> {
  RxList itemList = [].obs;
  checkProduits() async {
    //
    ProfilController profilController = Get.find();
    //
    itemList = [].obs;
    change(
      [],
      status: RxStatus.loading(),
    );
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://webadmin.koumishop.com/api-firebase/favorites.php'));
    request.fields.addAll({
      'accesskey': '90336',
      'get_favorites': '1',
      'user_id': '${profilController.data['user_id']}',
      'offset': '0',
      'limit': '100'
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      Map r = jsonDecode(rep);

      if (!r['error']) {
        itemList = RxList(r['data']);
        itemList.forEach(((e) => print('liste3: $e')));
        change(
          itemList,
          status: RxStatus.success(),
        );
      } else {
        change(
          [],
          status: RxStatus.empty(),
        );
      }
    } else {
      change(
        [],
        status: RxStatus.empty(),
      );
    }
  }
}
