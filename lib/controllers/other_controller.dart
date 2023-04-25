import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:get/get.dart';
import 'package:koumishop/utils/connexion.dart';

class OtherController extends GetxController {
  Connexion connexion = Connexion();
  getFaq() async {
    final jwt = JWT(
      {
        'id': 123,
        'server': {
          'id': '3e4fc296',
          'loc': 'euw-2',
        }
      },
      subject: "eKart Authentication",
      issuer: 'eKart',
    );
    // Sign it (default with HS256 algorithm)
    var token = jwt.sign(SecretKey('1234567890'),
        expiresIn: const Duration(
          days: 10,
        ),
        noIssueAt: true);
    Future<Response> lesFaqs = connexion.getE(
      1,
      "api-firebase/get-faqs.php",
      {"": ""},
      {},
    );
  }
}
