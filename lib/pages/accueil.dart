import 'package:card_swiper/card_swiper.dart';
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
                    Map m = state!;
                    List menus = m['data'];
                    print(menus);
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
                              print("$e:------");
                              id.value = e;
                            },
                            autoplay: true,
                            //autoplayDelay: 2,
                            itemCount: pubs.length,
                            viewportFraction: 0.8,
                            scale: 0.9,
                          ),
                          // child: PageView(
                          //   onPageChanged: (e) {
                          //     print("$e:------");
                          //     id.value = e;
                          //   },
                          //   children: List.generate(
                          //     pubs.length,
                          //     (index) {
                          //       return Container(
                          //         alignment: Alignment.center,
                          //         decoration: BoxDecoration(
                          //           image: DecorationImage(
                          //             image: NetworkImage(
                          //               "${pubs[index]['image']}",
                          //             ),
                          //           ),
                          //         ),
                          //         //child: Text("$index"),
                          //       );
                          //     },
                          //   ),
                          // ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 10,
                          //color: Colors.blue,
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
                      child: Text("Pas de connexion"),
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
                          child: Text("Serveur erreur"),
                        ),
                      );
                    } else {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                          ),
                          child: Text(""),
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
