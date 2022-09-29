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

class Accueil extends GetView<AccueilController> {
  //
  AccueilController accueilController = Get.find();
  //
  Accueil() {
    controllerP = PageController();
    controller.getService1(1);
  }
  //
  List listeData = [
    Icons.shopping_basket,
    Icons.fastfood_sharp,
    Icons.local_hospital,
    Icons.mail,
    Icons.nature
  ];

  // @override
  // void initState() {
  //   //
  //   controllerP = PageController();
  //   //
  //   accueilController.getService1(1);
  //   //
  //   vue = Container();
  //   //
  //   super.initState();
  // }

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
                  Color(0xFFFFFF),
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
                controller.obx(
                  (state) {
                    List menus = state!;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Card(
                        //   elevation: 1,
                        //   child: SizedBox(
                        //     height: Get.size.height / 4,
                        //   ),
                        // ),
                        // Container(
                        //   height: 10,
                        //   color: Colors.red,
                        // ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(menus.length, (index) {
                              return SizedBox(
                                height: 90,
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        var connectivityResult =
                                            await (Connectivity()
                                                .checkConnectivity());
                                        print(menus[index]['is_available']);
                                        if (int.parse(
                                                menus[index]['is_available']) ==
                                            1) {
                                          if (connectivityResult ==
                                                  ConnectivityResult.mobile ||
                                              connectivityResult ==
                                                  ConnectivityResult.wifi) {
                                            // I am connected to a mobile network.
                                            // I am connected to a wifi network.
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
                                            //
                                            //Get.to(MenuPrincipal(service));
                                            accueilController.getService2(
                                                menus[index],
                                                "${menus[index]['id']}");
                                            //
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
                      child: Categorie(
                        "Reessayez",
                        "Pas d'information",
                        Icons.cloud_off_outlined,
                      ),
                    ),
                  ),
                  onError: (e) {
                    if (e == "serveur") {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                          ),
                          child: Categorie(
                            "Erreur au serveur",
                            "Un problème est survenu veuillez reessayer",
                            Icons.cloud_off_outlined,
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                          ),
                          child: Categorie(
                            "Connexion internet",
                            "Connectez-vous et reessayer",
                            Icons.cloud_off_outlined,
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Text("Erreur à cause de $e"),
                    );
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
