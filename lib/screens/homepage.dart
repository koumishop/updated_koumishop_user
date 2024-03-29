// ignore_for_file: must_be_immutable
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/main.dart';
import 'package:koumishop/controllers/homepage_controller.dart';
import 'package:koumishop/components/menu/categorie/categorie.dart';
import 'package:koumishop/screens/favorites.dart';
import 'package:koumishop/controllers/cart_controller.dart';
import 'package:koumishop/screens/profile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

RxInt index = 0.obs;
PageController? controllerP = PageController();

class Homepage extends GetView<HomepageController> {
  HomepageController homepageController = Get.put(HomepageController());

  bool show;
  CartController cartController = Get.put(CartController());
  Homepage(this.show, {super.key}) {
    controller.getService1(1);
    var box = GetStorage();
    cartController.itemList.value = box.read("panier") ?? [];
    Timer(const Duration(seconds: 1), () {
      showPopup(c!);
    });
  }

  List listeData = [
    Icons.shopping_basket,
    Icons.fastfood_sharp,
    Icons.local_hospital,
    Icons.mail,
    Icons.nature
  ];
  Widget? vue;
  int t = 0;
  //
  @override
  Widget build(BuildContext context) {
    c = context;
    t++;

    return Container(
      color: Colors.red, // Status bar color
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 137, 147, 1),
                  Color(0x00ffffff),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Obx(
              () => index.value == 0
                  ? controller.obx(
                      (state) {
                        Map m = state!;
                        List menus = m['data'];
                        List pubs = m['pub'];
                        RxInt id = 0.obs;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: Get.size.height / 4,
                              child: Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  return Image.network(
                                    "${pubs[index]['image']}",
                                    fit: BoxFit.fill,
                                  );
                                },
                                onIndexChanged: (e) {
                                  id.value = e;
                                },
                                autoplay: true,
                                itemCount: pubs.length,
                                viewportFraction: 0.8,
                                scale: 0.9,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 10,
                              alignment: Alignment.center,
                              child: Obx(
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    pubs.length,
                                    (index) => Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: id.value == index
                                            ? Colors.red
                                            : Colors.yellow,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(menus.length, (index) {
                                  return SizedBox(
                                    height: 100,
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            var connectivityResult =
                                                await (Connectivity()
                                                    .checkConnectivity());
                                            if (int.parse(menus[index]
                                                    ['is_available']) ==
                                                1) {
                                              if (connectivityResult ==
                                                      ConnectivityResult
                                                          .mobile ||
                                                  connectivityResult ==
                                                      ConnectivityResult.wifi) {
                                                Get.dialog(
                                                  const Material(
                                                    color: Colors.transparent,
                                                    child: Center(
                                                      child: SizedBox(
                                                        height: 50,
                                                        width: 50,
                                                        child:
                                                            CircularProgressIndicator(
                                                          backgroundColor:
                                                              Colors.red,
                                                          strokeWidth: 7,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                                homepageController.getService2(
                                                    menus[index],
                                                    "${menus[index]['id']}");
                                              } else {
                                                Get.snackbar("Connexion",
                                                    "Veuillez vous connecter à internet svp!");
                                              }
                                            } else {
                                              Get.snackbar("Oups",
                                                  "Le service n'est pas disponible");
                                            }
                                          },
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.zero),
                                          ),
                                          child: Categorie(
                                            "${menus[index]['name']}",
                                            "${menus[index]['service_description']}",
                                            listeData[index],
                                            "${menus[index]['illustration']}",
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            )
                          ],
                        );
                      },
                      onEmpty: Center(
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                          ),
                          child: const Text("Pas de connexion"),
                        ),
                      ),
                      onError: (e) {
                        if (e == "serveur") {
                          return Center(
                            child: ElevatedButton(
                              onPressed: () async {},
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                              ),
                              child: const Text("Serveur erreur"),
                            ),
                          );
                        } else {
                          return Center(
                            child: ElevatedButton(
                              onPressed: () async {},
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                              ),
                              child: const Text(""),
                            ),
                          );
                        }
                      },
                      onLoading: const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                            strokeWidth: 7,
                          ),
                        ),
                      ),
                    )
                  : index.value == 1
                      ? Favorites()
                      : const Profile(),
            ),
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              onTap: (e) {
                index.value = e;
              },
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.red,
              currentIndex: index.value,
              items: const [
                BottomNavigationBarItem(
                  activeIcon: Icon(CupertinoIcons.home),
                  icon: Icon(CupertinoIcons.home),
                  label: "Accueil",
                ),
                BottomNavigationBarItem(
                    activeIcon: Icon(Icons.favorite),
                    icon: Icon(Icons.favorite_outline),
                    label: "Favoris"),
                BottomNavigationBarItem(
                    activeIcon: Icon(Icons.person),
                    icon: Icon(Icons.person_outline),
                    label: "Profil"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showPopup(BuildContext context) async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
      'Cookie': 'PHPSESSID=c21f5aeb60575afdffbe8739b0a6722d'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/get-promotion.php'));
    request.fields.addAll({'promotion': '1', 'accesskey': '90336'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      var r = jsonDecode(rep);
      if ("${r['data'][0]['is_available']}" == "1" && show) {
        showDialog(
          context: context,
          builder: (c) {
            return Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  height: Get.size.height / 2,
                  width: Get.size.width / 1.15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            //color: Colors.blue,
                            image: DecorationImage(
                              image: NetworkImage(
                                "${r['data'][0]['illustration']}",
                              ),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(0),
                                child: Align(
                                  alignment: Alignment.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(17)),
                                      child: const Icon(
                                        Icons.close_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                          child: Text(
                            "${r['data'][0]['service_description']}",
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }
}
