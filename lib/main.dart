import 'package:d_camaron/src/models/user.dart';
import 'package:d_camaron/src/pages/client/home/client_home_page.dart';
import 'package:d_camaron/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:d_camaron/src/pages/client/orders/list/client_orders_list_page.dart';
import 'package:d_camaron/src/pages/client/orders/pay/client_orders_pay_page.dart';
import 'package:d_camaron/src/pages/client/payments/create/client_payments_create_page.dart';
import 'package:d_camaron/src/pages/client/products/list/client_products_list_page.dart';
import 'package:d_camaron/src/pages/home/home_page.dart';
import 'package:d_camaron/src/pages/login/login_page.dart';
import 'package:d_camaron/src/pages/register/register_page.dart';
import 'package:d_camaron/src/pages/restaurant/home/restaurant_home_page.dart';
import 'package:d_camaron/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:d_camaron/src/pages/roles/roles_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/pages/client/orders/detail/client_orders_detail_page.dart';
import 'src/pages/restaurant/orders/detail/restaurant_orders_detail_page.dart';

User userSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Usuario ID: ${userSession.id}");
    return GetMaterialApp(
      theme: ThemeData(
        // useMaterial3: true,
        primaryColor: Colors.lightBlue,
        colorScheme: const ColorScheme(
          primary: Colors.lightBlue,
          secondary: Colors.lightBlueAccent,
          onSecondary: Colors.white,
          brightness: Brightness.light,
          background: Colors.white,
          onBackground: Colors.grey,
          onPrimary: Colors.grey,
          surface: Colors.lightBlue,
          onSurface: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,

        )
      ),
      title: "D' Camarón",
      debugShowCheckedModeBanner: false,
      //Se verifica que el usuario tenga más de un rol
      //   initialRoute: '/client/orders/pay',
      initialRoute: userSession.id != null ? userSession.roles!.length > 1 ? '/roles' : '/client/home' : '/',
      getPages: [
        //Creación de las rutas de navegación de la aplicación
        GetPage(name: '/', page: ()=> LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/roles', page: () => RolesPage()),
        GetPage(name: '/client/products/list', page: () => ClientProductsListPage()),
        GetPage(name: '/restaurant/orders/list', page: () => RestaurantOrdersListPage()),
        GetPage(name: '/restaurant/orders/detail', page: () => RestaurantOrdersDetailPage()),
        GetPage(name: '/client/home', page: () => ClientHomePage()),
        GetPage(name: '/restaurant/home', page: () => RestaurantHomePage()),
        GetPage(name: '/client/orders/create', page: () => ClientOrdersCreatePage()),
        GetPage(name: '/client/payments/create', page: () => ClientPaymentsCreatePage()),
        GetPage(name: '/client/orders/list', page: () => ClientOrdersListPage()),
        GetPage(name: '/client/orders/detail', page: () => ClientOrdersDetailPage()),
        GetPage(name: '/client/orders/pay', page: () => ClientOrdersPayPage())
      ],
      navigatorKey: Get.key,
    );
  }
}

