import 'package:d_camaron/src/environment/environment.dart';
import 'package:get/get.dart';

import '../models/reponse_api.dart';
import '../models/user.dart';

class UsersProvider extends GetConnect{

  String url = Environment.API_URL + 'api/users';

  Future<Response> create (User user) async{
    Response response = await post(
        "$url/create",
        user.toJson(),
      headers: {
          "Content-Type": "application/json"
      }
    ); //Espera que el servidor mande una respuesta

    return response;
  }

  Future<ResponseApi> login (String email, String password) async{
    Response response = await post(
        "$url/login",
        {
          'email':email,
          'password':password
        },
        headers: {
          "Content-Type": "application/json"
        }
    ); //Espera que el servidor mande una respuesta
    
    if(response.body == null){
      Get.snackbar("Error", "No se pudo ejecutar la petición");
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}