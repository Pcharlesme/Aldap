import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();
  RxBool isLoginWidgetDisplayed = true.obs;

  RxBool lbsWeight = true.obs;
  RxBool kgWeight = false.obs;

  RxBool cashPaymentMethod = true.obs;
  RxBool bankPaymentMethod = false.obs;
  RxBool paypalPaymentMethod = false.obs;
  RxBool cardPaymentMethod = false.obs;
  Rx<TextEditingController> weightController = TextEditingController().obs;

  RxBool accessoriesSendingType = true.obs;
  RxBool giftSendingType = false.obs;
  RxBool othersSendingType = false.obs;

  RxBool doorDeliveryMethod = true.obs;
  RxBool pickUpDeliveryMethod = false.obs;
  RxBool noContactDeliveryMethod = false.obs;

  toDoorDelivery() {
    doorDeliveryMethod.value = true;
    pickUpDeliveryMethod.value = false;
    noContactDeliveryMethod.value = false;
  }

  toPickUpDelivery(){
    doorDeliveryMethod.value = false;
    pickUpDeliveryMethod.value = true;
    noContactDeliveryMethod.value = false;
  }

  toNoContactDelivery(){
    doorDeliveryMethod.value = false;
    pickUpDeliveryMethod.value = false;
    noContactDeliveryMethod.value = true;
  }

  changeWeightContainer() {
    lbsWeight.value = !lbsWeight.value;
    kgWeight.value = !kgWeight.value;
  }

  changetoAccessoriesContainer() {
    accessoriesSendingType.value = true;
    giftSendingType.value = false;
    othersSendingType.value = false;
  }

  changetoGiftContainer() {
    accessoriesSendingType.value = false;
    giftSendingType.value = true;
    othersSendingType.value = false;
  }

  changetoOthersContainer() {
    accessoriesSendingType.value = false;
    giftSendingType.value = false;
    othersSendingType.value = true;
  }

  changeDisplayedAuthWidget() {
    isLoginWidgetDisplayed.value = !isLoginWidgetDisplayed.value;
  }

  changeToCashPaymentMethod() {
    cashPaymentMethod.value = true;
    bankPaymentMethod.value = false;
    paypalPaymentMethod.value = false;
    cardPaymentMethod.value = false;
  }

  changeToBankPaymentMethod() {
    cashPaymentMethod.value = false;
    bankPaymentMethod.value = true;
    paypalPaymentMethod.value = false;
    cardPaymentMethod.value = false;
  }

  changeToPaypalPaymentMethod() {
    cashPaymentMethod.value = false;
    bankPaymentMethod.value = false;
    paypalPaymentMethod.value = true;
    cardPaymentMethod.value = false;
  }

  changeToCardPaymentMethod() {
    cashPaymentMethod.value = false;
    bankPaymentMethod.value = false;
    paypalPaymentMethod.value = false;
    cardPaymentMethod.value = true;
  }
}
