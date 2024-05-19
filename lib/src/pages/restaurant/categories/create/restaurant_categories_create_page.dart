import 'package:d_camaron/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantCategoriesCreatePage extends StatelessWidget {

  //Se instancia al controlador
  RestaurantCategoriesCreateController controller = Get.put(RestaurantCategoriesCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _backgroundCover(context),
            _boxForm(context),
            _textNewCategory(context),
          ],
        ),
      ),
    );
  }

  Widget _backgroundCover(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.lightBlue,
    );
  }

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
          _buttonCreate()
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

  Widget _buttonCreate(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => controller.createCategory(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            "CREAR CATEGORÍA",
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
                Icons.category,
                size: 100,
              ),
              Text(
                  'NUEVA CATEGORÍA',
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

