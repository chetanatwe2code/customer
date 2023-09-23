import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/model/VendorProductModel.dart';
import 'package:indiakinursery/utils/string_extensions.dart';
import 'package:indiakinursery/view/checkout/widget/address_radio_group.dart';
import 'package:indiakinursery/view/checkout/widget/payment_radio_group.dart';

import '../../controller/cart_controller.dart';
import '../../controller/home_controller.dart';
import '../../core/di/api_client.dart';
import '../../core/di/api_provider.dart';
import '../../core/routes.dart';
import '../../model/CartModel.dart';
import '../../utils/price_converter.dart';
import '../view/widget/toast.dart';

class CheckoutSummary{
  double? totalMrpAmount;
  double? totalAmount;
  double? subTotalAmount;
  double? totalGst;
  double? totalCGST;
  double? totalsGST;
  double? totalDiscount;
  double? totalShipCharge;
  CheckoutSummary({this.totalMrpAmount=0,
    this.subTotalAmount=0,
    this.totalAmount=0,
    this.totalCGST=0.0,
    this.totalGst=0.0,
    this.totalsGST=0.0,
    this.totalDiscount=0.0,
    this.totalShipCharge=0.0}){
    totalCGST = totalGst!/2;
    totalsGST = totalGst!/2;
  }
}

class CheckoutLogic extends GetxController implements GetxService {
  final ApiClient apiClient;
  CheckoutLogic({required this.apiClient});

  final List<VendorProductModel> _vendorProducts = [];
  List<VendorProductModel> get vendorProducts => _vendorProducts;

 // CheckoutSummary? checkoutSummary;
  //var cartPrice = 0.0.obs;


  double totalAmount = 0;
  double totalGst = 0;
  double taxableAmount = 0;
  double subTotal = 0;
  double totalDiscount = 0;
  double totalDeliveryCharge = 0;

  bool notAvailable = false;
  String notAvailableIds = "";
  AddressModel? addressModel;
  bool orderPlaceProcess = false;
  PaymentMethod? mode;

  initData(){
    _vendorProducts.clear();
    _vendorProducts.addAll(Get.find<CartController>().vendorProducts);
    if(_vendorProducts.isEmpty){
      //Get.back();
      Get.find<HomeLogic>().setBaseIndex2(0);
      Toast.show(toastMessage: "Your Cart is Empty");
      return;
    }
    totalGst = Get.find<CartController>().totalGst;
    subTotal = Get.find<CartController>().subTotal;
    taxableAmount = Get.find<CartController>().taxableAmount;
    totalDiscount = Get.find<CartController>().totalDiscount;
    totalDeliveryCharge = Get.find<CartController>().totalDeliveryCharge;
    totalAmount = subTotal + totalDeliveryCharge;
    clearPincodeError(notify: false);
    WidgetsBinding.instance.addPostFrameCallback((_){
      update();
    });
  }

  void increaseQuantity({ required int i , required int index }) async{

    CartModel cartModel = vendorProducts[i].cartProducts![index];
    vendorProducts[i].cartProducts![index].isIncrease = true;
    update();
    int quantity =((cartModel.cartProductQuantity??0)+1);
    await apiClient.putAPI(ApiProvider.updateCart,{
      "id": cartModel.id,"product_verient_id":cartModel.productVerientId,"product_id":cartModel.productId,"cart_product_quantity":quantity
    }).then((value) => {
      if(value.body['success'] == true){
        subTotal += cartModel.price ?? 0,
        totalAmount = totalDeliveryCharge + subTotal,
        vendorProducts[i].cartProducts![index].cartProductQuantity = quantity,
        vendorProducts[i].cartProducts![index].isIncrease = false,
        update(),
        print("Step:: B"),
        Get.find<CartController>().getCart(),
        Get.find<HomeLogic>().getProduct()
      }
    }).catchError((e){
      vendorProducts[i].cartProducts![index].isIncrease = false;
      update();
    });
  }

