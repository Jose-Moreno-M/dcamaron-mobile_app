import 'package:d_camaron/src/models/category.dart';
import 'package:d_camaron/src/models/reponse_api.dart';
import 'package:d_camaron/src/providers/categories_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RestaurantCategoriesCreateController extends GetxController{

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();

  void createCategory()async{
    String name = nameController.text;
    String description = descriptionController.text;

    if(name.isNotEmpty && description.isNotEmpty){

      Category category = Category(name: name, description: description);
      ResponseApi responseApi = await categoriesProvider.create(category);

      Get.snackbar('Proceso terminado', responseApi.message ?? "");

      if(responseApi.success == true){
        clearForm();
      }

    }else{
      Get.snackbar('Formulario inválido', 'Debes ingresar nombre y descripción de la categoría');
    }
  }

  void clearForm(){
    nameController.text = "";
    descriptionController.text = "";
  }

}