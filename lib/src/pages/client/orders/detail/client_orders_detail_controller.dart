import 'package:d_camaron/src/models/order.dart';
import 'package:d_camaron/src/models/reponse_api.dart';
import 'package:d_camaron/src/models/user.dart';
import 'package:d_camaron/src/pages/client/orders/pay/client_orders_pay_page.dart';
import 'package:d_camaron/src/providers/orders_provider.dart';
import 'package:d_camaron/src/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

  class   ClientOrdersDetailController extends GetxController {

  Order order = Order.fromJson(Get.arguments['order']);

  var total = 0.0.obs;
  var idDelivery = ''.obs;

  UsersProvider usersProvider = UsersProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  List<User> users = <User>[].obs;

  ClientOrdersDetailController() {
    print('Order: ${order.toJson()}');
    getTotal();
  }

  void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }

  void openBottomSheet(BuildContext context, Order order){
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => ClientOrdersPayPage(order: order,),
    );
  }

}