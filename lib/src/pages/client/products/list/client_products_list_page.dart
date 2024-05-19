import 'package:d_camaron/src/models/category.dart';
import 'package:d_camaron/src/models/product.dart';
import 'package:d_camaron/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:d_camaron/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProductsListPage extends StatelessWidget {
  ClientProductsListController controller =
  Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    //Obx permite que la página pueda actualizar los datos dependientes de sus
    // controladores y providers
    return Obx(() => DefaultTabController(
        length: controller.categories.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(110), //Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
            child: AppBar(
              flexibleSpace: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 10),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    _textFieldSearch(context),
                    _iconShoppingBag()
                  ],
                ),
              ),
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.lightBlue,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: List<Widget>.generate(controller.categories.length, (index){
                  return Tab(
                    child: Text(
                        controller.categories[index].name ?? ''
                    ),
                  );
                }),
              ),
            ),
          ),
          body: TabBarView(
            children: controller.categories.map((Category category){
              return FutureBuilder(
                  future: controller.getProducts(category.id ?? '1'),
                  builder: (context, AsyncSnapshot<List<Product>> snapshot){
                    if(snapshot.hasData){

                      if(snapshot.data!.length > 0) {
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (_, index) {
                              return _cardProduct(context, snapshot.data![index]);
                            }
                        );
                      } else {
                        return NoDataWidget(text: 'No hay productos disponibles',);
                      }
                    } else {
                      return NoDataWidget(text: 'No hay productos disponibles',);
                    }
                  }
              );
            }).toList(),
          ),
        )
    ));
  }

  Widget _iconShoppingBag(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: () => controller.goToOrderCreate(),
          icon: Icon(Icons.shopping_bag_outlined),
        ),
      ),
    );
  }

  //Dibujado de la barra de búsqueda (sin funcionalidad)
  Widget _textFieldSearch(BuildContext context){
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.70,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Buscar producto',
            suffixIcon: Icon(Icons.search, color: Colors.grey,),
            hintStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.grey
              )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: Colors.grey
                )
            ),
            contentPadding: EdgeInsets.all(15)
          ),
        ),
      ),
    );
  }

  //Widget que muestra la información de un producto existente
  Widget _cardProduct(BuildContext context, Product product){
    return GestureDetector(
      onTap: () => controller.openBottomSheet(context, product),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: ListTile(
              title: Text(
                  product.name ?? 'Nombre del producto',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text(
                      product.description ?? 'Descripción del producto',
                      maxLines: 2,
                  ),
                  SizedBox(height: 10,),
                  Text(
                      '\$${product.price.toString()}',
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold
                      ),
                  )

                ],
              ),
              trailing: Container(
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
              ),
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          )
        ],
      ),
    );
  }
}
