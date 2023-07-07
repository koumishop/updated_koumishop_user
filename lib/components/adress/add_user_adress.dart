import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/controllers/profile_controller.dart';

enum Type { home, work, other }

// ignore: must_be_immutable
class AddAdress extends StatefulWidget {
  State customerAdressState;
  AddAdress(this.customerAdressState, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddAdress();
  }
}

class _AddAdress extends State<AddAdress> {
  Type choice = Type.home;
  ProfilController profilController = Get.find();

  final _formKey = GlobalKey<FormState>();
  var customerName = TextEditingController();
  var customerPhone1 = TextEditingController();
  final customerPhone2 = TextEditingController();
  final roadNumber = TextEditingController();
  final customerAdressRefPoint = TextEditingController();

  saveAdress(Map<String, String> m) async {
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
      customerPhone2.clear();
      roadNumber.clear();
      customerAdressRefPoint.clear();
      Get.back();
      Get.back();
      Get.snackbar("Adresse", "Enregistrement éffectué");
      widget.customerAdressState.setState(() {});
    } else {
      Get.snackbar("Erreur", "Un problème est survenu");
    }
  }

  String city1 = "Kinshasa";
  String municipalityId = "";
  String city2 = "";
  String districtId = "";
  List districtList = [];
  bool defaultAdress = false;
  Map adresse = {};
  List municipalityList = [
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
    customerName = TextEditingController(text: profilController.data['name']);
    customerPhone1 =
        TextEditingController(text: profilController.data['mobile']);
    adresse = box.read("adresse") ?? {};
    municipalityList = adresse['data'];
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
                          height: 40,
                          alignment: Alignment.center,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: Colors.red,
                              ),
                              Text(
                                "Adresse de livraison",
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
                          controller: customerName,
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
                          controller: customerPhone1,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Numéro de téléphone alternatif",
                          ),
                          controller: customerPhone2,
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
                          controller: roadNumber,
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
                          controller: customerAdressRefPoint,
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
                                  value: city1,
                                  isExpanded: true,
                                  items: List.generate(
                                    municipalityList.length,
                                    (index) => DropdownMenuItem<String>(
                                      value:
                                          "${municipalityList[index]['pincode']}",
                                      child: Text(
                                          "${municipalityList[index]['pincode']}"),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      city1 = value as String;
                                      for (var element in municipalityList) {
                                        if (element['pincode'] == city1) {
                                          districtList = element['cities'];
                                          city2 = districtList.isNotEmpty
                                              ? districtList[0]['name']
                                              : "";
                                          districtId = districtList[0]['id'];
                                          municipalityId = element['id'];
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
                              child: municipalityId.isNotEmpty
                                  ? SizedBox(
                                      height: 50,
                                      child: DropdownButton<String>(
                                        value: city2,
                                        isExpanded: true,
                                        items: List.generate(
                                          districtList.length,
                                          (index) => DropdownMenuItem<String>(
                                            value:
                                                "${districtList[index]['name']}",
                                            child: Text(
                                                "${districtList[index]['name']}"),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            city2 = value as String;
                                            for (var element in districtList) {
                                              if (element['name'] == city2) {
                                                districtId = element['id'];
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
                                    groupValue: choice,
                                    onChanged: (Type? value) {
                                      setState(() {
                                        choice = value!;
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
                                    groupValue: choice,
                                    onChanged: (Type? value) {
                                      setState(() {
                                        choice = value!;
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
                                    groupValue: choice,
                                    onChanged: (Type? value) {
                                      setState(() {
                                        choice = value!;
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
                            value: defaultAdress,
                            checkColor: Colors.white,
                            activeColor: Colors.red,
                            onChanged: (e) {
                              setState(() {
                                //
                                defaultAdress = e as bool;
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
                              //
                              if (_formKey.currentState!.validate()) {
                                /**
                               * 
                               */
                                if (districtId != "") {
                                  Map<String, String> adresse = {
                                    'accesskey': '90336',
                                    'add_address': '1',
                                    'user_id': profilController.data['user_id'],
                                    'name': customerName.text,
                                    'mobile': customerPhone1.text,
                                    'alternate_mobile': customerPhone2.text,
                                    'type': choice.name,
                                    'address': roadNumber.text,
                                    'country_code': '243',
                                    'landmark': customerAdressRefPoint.text,
                                    'pincode_id': municipalityId,
                                    'city_id': districtId,
                                    'is_default': defaultAdress ? "0" : "1",
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
                                  //
                                  saveAdress(adresse);
                                } else {
                                  Get.snackbar("Erreur",
                                      "Veuillez selectionner le Quartier");
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "AJOUTER UNE NOUVELLE ADRESSE",
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
