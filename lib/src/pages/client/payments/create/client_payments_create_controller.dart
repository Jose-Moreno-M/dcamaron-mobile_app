import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ClientPaymentsCreateController extends GetxController{
  var cardNumber = ''.obs;
  var expiryDate = ''.obs;
  var cardHolderName = ''.obs;
  var cvvCode = ''.obs;
  var isCvvFocused = false.obs;

  GlobalKey<FormState> formKey = GlobalKey();

  void onCreditCardModelChanged (CreditCardModel creditCardModel){

    cardNumber.value = creditCardModel.cardNumber;
    expiryDate.value = creditCardModel.expiryDate;
    cardHolderName.value = creditCardModel.cardHolderName;
    cvvCode.value = creditCardModel.cvvCode;
    print(creditCardModel.cvvCode);
    isCvvFocused.value = creditCardModel.isCvvFocused;
  }
}