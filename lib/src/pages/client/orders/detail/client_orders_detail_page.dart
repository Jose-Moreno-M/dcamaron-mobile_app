import 'package:d_camaron/src/models/order.dart';
import 'package:d_camaron/src/models/product.dart';
import 'package:d_camaron/src/pages/client/orders/detail/client_orders_detail_controller.dart';
import 'package:d_camaron/src/utils/relative_time_util.dart';
import 'package:d_camaron/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientOrdersDetailPage extends StatelessWidget {

  ClientOrdersDetailController controller = Get.put(ClientOrdersDetailController());

//Pantalla que muestra el detalle de una orden
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text(
          'Orden #${controller.order.id}',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      //Validación para ver si un status tiene órdenes (?) o no (:)
      body: controller.order.products!.isNotEmpty
          ? ListView(
          children: controller.order.products!.map((Product product) {
            return _cardProduct(product);
          }).toList(),
      )
          : Center(child: NoDataWidget(text: 'La orden no tiene productos',)),
      bottomNavigationBar: Container(
        color: Color.fromRGBO(245, 245, 245, 1),
        height: controller.order.status == 'HECHO'
            ?MediaQuery.of(context).size.height * 0.30
            :MediaQuery.of(context).size.height * 0.20,
        child:Column(
          children: [
            _dataDate(),
            //Si el status de la orden es HECHO se muestra un gesture detector
            // que dirige a las instrucciones de pago
            controller.order.status == 'HECHO'
              ?_payInfo(context, controller.order)
              : Container(),
            _totalToPay(context),
          ],
        ),
      ),
    )
    );
  }

  //Producto listado en el detalle de la orden
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
              Text(
                  'Cantidad: ${product.quantity}'
              )
            ],
          ),
        ],
      ),
    );
  }

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

  //Se muestra el costo total de la orden
  Widget _totalToPay(BuildContext context){
    return Container(height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
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
          Spacer()
        ],
      ),
    );
  }

  Widget _dataDate(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Fecha'),
        subtitle: Text(
            '${RelativeTimeUtil.getRelativeTime(controller.order.timestamp ?? 0)}'
        ),
        trailing: Icon(Icons.watch_later),
      ),
    );
  }

  //Gesture detector que dirige a las instrucciones de pago
  Widget _payInfo(BuildContext context, Order order) {
    return GestureDetector(
      onTap: () => controller.openBottomSheet(context, order),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListTile(
          title: Text('Pago'),
          subtitle: Text(
              'Instrucciones de pago'
          ),
          trailing: Icon(Icons.attach_money),
        ),
      ),
    );
  }
}
