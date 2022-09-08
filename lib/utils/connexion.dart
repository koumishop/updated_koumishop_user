import 'package:get/get.dart';

class Connexion extends GetConnect {
  Future<Response> getE(String path) async {
    return get(path);
  }

  //
  Future<Response> postE(String path, var object) async {
    return post(path, object);
  }

  //
  Future<Response> putE(String path, var object) async {
    return put(path, object);
  }

  //
  Future<Response> deleteE(String path) async {
    return get(path);
  }
  //

}
