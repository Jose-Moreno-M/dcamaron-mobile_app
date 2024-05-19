import 'package:get/get.dart';

class MercadoPagoProvider extends GetConnect{

  // Future<List<Category>> getAll() async{
  //   Response response = await get(
  //       "$url/getAll",
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": userSession.sessionToken ?? ""
  //       }
  //   ); //Espera que el servidor mande una respuesta
  //
  //   if(response.statusCode == 401){
  //     Get.snackbar("Petición denegada", "No estás autorizado para leer esta información");
  //     return [];
  //   }
  //
  //   List<Category> categories = Category.fromJsonList(response.body);
  //
  //   return categories;
  // }

}