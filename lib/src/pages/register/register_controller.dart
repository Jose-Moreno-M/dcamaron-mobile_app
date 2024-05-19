import 'dart:convert';

import 'package:d_camaron/src/models/user.dart';
import 'package:d_camaron/src/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/reponse_api.dart';


class RegisterController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

UsersProvider usersProvider = UsersProvider();

  void register() async{

    String email = emailController.text.trim();
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if(isValidForm(email, name, lastName, phone, password, confirmPassword)){

      User user = User(
        email: email,
        name: name,
        lastname: lastName,
        phone: phone,
        password: password
      );

      Response response = await usersProvider.create(user);
      debugPrint("RESPONSE REG: ${response.body}");

      if(!response.hasError) {
        //debugPrint("SE REGISTRO? ${response.hasError as String?}");
        Get.snackbar("Fomulario válido", "Bienvenido, $name");

        ResponseApi responseApi = await usersProvider.login(email, password);
        debugPrint("RESPONSE LOG: ${responseApi.toJson()}");

        if (responseApi.success == true) {
          GetStorage().write('user', responseApi.data); //DATOS DEL USUARIO
          Get.snackbar("Registro exitoso", responseApi.message ?? "");
          goToHomePage();
        } else {
          Get.snackbar("Registro fallido", responseApi.message ?? '');
        }
      } else {
        Get.snackbar("ERROR", "Usuario existente, prueba con otro correo electrónico y teléfono");
      }
    }
  }

  void goToHomePage(){
    //Get.toNamed('/home');
    //Get.offNamedUntil('/client/products/list', (route) => false);
    Get.offNamedUntil('/client/home', (route) => false);
  }

  bool isValidForm(
      String email,
      String name,
      String lastName,
      String phone,
      String password, String confirmPassword
      ){

    if(email.isEmpty){
      Get.snackbar("Formulario no válido", "Debes ingresar tu correo electrónico");
      return false;
    } else if(!GetUtils.isEmail(email)){
      Get.snackbar("Formulario no válido", "El correo electrónico no es válido");
      return false;
    }

    if(name.isEmpty){
      Get.snackbar("Formulario no válido", "Debes ingresar tu nombre");
      return false;
    }

    if(lastName.isEmpty){
      Get.snackbar("Formulario no válido", "Debes ingresar tu apellido");
      return false;
    }

    if(phone.isEmpty){
      Get.snackbar("Formulario no válido", "Debes ingresar tu número telefónico");
      return false;
    } else if(!GetUtils.isPhoneNumber(phone)) {
      print (phone.length);
      Get.snackbar("Formulario no válido", "El número telefónico no es válido");
      return false;
    } else if(phone.length != 10){
      Get.snackbar("Formulario no válido", "El número telefónico no es válido");
      return false;
    }

    if(password.isEmpty){
      Get.snackbar("Formulario no válido", "Debes ingresar tu contraseña");
      return false;
    } else if(password.contains(" ")){
      Get.snackbar("Formulario no válido", "La contraseña no debe tener espacios");
      return false;
    }
    
    if(password != confirmPassword){
      Get.snackbar("Formulario no válido", "Las contraseñas no son iguales");
      return false;
    }

    return true;
  }

}