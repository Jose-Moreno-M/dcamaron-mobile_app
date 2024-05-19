import 'package:d_camaron/src/models/Rol.dart';
import 'package:d_camaron/src/pages/roles/roles_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:d_camaron/src/models/Rol.dart';

class RolesPage extends StatelessWidget {

  //Se instancia al controlador de la pantalla
  RolesController controller = Get.put(RolesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El appbar es la barra de arriba ne la pantalla
      appBar: AppBar(
        title: Text(
            "Selecciona el rol",
            style: TextStyle(
              color: Colors.black
            ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.20),
        //Se leen los roles que tenga el controlador para mostrar sólo los que
        // el usuario tenga
        child: ListView(
          children: controller.user.roles != null
              ? controller.user.roles!.map((Rol rol) {
                return _cardRol(rol);
              }).toList()
              : [],
        ),
      ),
    );
  }

  //Representa la imagen perteneciente cada rol
  Widget _cardRol(Rol rol){
    return GestureDetector(
      onTap: () => controller.goToPageRol(rol),
      child: Column(
        children: [
          Container(
            height: 100,
            child: FadeInImage(
              //Se llama a una imagen en internet
              image: NetworkImage(rol.image!),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage("assets/img/no-image.jpg"),
            ),
          ),
          Text(
            rol.name ?? "",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

}

