import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:get/get.dart';
import 'package:koumishop/utils/connexion.dart';

class AutreController extends GetxController {
  Connexion connexion = Connexion();
  //
  getFaq() async {
    //"eKart", "eKart Authentication"
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
        expiresIn: Duration(
          days: 10,
        ),
        noIssueAt: true);
    //
    print('Signed token: $token\n');
    //
    Future<Response> lesFaqs = connexion.getE(
      1,
      "api-firebase/get-faqs.php",
      {"": ""},
      {},
    );
  }
}
