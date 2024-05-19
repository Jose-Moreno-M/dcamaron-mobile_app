import 'package:d_camaron/src/models/order.dart';
import 'package:d_camaron/src/pages/client/orders/pay/client_orders_pay_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientOrdersPayPage extends StatelessWidget {

  //Esta pantalla se cierra con deslisarla hacia abajo

  Order? order;

  //Se recibe la orden como parámetro para capturar su id
  ClientOrdersPayPage({@required this.order}){
    controller = Get.put(ClientOrdersPayController());
  }

  ClientOrdersPayController controller = Get.put(ClientOrdersPayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _title(context),
          _instructions(context)
        ],
      )
    );
  }


  //Barra superior de la pantalla
  _title(BuildContext context){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: Colors.lightBlue
      ),
      child: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          // margin: EdgeInsets.only(top: 20),
          child: Text(
            'INSTRUCCIONES DE PAGO',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.05
            ),
          ),
        ),
      ),
    );
  }

  //Listado de las instrucciones
  _instructions(BuildContext context){
      return SingleChildScrollView(
        child: Column(
        children: [
          _payReference(context),
          _payInstructions(context),
        ],
    ),
      );
  }

  //Se captura la id de la orden y se establece como referencia de la transferencia
  _payReference(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: context.mediaQuery.size.height * 0.05, left: 10, right: 10),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,//Color.fromRGBO(72, 184, 208, 1.0),
          borderRadius: BorderRadius.circular(25)
      ),
      child: Center(
        child: Text(
          "1. Tu referencia de pago es: ${order?.id ?? ''}",
          style: subtitleStyle(),),
      ),
    );
  }


  //Indica cómo hacer le pago al usuario
  Widget _payInstructions(BuildContext context){
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          //Se le da un diseño al container que alberga los textos
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,//Color.fromRGBO(72, 184, 208, 1.0),
            borderRadius: BorderRadius.circular(25)
          ),
          margin: EdgeInsets.only(top: context.mediaQuery.size.height * 0.05, left: 10, right: 10),
          child: Column(
            children: [
              Text(
                '2. Haz el pago con la siguiente información \n',
                style: subtitleStyle(),
              ),
              Text(
                'Nombre: D\' Camarón',
                style: normalStyle(context),
              ),
              Text(
                'Cuenta: 1513389001',
                style: normalStyle(context),
              ),
              Text(
                'CLABE: 012760015133890015',
                style: normalStyle(context),
              ),
              Text(
                'Banco: BBVA',
                style: normalStyle(context),
              )
            ],
          ),
        ),

        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent,//Color.fromRGBO(72, 184, 208, 1.0),
              borderRadius: BorderRadius.circular(25)
          ),
          margin: EdgeInsets.only(top: context.mediaQuery.size.height * 0.05, left: 10, right: 10),
          child: Column(
            children: [
              Text(
                '3. Envía tu comprobante al WhatsApp \n',
                style: subtitleStyle(),
              ),
              Text(
                '6341104871',
                style: normalStyle(context),
              ),
              Text(
                'Incluye tu nombre de usuario',
                style: normalStyle(context),
              )
            ],
          ),
        ),

        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent,//Color.fromRGBO(72, 184, 208, 1.0),
              borderRadius: BorderRadius.circular(25)
          ),
          margin: EdgeInsets.only(top: context.mediaQuery.size.height * 0.05, left: 10, right: 10),
          child: Column(
            children: [
              Text(
                'Información del programador',
                style: subtitleStyle(),
              ),
              Text(
                'Nombre: José Luis Moreno Meza',
                style: normalStyle(context),
              ),
              Text(
                'Carrera: Ingeniería en sistema scomputacionales',
                style: normalStyle(context),
              )
            ],
          ),
        )

      ],
    );
  }


// FontStyles hechos para usarse repetidamente
  TextStyle normalStyle(BuildContext context){
    return
        TextStyle(
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.width * 0.04
        );
  }

  TextStyle subtitleStyle(){
    return TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: Get.mediaQuery.size.width * 0.045,
    );
  }
}

