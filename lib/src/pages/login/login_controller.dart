import 'package:d_camaron/src/models/reponse_api.dart';
import 'package:d_camaron/src/providers/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/user.dart';

class LoginController extends GetxController{

  User user = User.fromJson(GetStorage().read('user') ?? {});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage(){
    Get.toNamed('/register');
  }

  //Método que envía la información del formulario al servidor y espera una respuesta
  void login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Get.snackbar("Emial", email);
    // Get.snackbar("Password", password);
    
    if(isValidForm(email, password)){
      ResponseApi responseApi = await usersProvider.login(email, password);
      print("Response Api: ${responseApi.toJson()}");
      
      if(responseApi.success == true){

        GetStorage().write('user', responseApi.data); //DATOS DEL USUARIO
        User myUser = User.fromJson(GetStorage().read('user') ?? {});
        Get.snackbar("Login exitoso", responseApi.message ?? "");
        if(myUser.roles!.length > 1){
          goToRolesPage();
        }else{
          goToClientHomePage();
        }
        //goToHomePage();
        //goToRolesPage();
      } else {
        Get.snackbar("Login fallido", responseApi.message ?? '');
      }
      }
    }
  }
  
  void goToClientHomePage(){
  Get.offNamedUntil('/client/home', (route) => false);
  }

  void goToHomePage(){
    //Get.toNamed('/home');
    Get.offNamedUntil('/home', (route) => false);
  }

void goToRolesPage(){
  //Get.toNamed('/home');
  Get.offNamedUntil('/roles', (route) => false);
}


//Método que valida el formulario
  bool isValidForm(String email, String password){

    if(email.isEmpty){
      Get.snackbar("Formulario no válido", "Debes ingresar el correo electrónico");
      return false;
    }

    if(!GetUtils.isEmail(email)){
      Get.snackbar("Formulario no válido", "El correo electrónico no es válido");
      return false;
    }

    if(password.isEmpty){
      Get.snackbar("Formulario no válido", "Debes ingresar la contraseña");
      return false;
    }

    return true;
  }
