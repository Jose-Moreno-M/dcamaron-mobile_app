import 'package:d_camaron/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProfileInfoPage extends StatelessWidget {
  ClientProfileInfoController controller = Get.put(ClientProfileInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => controller.signOut(),
              child: Text(
                  'Sgn out',
                  style: TextStyle(
                    color: Colors.black
                  ),
              ),
            ),
            ElevatedButton(
              onPressed: () => controller.goToRoles(),
              child: Text(
                  'Select rol',
                  style: TextStyle(
                    color: Colors.black
                  ),
              ),
            ),

          ],
        ),
      )
    );;
  }
}


