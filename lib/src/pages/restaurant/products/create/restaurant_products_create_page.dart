import 'dart:io';


import 'package:d_camaron/src/models/category.dart';
import 'package:d_camaron/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantProductsCreatePage extends StatelessWidget {

  //Se instancia el controlador de la pantalla
  RestaurantProductsCreateController controller = Get.put(RestaurantProductsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() => Stack(
          children: [
            _backgroundCover(context),
            _boxForm(context),
            _textNewCategory(context),
          ],
        ),
        )
      ),
    );
  }

  //Es el fondo azul en la pantalla
  Widget _backgroundCover(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.lightBlue,
    );
  }

  // Creación del formularoi
  Widget _boxForm(BuildContext context){
    return Container(
      //height: MediaQuery.of(context).size.height * 0.65,
      //padding: EdgeInsets.all(0),
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height*0.30,
          left: 50,
          right: 50,
          bottom: 50
      ),
      //Estilo del container con el formulario
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.75)
            )
          ]
      ),
      child: Column(
        children: [
          _textYourInfo(),
          _textFieldName(),
          _textFieldDescription(),
          _textFieldPrice(),
          _dropDownCategories(controller.categories),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<RestaurantProductsCreateController>(
                builder: (value) =>
                    _cardImage(controller.imageFile1, 1, context),
              ),
              GetBuilder<RestaurantProductsCreateController>(
                builder: (value) =>
                    _cardImage(controller.imageFile2, 2, context),
              ),
              GetBuilder<RestaurantProductsCreateController>(
                builder: (value) =>
                    _cardImage(controller.imageFile3, 3, context),
              ),
            ],
          ),
          _buttonCreate(context)
        ],
      ),
    );
  }

  Widget _textYourInfo (){
    return Container(
      margin: EdgeInsets.only(
          top: 40, bottom: 35
      ),
      child: const Text(
        "INGRESA ESTA INFORMACIÓN",
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }


  Widget _textFieldName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.nameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: "Nombre",
            prefixIcon: Icon(Icons.category)
        ),
      ),
    );
  }

  Widget _textFieldDescription(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
      child: TextField(
        maxLines: 5,
        controller: controller.descriptionController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: "Descripción",
            prefixIcon: Icon(Icons.description)
        ),
      ),
    );
  }

  Widget _textFieldPrice(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.priceController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            hintText: "Precio",
            prefixIcon: Icon(Icons.attach_money)
        ),
      ),
    );
  }

  Widget _cardImage(File? imageFile, int numberFile, BuildContext context){
    return GestureDetector(
        onTap: () => controller.showAlertDialog(context, numberFile),
        child: Card(
          color: Colors.white,
          elevation: 3,
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.2,
            child: imageFile != null
                ? Image.file(
              imageFile,
              fit: BoxFit.cover,
            )
                : Image(
              image: AssetImage('assets/img/add-image.png'),
            ),
          ),
        ),
    );
  }

  Widget _dropDownCategories(List<Category> categories){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: DropdownButton(
        isExpanded: true,
        elevation: 3,
        underline: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.lightBlue,
          ),
        ),
        hint: Text("Categoría", style: TextStyle(color: Colors.black, fontSize: 16),),
        items: _dropDownItems(categories),
        value: controller.idCategory.value == '' ? null : controller.idCategory.value,
        onChanged: (option){
          debugPrint("Opción seleccionada: $option");
          controller.idCategory.value = option.toString();
        },
      ),
    );
  }

  List<DropdownMenuItem<String?>> _dropDownItems(List<Category> categories){
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
          value: category.id,
          child:Text(
              category.name ?? "",
              style: TextStyle(color: Colors.black),
          ),
        )
      );
    });
    return list;
  }

  Widget _buttonCreate(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => controller.createProduct(context),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            "CREAR PRODUCTO",
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

  Widget _textAppName(){
    return Text(
      "TACO FISH D' CAMARÓN Y MÁS",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
    );
  }

  Widget _textNewCategory(BuildContext context){
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(top:30, bottom: 25),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Icon(
                Icons.fastfood,
                size: 100,
              ),
              Text(
                  'NUEVO PRODUCTO',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
              ),
            ],
          )
      ),
    );
  }

}

