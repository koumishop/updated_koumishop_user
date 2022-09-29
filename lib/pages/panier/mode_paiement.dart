import 'dart:async';
import 'package:get/get.dart';
import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';

class ModePaiement extends StatefulWidget {
  State st;
  ModePaiement(this.st);
  @override
  State<StatefulWidget> createState() {
    return _ModePaiement();
  }
}

class _ModePaiement extends State<ModePaiement> {
  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyleHeader = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  //
  RxBool mode1 = false.obs;
  RxBool mode2 = false.obs;
  RxBool mode3 = false.obs;
  RxBool mode4 = false.obs;
  //
  PanierController panierController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Accordion(
      maxOpenSections: 2,
      headerBackgroundColorOpened: Colors.black54,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      children: [
        AccordionSection(
          isOpen: false,
          leftIcon: const Icon(Icons.money, color: Colors.white),
          headerBackgroundColor: Colors.black,
          headerBackgroundColorOpened: Colors.red,
          header: Text('Paiement à la livraison', style: _headerStyle),
          content: SizedBox(
            height: 50,
            child: CheckboxListTile(
              value: mode1.value,
              title: Text("Paiement à la livraison"),
              onChanged: (e) {
                faire("Paiement à la livraison");
              },
            ),
          ),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        AccordionSection(
          isOpen: false,

          leftIcon: const Icon(Icons.phone_android, color: Colors.white),
          headerBackgroundColor: Colors.black,
          headerBackgroundColorOpened: Colors.red,
          header: Text('Mobile money', style: _headerStyle),
          content: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CheckboxListTile(
                  value: mode2.value,
                  title: const Text("CDF"),
                  onChanged: (e) {
                    faire("Mobile money/CDF");
                  },
                ),
                CheckboxListTile(
                  value: mode3.value,
                  title: const Text("USD"),
                  onChanged: (e) {
                    faire("Mobile money/USD");
                  },
                ),
              ],
            ),
          ),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        AccordionSection(
          isOpen: false,

          leftIcon: const Icon(Icons.paid, color: Colors.white),
          headerBackgroundColor: Colors.black,
          headerBackgroundColorOpened: Colors.red,
          header: Text('Visa - MasterCard Visa', style: _headerStyle),
          content: SizedBox(
            height: 50,
            child: CheckboxListTile(
              value: mode4.value,
              title: const Text("Visa - MasterCard Visa"),
              onChanged: (e) {
                faire("Visa - MasterCard Visa");
              },
            ),
          ),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        )
      ],
    );
  }

  faire(String t) {
    panierController.modeP.value = t;
    Get.back();
    Timer(const Duration(milliseconds: 500), () {
      //
      widget.st.setState(() {});
      //
    });
  }
}
