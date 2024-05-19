import 'package:d_camaron/src/models/product.dart';
import 'package:d_camaron/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:d_camaron/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientOrdersCreatePage extends StatelessWidget {

  ClientOrdersCreateController controller = Get.put(ClientOrdersCreateController());

  //Se construye la pantalla de orden de usuario
  @override

  Widget build(BuildContext context) {
    // print(controller.selectedProducts);
    return Obx(() => Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,

        ),
        title: Text(
          'Mi orden',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      body: controller.selectedProducts.length > 0
          ? ListView(
          children: controller.selectedProducts.map((Product product) {
            return _cardProduct(product);
          }).toList()
      )
          : Center(child: NoDataWidget(text: 'No hay productos agregados en tu orden',)),
      bottomNavigationBar: Container(
        color: Color.fromRGBO(245, 245, 245, 1),
        height: MediaQuery.of(context).size.height * 0.15,
        child:_totalToPay(),
      ),
    )
    );
  }

  //Widget que muestra la imagen 1 del producto
  Widget _imageProduct(Product product){
    return Container(
      height: 70,
      width: 70,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          image: product.image1 != null
              ? NetworkImage(product.image1!)
              : AssetImage('assets/img/no-image.jpg') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.jpg'),
        ),
      ),
    );
  }

  //Botón que permite modificar las cantidades de un producto en la orden
  Widget _buttonsAddOrRemove(Product product){
    return Row(
      children: [
        GestureDetector(
          onTap: () => controller.removeItem(product),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8)
                )
            ),
            child: Text('-'),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          color: Colors.blueGrey[100],
          child: Text('${product.quantity ?? 0}'),
        ),
        GestureDetector(
          onTap: () => controller.addItem(product),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)
                )
            ),
            child: Text('+'),
          ),
        ),
      ],
    );
  }

  //Botón para eliminar un producto de la orden
  Widget _iconDelete(Product product){
    return IconButton(
        onPressed: () => controller.deleteItem(product),
        icon: Icon(
          Icons.delete,
          color: Colors.red,)
    );
  }

  //Se muestra el subtotal del producto en orden
  Widget _textPrice(Product product){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        '\$${product.price! * product.quantity!}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.lightBlue
        ),
      ),

    );
  }

  //Widget que muestra la información del producto en la orden.
  Widget _cardProduct(Product product){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imageProduct(product),
          SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  product.name ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
              ),
              SizedBox(height: 10,),
              _buttonsAddOrRemove(product),
            ],
          ),
          Spacer(),
          Column(
            children: [
              _textPrice(product),
              _iconDelete(product)
            ],
          )
        ],
      ),
    );
  }

  //Widget que muestra el total a pagar y el botón para pagar la orden (aún sin funcionalidad)
  Widget _totalToPay(){
    return Column(
      children: [
        Divider(),
        Spacer(),
        Text(
          'TOTAL: \$${controller.total.value}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
          onPressed: () => controller.createOrder(),
          child: Text(
            'CONFIRMAR ORDEN',
            style: TextStyle(
              color: Colors.black
            ),
          ),
        ),
        Spacer()
      ],
    );
  }
}
