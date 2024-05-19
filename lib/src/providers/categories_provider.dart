import 'package:d_camaron/src/models/category.dart';
import 'package:d_camaron/src/models/reponse_api.dart';
import 'package:d_camaron/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../environment/environment.dart';

class CategoriesProvider extends GetConnect{

  String url = Environment.API_URL + 'api/categories';
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Category>> getAll() async{
    Response response = await get(
        "$url/getAll",
        headers: {
          "Content-Type": "application/json",
          "Authorization": userSession.sessionToken ?? ""
        }
    ); //Espera que el servidor mande una respuesta

    if(response.statusCode == 401){
      Get.snackbar("Petición denegada", "No estás autorizado para leer esta información");
      return [];
    }

    List<Category> categories = Category.fromJsonList(response.body);

    return categories;
  }

  Future<ResponseApi> create (Category category) async{
    Response response = await post(
        "$url/create",
        category.toJson(),
        headers: {
          "Content-Type": "application/json",
          "Authorization": userSession.sessionToken! ?? ""
        }
    ); //Espera que el servidor mande una respuesta

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

}