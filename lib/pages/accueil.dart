import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/pages/categorie/categorie.dart';
import 'package:koumishop/pages/favorits/favorit.dart';
import 'package:koumishop/pages/menu/menu_principale.dart';
import 'package:koumishop/pages/profil/profil.dart';

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
          body: PageView(
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
                    onPressed: () {
                      Get.to(MenuPrincipal());
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                    child: Categorie(
                        "Koumi Market", "", CupertinoIcons.cart_badge_minus),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                    child: Categorie("Koumi Food", "Table dressée avec viande",
                        Icons.fastfood_sharp),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                    child: Categorie("Koumi Pharma", "Acheter vos produits",
                        CupertinoIcons.add_circled_solid),
                  ),
                ],
              ),
              Favorit(),
              Profil(),
            ],
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
