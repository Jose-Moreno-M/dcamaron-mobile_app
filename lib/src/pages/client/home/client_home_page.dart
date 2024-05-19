import 'package:d_camaron/src/pages/client/orders/list/client_orders_list_page.dart';
import 'package:d_camaron/src/pages/client/products/list/client_products_list_page.dart';
import 'package:d_camaron/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:d_camaron/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:d_camaron/src/utils/custom_animated_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'client_home_controller.dart';

class ClientHomePage extends StatelessWidget {
  ClientHomeController controller =
      Get.put(ClientHomeController());

  //Construcción de la pantalla, esta pantalla es sólo el bottom bar para navegar
  //entre distintas pantallas.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx(
          () => IndexedStack(
            index: controller.indexTab.value,
            children: [
              ClientProductsListPage(),
              ClientOrdersListPage(),
              ClientProfileInfoPage()
            ],
          ),
        ));
  }


  //Aquí es creado el bottom bar.
  Widget _bottomBar() {
    return Obx(() => CustomAnimatedBottomBar(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      containerHeight: 70,
      backgroundColor: Colors.lightBlue,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      selectedIndex: controller.indexTab.value,
      onItemSelected: (index) => controller.changeTab(index),
      items: [
        BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text("Productos"),
            activeColor: Colors.white,
            inactiveColor: Colors.black),
        BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Mis pedidos"),
            activeColor: Colors.white,
            inactiveColor: Colors.black),
        BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text("Perfil"),
            activeColor: Colors.white,
            inactiveColor: Colors.black),
      ],
    )
    );
  }
}
