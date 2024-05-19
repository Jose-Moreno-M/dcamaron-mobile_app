import 'package:d_camaron/src/pages/client/payments/create/client_payments_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

class ClientPaymentsCreatePage extends StatelessWidget {

  ClientPaymentsCreateController controller =  Get.put(ClientPaymentsCreateController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: ListView(
        children: [

          //Widget que genera la vista de una tarjeta de crédito
          CreditCardWidget(
            //Se definen los valores que la tarjeta tendrá en pantalla
            cardNumber: controller.cardNumber.value,
            expiryDate: controller.expiryDate.value,
            cardHolderName: controller.cardHolderName.value,
            cvvCode: controller.cvvCode.value,
            showBackView: controller.isCvvFocused.value,
            onCreditCardWidgetChange: (CreditCardBrand brand) {},
            // bankName: 'Name of the Bank',
            //Color de la tarjeta
            cardBgColor: Colors.lightBlue,
            // glassmorphismConfig: Glassmorphism.defaultConfig(),
            //Configuración para que la tarjeta se mueva con el celular
            enableFloatingCard: true,
            floatingConfig: FloatingConfig(
              isGlareEnabled: true,
              isShadowEnabled: true,
              shadowConfig: FloatingShadowConfig(),
            ),
            // backgroundImage: 'assets/card_bg.png',
            // backgroundNetworkImage: 'https://www.xyz.com/card_bg.png',
            //Valores por defecto de las labels de la tarjeta
            labelValidThru: 'VALID\nTHRU',
            obscureCardNumber: true,
            obscureInitialCardNumber: false,
            obscureCardCvv: true,
            labelCardHolder: 'CARD HOLDER',
            // cardType: CardType.mastercard,
            isHolderNameVisible: true,
            height: 175,
            //Estilo del texto en tarjeta
            textStyle: TextStyle(color: Colors.white),
            width: MediaQuery.of(context).size.width,
            isChipVisible: false,
            // isSwipeGestureEnabled: true,
            animationDuration: Duration(milliseconds: 1000),
            frontCardBorder: Border.all(color: Colors.grey),
            backCardBorder: Border.all(color: Colors.grey),
            chipColor: Colors.red,
            padding: 16,
            // customCardTypeIcons: <CustomCardTypeIcons>[
            //   CustomCardTypeIcons(
            //     cardType: CardType.mastercard,
            //     cardImage: Image.asset(
            //       'assets/mastercard.png',
            //       height: 48,
            //       width: 48,
            //     ),
            //   ),
            // ],
          ),

          //Widget para el formulario de pago
          CreditCardForm(
            formKey: controller.formKey, // Required
            cardNumber: '', // Required
            expiryDate: '', // Required
            cardHolderName: '', // Required
            cvvCode: '', // Required
            // cardNumberKey: cardNumberKey,
            // cvvCodeKey: cvvCodeKey,
            // expiryDateKey: expiryDateKey,
            // cardHolderKey: cardHolderKey,
            onCreditCardModelChange: controller.onCreditCardModelChanged, // Required
            obscureCvv: true,
            obscureNumber: true,
            isHolderNameVisible: true,
            isCardNumberVisible: true,
            isExpiryDateVisible: true,
            enableCvv: true,
            cvvValidationMessage: 'Ingresa el CVV correcto',
            dateValidationMessage: 'Ingresa la fecha correcta',
            numberValidationMessage: 'Ingresa el número de tarjeta correcto',
            cardNumberValidator: (String? cardNumber){},
            expiryDateValidator: (String? expiryDate){},
            cvvValidator: (String? cvv){},
            cardHolderValidator: (String? cardHolderName){},
            onFormComplete: () {
              // callback to execute at the end of filling card data
            },
            autovalidateMode: AutovalidateMode.always,
            disableCardNumberAutoFillHints: false,
            inputConfiguration: const InputConfiguration(
              cardNumberDecoration: InputDecoration(
                prefixIcon: Icon(Icons.credit_card),
                //border: OutlineInputBorder(),
                labelText: 'Número de la tarjeta',
                hintText: 'XXXX XXXX XXXX XXXX',
              ),
              expiryDateDecoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_month),
                // border: OutlineInputBorder(),
                labelText: 'Expiración',
                hintText: 'XX/XX',
              ),
              cvvCodeDecoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                //border: OutlineInputBorder(),
                labelText: 'CVV',
                hintText: 'XXX',
              ),
              cardHolderDecoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                //border: OutlineInputBorder(),
                labelText: 'Titular de la tarjeta',
              ),
              cardNumberTextStyle: TextStyle(
                // fontSize: 10,
                color: Colors.black,
              ),
              cardHolderTextStyle: TextStyle(
                // fontSize: 10,
                color: Colors.black,
              ),
              expiryDateTextStyle: TextStyle(
                // fontSize: 10,
                color: Colors.black,
              ),
              cvvCodeTextStyle: TextStyle(
                // fontSize: 10,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buttonNext(),
    )
    );
  }

  //Botón para confirmar pago
  Widget _buttonNext(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => {},
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            "CONTINUAR",
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }
}
