import 'package:d_camaron/src/models/order.dart';
import 'package:d_camaron/src/models/reponse_api.dart';
import 'package:d_camaron/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../environment/environment.dart';

class OrdersProvider extends GetConnect{

  String url = Environment.API_URL + 'api/orders';
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Order>> findByStatus(String status) async{
    Response response = await get(
        "$url/findByStatus/$status",
        headers: {
          "Content-Type": "application/json",
          "Authorization": userSession.sessionToken ?? ""
        }
    ); //Espera que el servidor mande una respuesta

    if(response.statusCode == 401){
      Get.snackbar("Petición denegada", "No estás autorizado para leer esta información");
      return [];
    }

    List<Order> orders = Order.fromJsonList(response.body);

    return orders;
  }

  Future<ResponseApi> create (Order order) async{
    Response response = await post(
        "$url/create",
        order.toJson(),
        headers: {
          "Content-Type": "application/json",
          "Authorization": userSession.sessionToken! ?? ""
        }
    ); //Espera que el servidor mande una respuesta

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;

  }

  Future<List<Order>> findByClientAndStatus(String idClient, String status) async {
    Response response = await get(
        '$url/findByClientAndStatus/$idClient/$status',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Petición denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<Order> orders = Order.fromJsonList(response.body);

    return orders;
  }

  Future<ResponseApi> updateToPaid (Order order) async{
    Response response = await put(
        "$url/updateToPaid",
        order.toJson(),
        headers: {
          "Content-Type": "application/json",
          "Authorization": userSession.sessionToken! ?? ""
        }
    ); //Espera que el servidor mande una respuesta

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> updateToCooking (Order order) async{
    Response response = await put(
        "$url/updateToCooking",
        order.toJson(),
        headers: {
          "Content-Type": "application/json",
          "Authorization": userSession.sessionToken! ?? ""
        }
    ); //Espera que el servidor mande una respuesta

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> updateToReady (Order order) async{
    Response response = await put(
        "$url/updateToReady",
        order.toJson(),
        headers: {
          "Content-Type": "application/json",
          "Authorization": userSession.sessionToken! ?? ""
        }
    ); //Espera que el servidor mande una respuesta

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> updateToDelivered (Order order) async{
    Response response = await put(
        "$url/updateToDelivered",
        order.toJson(),
        headers: {
          "Content-Type": "application/json",
          "Authorization": userSession.sessionToken! ?? ""
        }
    ); //Espera que el servidor mande una respuesta

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

}