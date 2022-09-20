import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/profil/profil_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangeMdp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangeMdp();
  }
}

class _ChangeMdp extends State<ChangeMdp> {
  //

  final _formKey = GlobalKey<FormState>();

  final pwAc = TextEditingController();
  //
  final pwNC = TextEditingController();
  //
  final pwC = TextEditingController();
  //
  var box = GetStorage();

  bool showPw1 = true;

  bool showPw2 = true;

  bool showPw3 = true;
  //
  ProfilController profilController = Get.find();
  //
  changeMDP(String mdp) async {
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
      'password': mdp,
      'user_id': profilController.infos['user_id'],
      'type': 'change-password'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      alignment: Alignment.bottomCenter,
      height: MediaQuery.of(context).viewInsets.bottom == 0
          ? Get.size.height / 1.8
          : MediaQuery.of(context).viewInsets.bottom * 2.3,
      // Get.size.height / 1.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      //child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Wrap(
          //mainAxisAlignment: MainAxisAlignment.end,

          spacing: 5,
          children: <Widget>[
            const Text(
              "Modifier le mot de passe ?",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              //padding: const EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.only(
                    //bottom: MediaQuery.of(context).viewInsets.bottom / 7,
                    ),
                child: TextFormField(
                  obscureText: showPw1,
                  decoration: InputDecoration(
                    labelText: "Ancien mot de passe",
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    prefixIcon: Icon(Icons.lock),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          showPw1 ? showPw1 = false : showPw1 = true;
                        });
                      },
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Veuillez saisir le mot de passe";
                    } else if (value != profilController.infos['mdp']) {
                      return "Mot de passe incorrecte";
                    }
                    return null;
                  },
                  controller: pwAc,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
                //padding: const EdgeInsets.all(8),
                child: Padding(
              padding: EdgeInsets.only(
                  //bottom: MediaQuery.of(context).viewInsets.bottom / 1,
                  ),
              child: TextFormField(
                obscureText: showPw2,
                decoration: InputDecoration(
                  labelText: "Nouveau mot de passe",
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  prefixIcon: Icon(Icons.lock),
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        showPw2 ? showPw2 = false : showPw2 = true;
                      });
                    },
                    child: Icon(
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
                controller: pwNC,
              ),
            )),
            const SizedBox(
              height: 20,
            ),
            Material(
              //padding: const EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.only(
                    //bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                child: TextFormField(
                  obscureText: showPw3,
                  decoration: InputDecoration(
                    labelText: "Confirm mot de passe",
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    prefixIcon: Icon(Icons.lock),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          showPw3 ? showPw3 = false : showPw3 = true;
                        });
                      },
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Veuillez saisir le mot de passe";
                    } else if (value != pwNC.text) {
                      return "Vous n'avez pas saisi le meme mot de passe";
                    }
                    return null;
                  },
                  controller: pwC,
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
                  //
                  final fcmToken = await FirebaseMessaging.instance.getToken();
                  //
                  ProfilController profilController = Get.find();
                  //
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
                    'password': pwC.text,
                    'user_id': '${profilController.infos['user_id']}',
                  });

                  request.headers.addAll(headers);

                  http.StreamedResponse response = await request.send();

                  if (response.statusCode == 200) {
                    Map infos =
                        jsonDecode(await response.stream.bytesToString());
                    infos["mdp"] = pwC.text;
                    print("$infos");
                    //

                    //
                    profilController.infos.value = infos;
                    //
                    box.write("profile", infos);
                    //
                    // Get.back();
                    // Get.back();
                    // Get.snackbar("Succès", "Mot de passe changé");
                    Get.back();
                    if (infos['error']) {
                      Get.snackbar(
                          "Erreur d'authentification", "${infos['message']}");
                    } else {
                      Get.back();
                      Get.snackbar("Succès", "Mot de passe changé");
                    }
                    //Timer(Duration(seconds: 1), () {
                    //
                    //widget.state!.setState(() {});
                    //});
                    // showDialog(
                    //     context: context,
                    //     builder: (c) {
                    //       return Material(
                    //         child: ListView(
                    //           children: [
                    //             Text("$infos"),
                    //           ],
                    //         ),
                    //       );
                    //     });

                  } else {
                    print(response.reasonPhrase);
                    Get.back();
                    Get.snackbar("Erreur d'authentification",
                        "${response.reasonPhrase}. Code: ${response.statusCode}");
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
