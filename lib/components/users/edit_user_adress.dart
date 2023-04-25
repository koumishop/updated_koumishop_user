import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/profil/profil_controller.dart';

enum Type { home, work, other }

// ignore: must_be_immutable
class EditAdress extends StatefulWidget {
  State state;
  Map adress;
  EditAdress(this.state, this.adress, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _EditAdress();
  }
}

class _EditAdress extends State<EditAdress> {
  Type choix = Type.home;
  ProfilController profilController = Get.find();
  final _formKey = GlobalKey<FormState>();
  var nomC = TextEditingController();
  var tel1C = TextEditingController();
  var tel2C = TextEditingController();
  var avenueNumC = TextEditingController();
  var pointRepC = TextEditingController();
  saveAdress(Map<String, String> m) async {
    //
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/user-addresses.php'));
    request.fields.addAll(m);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Get.back();
      tel2C.clear();
      avenueNumC.clear();
      pointRepC.clear();
      Timer(const Duration(milliseconds: 500), () {
        Get.back();
        Get.snackbar("Adresse", "Enregistrement éffectué");
        widget.state.setState(() {});
      });
    } else {
      Get.snackbar("Erreur", "Un problème est survenu");
    }
  }

  String c1 = "Kinshasa";
  String idComm = "";
  String c2 = "";
  String idQuart = "";
  List lq = [];
  bool dft = false;
  Map adresse = {};
  List lc = [
    "Kinshasa",
    "Lingwala",
    "Ngaliema",
    "Kintambo",
    "Kalamu",
    "Bumbu",
    "Barumbu",
    "Bandalungwa",
    "Gombe",
  ];
  String q1 = "1";

  @override
  void initState() {
    var box = GetStorage();
    nomC = TextEditingController(text: profilController.infos['name']);
    tel1C = TextEditingController(text: profilController.infos['mobile']);
    adresse = box.read("adresse") ?? {};
    lc = adresse['data'];
    for (var element in lc) {
      if (element['id'] == "${widget.adress["pincode_id"]}") {
        idComm = "${element['pincode']}";
        c1 = element['pincode'];
        lq = element['cities'];
        for (var s in lq) {
          if (s['id'] == "${widget.adress["city_id"]}") {
            c2 = s["name"];
            idQuart = s['id'];
          }
        }
      }
    }

    tel2C.text = "${widget.adress["alternate_mobile"]}";
    avenueNumC.text = "${widget.adress["address"]}";
    pointRepC.text = "${widget.adress["landmark"]}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red, // Status bar color
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 232, 235),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 137, 147, 1),
                  Color(0xFFFFFFFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          //width: 150,
                          height: 40,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: Colors.red,
                              ),
                              Text(
                                "Mettre à jour l'adresse de livraison",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Expanded(
                    flex: 1,
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: <Widget>[
                        TextFormField(
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: "Nom",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Veuillez saisir le nom";
                            }
                            return null;
                          },
                          controller: nomC,
                        ),
                        TextFormField(
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: "Numéro téléphone",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Veuillez saisir le numéro";
                            }
                            return null;
                          },
                          controller: tel1C,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Numéro de téléphone alternatif",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Veuillez saisir le numéro de téléphone alternatif";
                            }
                            return null;
                          },
                          controller: tel2C,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Avenue & Numéro",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Champ vide";
                            }
                            return null;
                          },
                          controller: avenueNumC,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Point de repère",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Champ vide";
                            }
                            return null;
                          },
                          controller: pointRepC,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: SizedBox(
                                height: 50,
                                child: DropdownButton<String>(
                                  value: c1,
                                  isExpanded: true,
                                  items: List.generate(
                                    lc.length,
                                    (index) => DropdownMenuItem<String>(
                                      value: "${lc[index]['pincode']}",
                                      child: Text("${lc[index]['pincode']}"),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      c1 = value as String;
                                      for (var element in lc) {
                                        if (element['pincode'] == c1) {
                                          lq = element['cities'];
                                          c2 = lq.isNotEmpty
                                              ? lq[0]['name']
                                              : "";
                                          idComm = element['id'];
                                        }
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 4,
                              child: idComm.isNotEmpty
                                  ? SizedBox(
                                      height: 50,
                                      child: DropdownButton<String>(
                                        value: c2,
                                        isExpanded: true,
                                        items: List.generate(
                                          lq.length,
                                          (index) => DropdownMenuItem<String>(
                                            value: "${lq[index]['name']}",
                                            child: Text("${lq[index]['name']}"),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            c2 = value as String;
                                            for (var element in lq) {
                                              if (element['name'] == c2) {
                                                idQuart = element['id'];
                                              }
                                            }
                                          });
                                        },
                                      ),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Radio(
                                    value: Type.home,
                                    groupValue: choix,
                                    onChanged: (Type? value) {
                                      setState(() {
                                        choix = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    "MAISON",
                                    style: tx(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Radio(
                                    value: Type.work,
                                    groupValue: choix,
                                    onChanged: (Type? value) {
                                      setState(() {
                                        choix = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    "BUREAU",
                                    style: tx(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Radio(
                                    value: Type.other,
                                    groupValue: choix,
                                    onChanged: (Type? value) {
                                      setState(() {
                                        choix = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    "AUTRE",
                                    style: tx(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Checkbox(
                            value: dft,
                            checkColor: Colors.white,
                            activeColor: Colors.red,
                            onChanged: (e) {
                              setState(() {
                                dft = e as bool;
                              });
                            },
                          ),
                          Text(
                            "Définir comme adresse par défaut",
                            style: tx(),
                          ),
                        ]),
                        const SizedBox(
                          height: 30,
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
                            onPressed: () {
                              Map<String, String> adresse = {
                                'accesskey': '90336',
                                'update_address': '1',
                                'user_id': profilController.infos['user_id'],
                                'name': nomC.text,
                                'mobile': tel1C.text,
                                'alternate_mobile': tel2C.text,
                                'type': choix.name,
                                'address': avenueNumC.text,
                                'country_code': '243',
                                'landmark': pointRepC.text,
                                'pincode_id': idComm,
                                'city_id': idQuart,
                                'is_default': dft ? "0" : "1",
                                'longitude': '0',
                                'latitude': '0',
                                'id': widget.adress["id"],
                              };
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

                              saveAdress(adresse);
                            },
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "MODIFIER ADRESSE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle tx() {
    return TextStyle(
      color: Colors.grey.shade700,
      fontSize: 13,
    );
  }
}
