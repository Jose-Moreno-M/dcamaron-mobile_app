import 'package:d_camaron/src/pages/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  //Se instancia al controlador de la pantalla
  RegisterController controller = Get.put(RegisterController());

  //Dibujado de la pantalla completa
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
            children: [
              _backgroundCover(context),
              _boxForm(context),
              _imageUser(context),
              _buttonBack(),
            ],
          ),
        ),
    );
  }

  Widget _backgroundCover(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.lightBlue,
    );
  }

  //Se crea el formulario
  Widget _boxForm(BuildContext context){
    return Container(
      //height: MediaQuery.of(context).size.height * 0.65,
      //padding: EdgeInsets.all(0),
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height*0.30,
          left: 50,
          right: 50,
          bottom: 50
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
          _textFieldName(),
          _textFieldLastName(),
          _textFieldPhone(),
          _textFieldPassword(),
          _textFieldConfirmPassword(),
          _buttonRegister()
        ],
      ),
    );
  }

  Widget _textYourInfo (){
    return Container(
      margin: EdgeInsets.only(
          top: 40, bottom: 35
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
        decoration: const InputDecoration(
            hintText: "Correo electrónico",
            prefixIcon: Icon(Icons.email)
        ),
      ),
    );
  }

  Widget _textFieldName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.nameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: "Nombre",
            prefixIcon: Icon(Icons.person)
        ),
      ),
    );
  }

  Widget _textFieldLastName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.lastNameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: "Apellido",
            prefixIcon: Icon(Icons.person)
        ),
      ),
    );
  }

  Widget _textFieldPhone(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.phoneController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
            hintText: "Teléfono",
            prefixIcon: Icon(Icons.phone)
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
        decoration: const InputDecoration(
          hintText: "Contraseña",
          prefixIcon: Icon(Icons.lock),
        ),
      ),
    );
  }

  Widget _textFieldConfirmPassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.confirmPasswordController,
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "Confirmar contraseña",
          prefixIcon: Icon(Icons.lock),
        ),
      ),
    );
  }

  Widget _buttonRegister(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => controller.register(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            "REGISTRARSE",
            style: TextStyle(
                color: Colors.black
            ),
          )
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

  Widget _imageUser(BuildContext context){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top:30, bottom: 25),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => {},
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/img/user_profile.jpg'),
            radius: 60,
          ),
        )
      ),
    );
  }

  Widget _buttonBack(){
    return SafeArea(
        child: Container(
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )
          ),
        )
    );
  }
}
