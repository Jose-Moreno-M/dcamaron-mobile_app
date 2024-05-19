
import 'dart:ffi';

import 'package:d_camaron/src/pages/login/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {

  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      SingleChildScrollView(
        child: Stack(
          children: [
            _backgroundCover(context),
            _boxForm(context),
            Column(
              children: [
                _imageCover(context),
                _textAppName(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: _textDontHaveAccount(),
      ),
    );
  }

  Widget _textAppName(){
    return Text(
        "TACO FISH D' CAMARÓN Y MÁS",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
    );
  }

  //Se llama a la imagen de logo desde los assets del proyecto
  Widget _imageCover(BuildContext context){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top:25, bottom: 25),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/img/logo.png',
          //width: MediaQuery.of(context).size.width*0.5,
          //width: 130,
          height: 130,

        ),
      ),
    );
  }

  Widget _backgroundCover(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.lightBlue,
    );
  }

  //Texto en el que se puede ir a la pantalla de registro
  Widget _textDontHaveAccount (){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            "¿No tienes cuenta?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17
            ),
        ),
        SizedBox(width: 7,),
        GestureDetector(
          onTap: () => controller.goToRegisterPage(),
          child: Text(
              "Regístrate aquí.",
              style: TextStyle(
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),
          ),
        ),
      ],
    );
  }


  //Construcción del formulario
  Widget _boxForm(BuildContext context){
    return Container(
      //height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height*0.35,
          left: 50,
          right: 50
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0, 0.75)
          )
        ]
      ),
      child: Column(
        children: [
          _textYourInfo(),
          _textFieldEmail(),
          _textFieldPassword(),
          _buttonLogin()
        ],
      ),
    );
  }

  Widget _textYourInfo (){
    return Container(
      margin: EdgeInsets.only(
        top: 40, bottom: 45
      ),
      child: const Text(
        "INGRESA TU INFORMACIÓN",
        style: TextStyle(
          color: Colors.black
        ),
      ),
    );
  }

  Widget _textFieldEmail(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Correo electrónico",
          prefixIcon: Icon(Icons.email)
        ),
      ),
    );
  }

  Widget _textFieldPassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.passwordController,
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: InputDecoration(
            hintText: "Contraseña",
            prefixIcon: Icon(Icons.lock),
        ),
      ),
    );
  }

  Widget _buttonLogin(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => controller.login(),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            "LOGIN",
            style: TextStyle(
              color: Colors.black
            ),
          )
      ),
    );
  }
}
