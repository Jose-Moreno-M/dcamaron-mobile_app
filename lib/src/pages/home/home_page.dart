import 'package:d_camaron/src/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("CERRAR SESIÓN"),
          onPressed: () => controller.signOut(),
        ),
      ),
    );
  }
}
