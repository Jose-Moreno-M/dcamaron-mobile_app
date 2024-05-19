import 'package:d_camaron/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:d_camaron/src/models/product.dart';

class ClientProductsDetailPage extends StatelessWidget {

late ClientProductsDetailController controller;

//El símbolo ? es por el null safety, lo que permite crear instancias nulas y
//evitar errores de tratado de nulos
Product? product;
var counter = 0.obs;
var price = 0.0.obs;

//El constructor sólo instanciará el controlador si la instancia product no es nula
ClientProductsDetailPage({@required this.product}){
  controller = Get.put(ClientProductsDetailController());
}

  @override
  Widget build(BuildContext context) {
  controller.checkIfProductsWereAdded(product!, price, counter);
    return Obx(() => Scaffold(
      body: Column(
        children: [
          _imageSlideshow(context),
          _textNameProduct(),
          _textDescriptionProduct(),
          _textPriceProduct()
        ],
      ),
      bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.10,
          child: _buttonAddToBag()
      ),
    )
    );
  }

  //Widget que nos permite ver las imágenes del producto haciendo slide
  Widget _imageSlideshow(BuildContext context){
    return SafeArea(
      child: Stack(
        children: [
          ImageSlideshow(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            initialPage: 0,
            indicatorColor: Colors.lightBlue,
            indicatorBackgroundColor: Colors.grey,
            children: [
              FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: product!.image1 != null
                      ? NetworkImage(product!.image1!)
                      : AssetImage('assets/img/no-image.jpg') as ImageProvider
              ),

              FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: product!.image2 != null
                      ? NetworkImage(product!.image2!)
                      : AssetImage('assets/img/no-image.jpg') as ImageProvider
              ),

              FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: product!.image3 != null
                      ? NetworkImage(product!.image3!)
                      : AssetImage('assets/img/no-image.jpg') as ImageProvider
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _textNameProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product!.name ?? "",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20
        ),
      ),
    );
  }

  Widget _textDescriptionProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 15, left: 30, right: 30),
      child: Text(
        product!.description ?? '',
        style: TextStyle(
            fontSize: 18
        ),
      ),
    );
  }

  Widget _textPriceProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 15, left: 30, right: 30),
      child: Text(
        "\$${product?.price.toString() ?? ''}",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue
        ),
      ),
    );
  }

  //En este widget se verá la botonera para modificar la cantidad de un producto
  // y el botón para agregar la cantidad del producto a la orden
  Widget _buttonAddToBag(){
    return Column(
      children: [
        Divider(
          indent: 30,
          endIndent: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          //Botonera para modificar cantidad
          child: Row(
            children: [
              ElevatedButton(
                onPressed: ()=> controller.removeItem(product!, price, counter) ,
                child: Text(
                  '-',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(40, 40),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15)
                        )
                    )
                ),
              ),
              ElevatedButton(
                onPressed: (){} ,
                child: Text(
                  '${counter.value}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(40, 40),
                    backgroundColor: Colors.white
                ),
              ),
              ElevatedButton(
                onPressed: () => controller.addItem(product!, price, counter),
                child: Text(
                  '+',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(40, 40),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)
                        )
                    )
                ),
              ),
              //El widget Spacer() ocupa todo el espacio vacío entre widgets distintos
              Spacer(),
              //Botón para agregar producto a la orden
              ElevatedButton(
                onPressed: () => controller.addToBag(product!, price, counter) ,
                child: Text(
                  'Agregar \$${price.value}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    )
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
