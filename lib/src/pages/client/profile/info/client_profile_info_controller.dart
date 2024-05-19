import 'package:d_camaron/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientProfileInfoController extends GetxController{
  User user = User.fromJson(GetStorage().read('user') ?? {});

  void signOut(){
    GetStorage().remove('user');
    GetStorage().remove('shopping_bag');
    //Get.toNamed sólo redirecciona
    Get.offNamedUntil('/', (route) => false); //Elimina todo el historial de pantallas
  }

  void goToRoles(){
    Get.offNamedUntil('/roles', (route) => false);
  }
}