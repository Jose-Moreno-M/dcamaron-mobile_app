import 'package:d_camaron/src/models/order.dart';
import 'package:d_camaron/src/models/product.dart';
import 'package:d_camaron/src/models/reponse_api.dart';
import 'package:d_camaron/src/models/user.dart';
import 'package:d_camaron/src/providers/orders_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientOrdersCreateController extends GetxController{
  OrdersProvider ordersProvider = OrdersProvider();

  User user = User.fromJson(GetStorage().read('user') ?? {});

  List<Product> selectedProducts = <Product>[].obs;
  var total = 0.0.obs;


  //En el controlador de la pantalla de orden de cliente se lee de la
  // sesión los productos ingresado a la orden por el cliente par apoder mostrarlos
  // en pantalla
  ClientOrdersCreateController(){
    if(GetStorage().read('shopping_bag') != null){

      if(GetStorage().read('shopping_bag') is List<Product>){

        var result = GetStorage().read('shopping_bag');
        selectedProducts.clear();
        selectedProducts.addAll(result);

      }else{

        var result = Product.fromJsonList(GetStorage().read('shopping_bag'));
        selectedProducts.clear();
        selectedProducts.addAll(result);

      }

      getTotal();

    }
  }

  //Método usado para refrescar el total a pagar de la orden
  void getTotal(){
    total.value = 0.0;
    selectedProducts.forEach((p) {
      total.value = total.value + (p.price! * p.quantity!);
    });
  }

  //Método usado para aumentar la cantidad de un producto en la orden
  void addItem(Product product){
    int index = selectedProducts.indexWhere((p) => p.id == product.id);
    selectedProducts.remove(product);
    product.quantity = product.quantity! + 1;
    selectedProducts.insert(index, product);
    GetStorage().write('shopping_bag', selectedProducts);
    getTotal();
  }

  //Método usado para decrementar la cantidad de un producto en la orden
  void removeItem(Product product){
    if(product.quantity! > 1) {
      int index = selectedProducts.indexWhere((p) => p.id == product.id);
      selectedProducts.remove(product);
      product.quantity = product.quantity! - 1;
      selectedProducts.insert(index, product);
      GetStorage().write('shopping_bag', selectedProducts);
    }
    getTotal();
  }

  //Método usado para eliminar un producto de la orden
  void deleteItem(Product product){
    selectedProducts.remove(product);
    GetStorage().write('shopping_bag', selectedProducts);
    getTotal();
  }

  void createOrder()async{
    List<Product> products = [];

    if(GetStorage().read('shopping_bag') is List<Product>){
      products = GetStorage().read('shopping_bag');
    }else{
      products = Product.fromJsonList(GetStorage().read('shopping_bag'));
    }

    Order order = Order(
      idClient: user.id,
      products: products
    );

    ResponseApi responseApi = await ordersProvider.create(order);

    // Get.snackbar('Proceso terminado', responseApi.message ?? '');
    Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);

    if(responseApi.success == true){
      GetStorage().remove('shopping_bag');
      // print( GetStorage().read('shopping_bag'));
      selectedProducts.clear();
      print(selectedProducts);
      // Get.toNamed('/client/payments/create');
      Get.toNamed('/client/orders/create');
      update();
    }
  }
}