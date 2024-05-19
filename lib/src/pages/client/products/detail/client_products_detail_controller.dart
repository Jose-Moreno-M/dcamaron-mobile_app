import 'package:d_camaron/src/models/product.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientProductsDetailController extends GetxController{

  List<Product> selectedProducts = [];

  ClientProductsDetailController(){
  }

  //Se revisa si el producto en detalle ya está guardado en el GetStorage shopping_bag
  void checkIfProductsWereAdded(Product product, var price, var counter){
    price.value = product.price ?? 0.0;
    //Checa si shopping_bag no es nula
    if(GetStorage().read('shopping_bag') != null){

      //Checa que shopping_bag sea una lista de objetos Product
      if(GetStorage().read('shopping_bag') is List<Product>){
        //Copia shopping_bag a la lista selectedProducts
        selectedProducts = GetStorage().read('shopping_bag');
      }else{
        selectedProducts = Product.fromJsonList(GetStorage().read('shopping_bag'));
      }

      //Se buscael index del producto en detalle en selectedProducts
      int index = selectedProducts.indexWhere((p) => p.id == product.id);

      if(index != -1){ //El producto ya fue agregado
        counter.value = selectedProducts[index].quantity ?? 0;
        price.value = product.price! * counter.value;

        selectedProducts.forEach((p) {
          print('Producto en shopping_list ${p.toJson()}');
        });
      }

    }
  }


  //Método para guardar el producto en storage
  void addToBag(Product product, var price, var counter){

    if (counter.value > 0){

      //Revisar que  el producto haya sido agregado con GetStorage a la sesión.
      int index = selectedProducts.indexWhere((p) => p.id == product.id);

      if(index == -1){ //El producto no ha  sido agregado al storage
        if(product.quantity == null){
          if(counter.value > 0){
            product.quantity = counter.value;
          }else{
            product.quantity = 1;//counter.value;
          }
        }
        selectedProducts.add(product);
      }else{ //El producto ya ha sido agregado al storage
        selectedProducts[index].quantity = counter.value;
      }

      GetStorage().write('shopping_bag', selectedProducts);
      Fluttertoast.showToast(msg: 'Producto agregado');
      selectedProducts = [];

    } else{
      Fluttertoast.showToast(msg: 'Debes pedir por lo menos un producto para agregar');
    }
  }

  //Método para aumentar la cantidad del producto en storage
  void addItem(Product product, var price, var counter){
    counter.value = counter.value + 1;
    // counter.value++;
    price.value = product.price! * counter.value;
  }

  //Método para decrementar la cantidad del producto en storage
  void removeItem(Product product, var price, var counter){
    if(counter.value > 0){
      counter.value = counter.value -1;
      price.value = product.price! * counter.value;
    }
  }
}