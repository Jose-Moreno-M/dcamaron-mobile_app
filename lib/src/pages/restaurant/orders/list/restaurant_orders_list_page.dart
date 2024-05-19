import 'package:d_camaron/src/models/order.dart';
import 'package:d_camaron/src/pages/restaurant/orders/list/restaurant_orders_list_controller.dart';
import 'package:d_camaron/src/utils/relative_time_util.dart';
import 'package:d_camaron/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantOrdersListPage extends StatelessWidget {

  RestaurantOrdersListController controller = Get.put(RestaurantOrdersListController());

  @override
  Widget build(BuildContext context) {
    //Obx permite que la página pueda actualizar los datos dependientes de sus
    // controladores y providers
    return Obx(() => DefaultTabController(
        length: controller.status.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50), //Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
            child: AppBar(
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.lightBlue,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: List<Widget>.generate(controller.status.length, (index){
                  return Tab(
                    child: Text(
                        controller.status[index]
                    ),
                  );
                }),
              ),
            ),
          ),
          body: TabBarView(
            children: controller.status.map((String status){
              //FutureBuilder se usa cuando para dibujar una pantalla se necesita un await
              return FutureBuilder(
                  future: controller.getOrders(status),
                  builder: (context, AsyncSnapshot<List<Order>> snapshot){
                    if(snapshot.hasData){

                      if(snapshot.data!.length > 0) {
                        // ListView.Builder construlle la vista en lista de las órdenes
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (_, index) {
                              return _cardOrder(snapshot.data![index]);
                            }
                        );
                      } else {
                        return Center(child: NoDataWidget(text: 'No hay órdenes',));
                      }
                    } else {
                      return Center(child: NoDataWidget(text: 'No hay órdenes',));
                    }
                  }
              );
            }).toList(),
          ),
        )
    ));
  }

  //Ficha para cada orden en la lista
  Widget _cardOrder(Order order){
    return GestureDetector(
      onTap: () => controller.goToOrderDetail(order),
      child: Container(
        // height: 150,
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                  )
                ),
                child: Center(
                  child: Text(
                    'Orden # ${order.id}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'Fecha: ${RelativeTimeUtil.getRelativeTime(order.timestamp ?? 0)}'
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'Cliente: ${order.client?.name ?? ''} ${order.client?.lastname ?? ''}'
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
