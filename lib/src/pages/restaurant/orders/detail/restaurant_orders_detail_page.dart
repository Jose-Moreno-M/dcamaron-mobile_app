import 'package:d_camaron/src/models/product.dart';
import 'package:d_camaron/src/pages/restaurant/orders/detail/restaurant_orders_detail_controller.dart';
import 'package:d_camaron/src/utils/relative_time_util.dart';
import 'package:d_camaron/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantOrdersDetailPage extends StatelessWidget {

  RestaurantOrdersDetailController controller = Get.put(RestaurantOrdersDetailController());

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
      body: controller.order.products!.isNotEmpty
          ? ListView(
          children: controller.order.products!.map((Product product) {
            return _cardProduct(product);
          }).toList()
      )
          : Center(child: NoDataWidget(text: 'La orden no tiene productos',)),
      bottomNavigationBar: Container(
        color: Color.fromRGBO(245, 245, 245, 1),
        height: MediaQuery.of(context).size.height * 0.40,
        child:Column(
          children: [
            _dataClient(),
            _dataDate(),
            _totalToPay(context),
          ],
        ),
      ),
    )
    );
  }

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

  Widget _totalToPay(BuildContext context){
    return Container(height: MediaQuery.of(context).size.height * 0.2,
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
          Spacer(),
          //Si el status es ENTREGADO ya no se muestra el botón
          controller.order.status != 'ENTREGADO'
              ? ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
                onPressed: () => controller.updateOrder(),
                child: Text(
                  //Según el status de la orden se define un texto
                  // y función para el botón
                  controller.order.status == 'PAGADO'
                      ?'COCINAR ORDEN'
                      : controller.order.status == 'COCINANDO'
                        ? 'ORDEN LISTA'
                        : controller.order.status == 'LISTO'
                          ? 'ENTREGADA'
                          : controller.order.status == 'HECHO'
                            ? 'ORDEN PAGADA'
                            : '',
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              )
              : Container(),
          Spacer()
        ],
      ),
    );
  }

  Widget _dataClient(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Cliente'),
        subtitle: Text(
          '${controller.order.client?.name ?? ''} ${controller.order.client?.lastname ?? ''} - ${controller.order.client!.phone ?? '404'}'
        ),
        //Al presionar el ícono de teléfono se hará una llamada al cliente
        trailing: GestureDetector(
            child: Icon(Icons.phone, color: Colors.green,),
          onTap: () => controller.callNumber(),
        ),
      ),
    );
  }

  //Se muestra la fecha relativa del pedido
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
}
