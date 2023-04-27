import 'dart:async';
import 'package:get/get.dart';
import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:koumishop/controllers/cart_controller.dart';

// ignore: must_be_immutable
class PaymentMethod extends StatefulWidget {
  State st;
  PaymentMethod(this.st, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _PaymentMethod();
  }
}

class _PaymentMethod extends State<PaymentMethod> {
  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  RxBool mode1 = false.obs;
  RxBool mode2 = false.obs;
  RxBool mode3 = false.obs;
  RxBool mode4 = false.obs;
  CartController cartController = Get.find();

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
          header: Text('Paiement cash', style: _headerStyle),
          content: SizedBox(
            height: 50,
            child: CheckboxListTile(
              value: mode1.value,
              title: const Text("Paiement cash"),
              onChanged: (e) {
                faire("Paiement cash");
              },
            ),
          ),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
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
        )
      ],
    );
  }

  faire(String t) {
    cartController.paymentMethod.value = t;
    Get.back();
    Timer(const Duration(milliseconds: 500), () {
      widget.st.setState(() {});
    });
  }
}
