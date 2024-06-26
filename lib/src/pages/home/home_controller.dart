import 'package:d_camaron/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController{

  User user = User.fromJson(GetStorage().read('user') ?? {});

  HomeController(){
    print("Usuario de la sesión: ${user.toJson()}");
  }

  void signOut(){
    GetStorage().remove('user');
    //Get.toNamed sólo redirecciona
    Get.offNamedUntil('/', (route) => false); //Elimina todo el historial de pantallas
  }
}