import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientHomeController extends GetxController{

  var indexTab = 0.obs;

  //Método que redirige a la pantalla seleccionada
  void changeTab(int index){
    indexTab.value = index;
  }

  void signOut(){
    GetStorage().remove('user');
    //Get.toNamed sólo redirecciona
    Get.offNamedUntil('/', (route) => false); //Elimina todo el historial de pantallas
  }
}
