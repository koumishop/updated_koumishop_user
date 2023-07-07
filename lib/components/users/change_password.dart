import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/controllers/profile_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChangePassword();
  }
}

class _ChangePassword extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final customerCurrentPassword = TextEditingController();
  final customerNewPassword = TextEditingController();
  final customerPassword = TextEditingController();
  var box = GetStorage();

  bool showPw1 = true;
  bool showPw2 = true;
  bool showPw3 = true;

  ProfilController profilController = Get.find();

  changePassword(String password) async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
      'Cookie': 'PHPSESSID=e18e7b41c806a6fdd8d326ffe8750851'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/user-registration.php'));
    request.fields.addAll({
      'password': password,
      'user_id': profilController.data['user_id'],
      'type': 'change-password'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(await response.stream.bytesToString());
      }
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      alignment: Alignment.bottomCenter,
      height: MediaQuery.of(context).viewInsets.bottom == 0
          ? Get.size.height / 1.8
          : MediaQuery.of(context).viewInsets.bottom * 2.3,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Wrap(
          spacing: 5,
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Modifier le mot de passe ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              child: Padding(
                padding: const EdgeInsets.only(),
                child: TextFormField(
                  obscureText: showPw1,
                  decoration: InputDecoration(
                    labelText: "Ancien mot de passe",
                    prefixIcon: const Icon(Icons.lock),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          showPw1 ? showPw1 = false : showPw1 = true;
                        });
                      },
                      child: const Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    String mdp = box.read("mdp");
                    if (value!.isEmpty) {
                      return "Veuillez saisir le mot de passe";
                    } else if (value != mdp) {
                      return "Mot de passe incorrecte";
                    }
                    return null;
                  },
                  controller: customerCurrentPassword,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
                //padding: const EdgeInsets.all(8),
                child: Padding(
              padding: const EdgeInsets.only(),
              child: TextFormField(
                obscureText: showPw2,
                decoration: InputDecoration(
                  labelText: "Nouveau mot de passe",
                  prefixIcon: const Icon(Icons.lock),
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        showPw2 ? showPw2 = false : showPw2 = true;
                      });
                    },
                    child: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Veuillez saisir le mot de passe";
                  } else if (value.length < 8) {
                    return "Mot de passe moin de 8 charactere";
                  }
                  return null;
                },
                controller: customerNewPassword,
              ),
            )),
            const SizedBox(
              height: 20,
            ),
            Material(
              //padding: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.only(),
                child: TextFormField(
                  obscureText: showPw3,
                  decoration: InputDecoration(
                    labelText: "Confirm mot de passe",
                    prefixIcon: const Icon(Icons.lock),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          showPw3 ? showPw3 = false : showPw3 = true;
                        });
                      },
                      child: const Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Veuillez saisir le mot de passe";
                    } else if (value != customerNewPassword.text) {
                      return "Vous n'avez pas saisi le meme mot de passe";
                    }
                    return null;
                  },
                  controller: customerPassword,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.red,
                  ),
                  overlayColor: MaterialStateProperty.all(
                    Colors.red.shade100,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ProfilController profilController = Get.find();
                    Get.dialog(
                      const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                            strokeWidth: 7,
                          ),
                        ),
                      ),
                    );
                    //
                    var headers = {
                      'Authorization':
                          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
                    };
                    var request = http.MultipartRequest(
                        'POST',
                        Uri.parse(
                            'https://webadmin.koumishop.com/api-firebase/user-registration.php'));
                    request.fields.addAll({
                      'accesskey': '90336',
                      'type': 'change-password',
                      'password': customerPassword.text,
                      'user_id': '${profilController.data['user_id']}',
                    });

                    request.headers.addAll(headers);

                    http.StreamedResponse response = await request.send();

                    if (response.statusCode == 200) {
                      Map infos =
                          jsonDecode(await response.stream.bytesToString());
                      infos["mdp"] = customerPassword.text;
                      profilController.data['mdp'] = infos["mdp"];
                      Get.back();
                      if (infos['error']) {
                        Get.snackbar(
                            "Erreur d'authentification", "${infos['message']}");
                      } else {
                        Get.back();
                        Get.snackbar("Succès", "Mot de passe changé");
                        box.write("mdp", customerPassword.text);
                      }
                    } else {
                      Get.back();
                      Get.snackbar("Erreur d'authentification",
                          "${response.reasonPhrase}. Code: ${response.statusCode}");
                    }
                  }
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    "Modifier le mot de passe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom * 1.3,
            ),
          ],
        ),
      ),
      //),
    );
  }
}
