import 'package:d_camaron/src/models/category.dart';
import 'package:d_camaron/src/models/product.dart';
import 'package:d_camaron/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:d_camaron/src/providers/categories_provider.dart';
import 'package:d_camaron/src/providers/products_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientProductsListController extends GetxController{

  //Se instancian los providers
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  //El .obs significa que es obserbable para el Obx
  List<Category> categories = <Category>[].obs;

  ClientProductsListController(){
    getCategories();
  }

  //Se piden las categorías al servidor
  void getCategories()async{
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  //Se piden los productos según su categoría al servidpr.
  Future<List<Product>> getProducts(String idCategory) async {
    return await productsProvider.findByCategory(idCategory);
  }

  //Método para abrir la pantalla de detalle
  void openBottomSheet(BuildContext context, Product product){
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientProductsDetailPage(product: product,),
    );
  }

  //Método para redirigir a la pantalla de orden de usuario
  void goToOrderCreate(){
    Get.toNamed('/client/orders/create');
  }

}
