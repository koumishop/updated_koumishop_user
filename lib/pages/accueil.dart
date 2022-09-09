import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/pages/accueil_controller.dart';
import 'package:koumishop/pages/categorie/categorie.dart';
import 'package:koumishop/pages/favorits/favorit.dart';
import 'package:koumishop/pages/menu/menu_principale.dart';
import 'package:koumishop/pages/profil/profil.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

RxInt index = 0.obs;
PageController? controllerP;

class Accueil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Accueil();
  }
}

class _Accueil extends State<Accueil> {
  //
  AccueilController accueilController = Get.find();

  @override
  void initState() {
    //
    controllerP = PageController();
    //
    vue = Container();
    //
    super.initState();
  }

  //
  Widget? vue;
  //
  @override
  Widget build(BuildContext context) {
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
                  Color(0xFFFFFFFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: PageView(
              controller: controllerP,
              onPageChanged: (e) {
                index.value = e;
                print(e);
              },
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {
                          // I am connected to a mobile network.
                          // I am connected to a wifi network.
                          Get.dialog(
                            const Material(
                              color: Colors.transparent,
                              child: Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.red,
                                    strokeWidth: 7,
                                  ),
                                ),
                              ),
                            ),
                          );
                          //
                          accueilController.getService(1);
                          //
                        } else {
                          Get.snackbar("Connexion",
                              "Veuillez vous connecter à internet svp!");
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child:
                          Categorie("Koumi Market", "", Icons.shopping_basket),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {
                          // I am connected to a mobile network.
                          // I am connected to a wifi network.
                          Get.dialog(
                            const Material(
                              color: Colors.transparent,
                              child: Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.red,
                                    strokeWidth: 7,
                                  ),
                                ),
                              ),
                            ),
                          );
                          //
                          accueilController.getService(2);
                          //
                        } else {
                          Get.snackbar("Connexion",
                              "Veuillez vous connecter à internet svp!");
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Categorie("Koumi Food",
                          "Table dressée avec viande", Icons.fastfood_sharp),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {
                          // I am connected to a mobile network.
                          // I am connected to a wifi network.
                          Get.dialog(
                            const Material(
                              color: Colors.transparent,
                              child: Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.red,
                                    strokeWidth: 7,
                                  ),
                                ),
                              ),
                            ),
                          );
                          //
                          accueilController.getService(3);
                          //
                        } else {
                          Get.snackbar("Connexion",
                              "Veuillez vous connecter à internet svp!");
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Categorie("Koumi Pharma", "Acheter vos produits",
                          Icons.local_hospital),
                    ),
                  ],
                ),
                Favorit(),
                Profil(),
              ],
            ),
          ),
          // body: Obx(() {
          //   if (index.value == 0) {
          //     return Categorie();
          //   } else if (index.value == 1) {
          //     return MenuPrincipal();
          //   } else {
          //     return Profil();
          //   }
          // }),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              onTap: (e) {
                //
                index.value = e;
                //
                controllerP!.animateToPage(
                  e,
                  duration: const Duration(seconds: 1),
                  curve: Curves.ease,
                );
                //   curve: Curves.ease,);
                //controller!.jumpTo(double.parse("$e")); //
                // controller!.nextPage(
                //   duration: Duration(seconds: 1),
                //   curve: Curves.ease,
                // );
                print(double.parse("$e"));
                //
              },
              //fixedColor: Colors.grey,
              unselectedItemColor: Colors.grey,
              //backgroundColor: Colors.grey,
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
                    label: "Favorit"),
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
}
