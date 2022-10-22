import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:koumishop/pages/profil/profil_controller.dart';

class FavoritController extends GetxController with StateMixin<List> {
  RxList listeDeElement = [].obs;
  //
  checkProduits(String ps, List listeE) async {
    //
    ProfilController profilController = Get.find();
    //
    listeDeElement = [].obs;
    //
    change(
      [],
      status: RxStatus.loading(),
    );
    //
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://webadmin.koumishop.com/api-firebase/favorites.php'));
    request.fields.addAll({
      'accesskey': '90336',
      'get_favorites': '1',
      'user_id': '${profilController.infos['user_id']}',
      'offset': '0',
      'limit': '100'
    });
    print('id: ${profilController.infos['user_id']}');

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      Map r = jsonDecode(rep);

      if (!r['error']) {
        listeDeElement = RxList(r['data']);
        // print('liste0: $ln');
        // for (var i = 0; i < ln.length; i++) {
        //   print('liste1: $i');
        //   for (var x = 0; x < listeE.length; x++) {
        //     print(
        //         'liste2: $x == ${listeE[x]['product_variant_id'] == ln[i]['id']}');
        //     print(
        //         'liste2: $x == ${listeE[x]['product_variant_id']} == ${ln[i]['id']}');
        //     if (listeE[x]['id'] == ln[i]['id']) {
        //       listeE[x]['id'] = ln[i]['id'];
        //       listeE[x]['price'] = ln[i]['price'];
        //       listeE[x]['stock'] = ln[i]['stock'];
        //       listeE[x]['serve_for'] = ln[i]['serve_for'];
        //       if (int.parse(listeE[x]['nombre']) > int.parse(ln[i]['stock'])) {
        //         listeE[x]['nombre'] = "1";
        //       }
        //       listeDeElement.add(listeE[x]);
        //     }
        //   }
        // }
        //
        //
        print('liste3: $listeDeElement');
        change(
          listeDeElement,
          status: RxStatus.success(),
        );
      } else {
        print('lll: $r');
        change(
          [],
          status: RxStatus.empty(),
        );
      }
    } else {
      print(response.reasonPhrase);
      change(
        [],
        status: RxStatus.empty(),
      );
    }
  }
  //
}