  void decreaseQuantity({ required int i , required int index }) async{
    CartModel cartModel = vendorProducts[i].cartProducts![index];
    vendorProducts[i].cartProducts![index].isDecrease = true;
    update();
    if((cartModel.cartProductQuantity??0) <= 1){
      await deleteCart(index: index,i: i);
      vendorProducts[i].cartProducts![index].isDecrease = false;
      update();
      return;
    }
    int quantity =((cartModel.cartProductQuantity??0)-1);
    await apiClient.putAPI(ApiProvider.updateCart,{
      "id": cartModel.id,"product_verient_id":cartModel.productVerientId,"product_id":cartModel.productId,"cart_product_quantity":quantity
    }).then((value) => {
      vendorProducts[i].cartProducts![index].isDecrease = false,
      if(value.body['success'] == true){
        subTotal -= cartModel.price ?? 0,
        totalAmount = totalDeliveryCharge + subTotal,
        vendorProducts[i].cartProducts![index].cartProductQuantity = quantity,
        Get.find<CartController>().getCart(),
        Get.find<HomeLogic>().getProduct()
      },
      update(),
    }).catchError((e){
      vendorProducts[i].cartProducts![index].isDecrease = false;
      update();
    });
  }

  // deleteCart({required int i ,required int index , bool fromView = true }) async{
  //   CartModel cartModel = vendorProducts[i].cartProducts![index];
  //   if(fromView){
  //     vendorProducts[i].cartProducts![index].isDeleting = true;
  //     update();
  //   }
  //   apiClient.putAPI(ApiProvider.deleteCart,{"product_id":cartModel.productId,
  //     "product_verient_id":cartModel.productVerientId,}).then((value) => {
  //     print("APK_DONE:: ${value.body}"),
  //     // if(value.body['success'] == true){
  //     //   if(vendorProducts.length == 1 && vendorProducts[i].cartProducts!.length == 1){
  //     //     Get.find<HomeLogic>().getProduct(),
  //     //     Get.find<HomeLogic>().decreaseCartCount(),
  //     //     Get.offAllNamed(rsBasePage)
  //     //   }else{
  //     //     subTotal -= (cartModel.price ?? 0) * (cartModel.cartProductQuantity??1),
  //     //     totalAmount = totalDeliveryCharge + subTotal,
  //     //     vendorProducts[i].cartProducts!.removeAt(index),
  //     //     if(vendorProducts[i].cartProducts!.isEmpty){
  //     //       vendorProducts.removeAt(i)
  //     //     },
  //     //     update(),
  //     //     Get.find<HomeLogic>().decreaseCartCount(),
  //     //     Get.find<CartController>().getCart(),
  //     //     Get.find<HomeLogic>().getProduct(),
  //     //   },
  //     // }else{
  //     //   vendorProducts[i].cartProducts![index].isDeleting = false,
  //     //   update(),
  //     // },
  //   }).whenComplete(() => {
  //     Get.find<CartController>().getCart(notify: false).whenComplete(() => {
  //       initData()
  //     })
  //   });
  // }

  deleteCart({required int i ,required int index , bool fromView = true }) async{
    CartModel cartModel = vendorProducts[i].cartProducts![index];
    if(fromView){
      vendorProducts[i].cartProducts![index].isDeleting = true;
      update();
    }
    apiClient.putAPI(ApiProvider.deleteCart,{"product_id":cartModel.productId,
      "product_verient_id":cartModel.productVerientId,}).whenComplete(() => {
      Get.find<CartController>().getCart(notify: false).whenComplete(() => {
        initData()
      })
    });
  }

  String paymentMethod = "razorpay";
  payNow(){
    orderPlace(transaction: {
      "amount" : totalAmount,
      "payment_method" : paymentMethod,
      "transection_id" :"32".toTransactionId(),
      "is_payment_done" : "1"
    });
  }

