import 'package:d_camaron/src/pages/client/products/list/client_products_list_page.dart';
import 'package:d_camaron/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:d_camaron/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:d_camaron/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:d_camaron/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:d_camaron/src/utils/custom_animated_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'restaurant_home_controller.dart';

class RestaurantHomePage extends StatelessWidget {
  RestaurantHomeController controller =
      Get.put(RestaurantHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx(
          () => IndexedStack(
            index: controller.indexTab.value,
            children: [
              RestaurantOrdersListPage(),
              RestaurantCategoriesCreatePage(),
              RestaurantProductsCreatePage(),
              ClientProfileInfoPage(),
            ],
          ),
        ));
  }

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
            icon: Icon(Icons.list),
            title: Text("Pedidos"),
            activeColor: Colors.white,
            inactiveColor: Colors.black),
        BottomNavyBarItem(
            icon: Icon(Icons.category),
            title: Text("Categorías"),
            activeColor: Colors.white,
            inactiveColor: Colors.black),
        BottomNavyBarItem(
            icon: Icon(Icons.fastfood),
            title: Text("Productos"),
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
