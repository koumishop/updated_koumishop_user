import 'dart:async';

import 'package:get/get.dart';

class MenuController extends GetxController with StateMixin<List> {
  getMenu(String type) {
    change([], status: RxStatus.loading());
    Timer(Duration(seconds: 2), () {
      change([], status: RxStatus.success());
    });
  }
}