  orderPlace({ dynamic transaction }) async{

    dynamic body = {
      "payment_detail" : transaction ??  {},
      "delivery_address" : {
        "first_name": addressModel?.name,
        "email": addressModel?.email,
        "phone_no": addressModel?.number,
        "image": addressModel?.image,
        "address" : addressModel?.address,
        "city" : addressModel?.city,
        "pincode" : addressModel?.pin,
        "user_lat" : addressModel?.lat,
        "user_log" : addressModel?.long,
        "replace_address" : addressModel?.saveAsDefault??false,
      },
      "order" : getOrderBody(mode)
    };
    orderPlaceProcess = true;
    update();
   await apiClient.postAPI(ApiProvider.orderPlace,body ).then((value) => {
      if(value.body['status'] == true){
        Get.find<HomeLogic>().getBackToBase(0),
        Get.toNamed(rsOrderHistoryPage),
        Get.find<HomeLogic>().updateWhenCheckOut(),
        Toast.show(toastMessage: value.body['response']),
      }else{
        Toast.show(toastMessage: value.body['response'],isError: true),
      },
      orderPlaceProcess = false,
      update()
    }).catchError((e){
      orderPlaceProcess = false;
      update();
      Toast.show(toastMessage: "Api Failure".tr,isError: true);
    });
  }

  clearPincodeError({ bool notify = true }){
    if(notAvailable || notAvailableIds.isNotEmpty){
      notAvailableIds = "";
      notAvailable = false;
      if(notify){
        update();
      }
    }
  }

  bool checkService = false;
  serviceAvailable({ bool checkWithCheckout = false }) async{
    if(checkWithCheckout){
      orderPlaceProcess = true;
    }
    checkService = true;
    notAvailableIds = "";
    notAvailable = false;
    Set<String> uniqueVendorIds = <String>{};
    for (int k = 0; k < vendorProducts.length; k++){
      for (int i = 0; i < (vendorProducts[k].cartProducts?.length??0); i++) {
        String vendorId = "${vendorProducts[k].cartProducts![i].vendorId ?? ""}";
        if (vendorId.isNotEmpty) {
          uniqueVendorIds.add(vendorId);
        }
      }
    }

    String vendorIds = uniqueVendorIds.join(",");
    List<String> stringList = vendorIds.split(",");
    update();
    /// check now
   await apiClient.postAPI(ApiProvider.checkAvailable, {"pin": addressModel?.pin,"vendor_id": stringList }).then((value) => {
      if(value.body['status'] == true && value.body['service_not_available'].isEmpty){
        notAvailable = false,
      }else{
        if(value.body['service_not_available'] != null && value.body['service_not_available'].isNotEmpty){
          notAvailableIds = value.body['service_not_available'].join(","),
        }else{
          notAvailable = true,
        }
      }
    },onError: (e){
      notAvailable = true;
    }).whenComplete(() => {
      checkService = false,
      orderPlaceProcess = false,
      if(checkWithCheckout && (!notAvailable && notAvailableIds.isEmpty)){
        if(mode == PaymentMethod.cod){
          orderPlace(),
        }else if(mode == PaymentMethod.payNow){
          payNow(),
        }
      }else{
        update(),
      }
    });
    //;
  }

  setUnavailableService(String vendorIds){
    for (int k = 0; k < vendorProducts.length; k++){
      for (int i = 0; i < (vendorProducts[k].cartProducts?.length??0); i++) {
        if (vendorIds.contains("${vendorProducts[k].cartProducts![i].vendorId}")) {
          notAvailable = true;
        }
      }
    }
    update();
  }

  getOrderBody(PaymentMethod? mode){
    List<Map<String, dynamic>> mapList = [];
    for(int i = 0; i < _vendorProducts.length;i++){
      mapList.add({
        "vendor_id": _vendorProducts[i].vendorId,
        "coupan_code": ""
      });
    }
    return mapList;
  }

}
