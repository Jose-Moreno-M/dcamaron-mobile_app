import 'package:d_camaron/src/models/order.dart';
import 'package:d_camaron/src/models/reponse_api.dart';
import 'package:d_camaron/src/providers/orders_provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RestaurantOrdersDetailController extends GetxController{

  Order order = Order.fromJson(Get.arguments['order']);
  OrdersProvider ordersProvider = OrdersProvider();

  var total = 0.0.obs;

  RestaurantOrdersDetailController(){
    print('Orden: ${order.toJson()}');
    getTotal();
  }

  void getTotal(){
    total.value = 0.0;
    order.products!.forEach((p) {
      total.value = total.value + (p.price! * p.quantity!);
    });
  }

  void updateOrder(){
    if(order.status == 'HECHO'){
      updateOrderToPaid();
    }else if(order.status == 'PAGADO'){
      updateOrderToCooking();
    }else if(order.status == 'COCINANDO') {
      updateOrderToReady();
    }else if(order.status == 'LISTO'){
      updateOrderToDelivered();
    }
  }

  void updateOrderToPaid ()async{
    ResponseApi responseApi = await ordersProvider.updateToPaid(order);

    Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);

    if(responseApi.success == true){
      Get.offNamedUntil('/restaurant/home', (route) => false);
    }else{
      Get.snackbar('Error', 'Hubo un error al actualizar la  orden');
    }
  }

  void updateOrderToCooking ()async{
    ResponseApi responseApi = await ordersProvider.updateToCooking(order);

    Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);

    if(responseApi.success == true){
      Get.offNamedUntil('/restaurant/home', (route) => false);
    }else{
      Get.snackbar('Error', 'Hubo un error al actualizar la  orden');
    }
  }

  void updateOrderToReady ()async{
    ResponseApi responseApi = await ordersProvider.updateToReady(order);

    Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);

    if(responseApi.success == true){
      Get.offNamedUntil('/restaurant/home', (route) => false);
    }else{
      Get.snackbar('Error', 'Hubo un error al actualizar la  orden');
    }
  }

  void updateOrderToDelivered ()async{
    ResponseApi responseApi = await ordersProvider.updateToDelivered(order);

    Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);

    if(responseApi.success == true){
      Get.offNamedUntil('/restaurant/home', (route) => false);
    }else{
      Get.snackbar('Error', 'Hubo un error al actualizar la  orden');
    }
  }

  void callNumber() async{
    String number = order.client?.phone ?? ''; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }

}