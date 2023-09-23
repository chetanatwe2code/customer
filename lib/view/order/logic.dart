import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/core/di/api_provider.dart';
import 'package:indiakinursery/model/OrderDetailsModel.dart';
import 'package:indiakinursery/model/OrderModel.dart';
import 'package:indiakinursery/theme/app_colors.dart';
import 'package:indiakinursery/utils/price_converter.dart';
import 'package:indiakinursery/view/order_list/logic.dart';

import '../../core/di/api_client.dart';
import '../widget/order/show_status.dart';
import '../widget/toast.dart';

enum OrderStatusCode { one,two,three,four,negative }


Color getStatusColor(OrderStatusCode status){
  if(status == OrderStatusCode.one){
    return Colors.blue;
  }
  if(status == OrderStatusCode.two){
    return Colors.orange;
  }
  if(status == OrderStatusCode.three){
    return Colors.deepPurpleAccent;
  }
  if(status == OrderStatusCode.four){
    return Colors.green;
  }
  if(status == OrderStatusCode.negative){
    return AppColors.redColor();
  }
  return Colors.blue;
}

String getStatusName(OrderStatusCode status){
  if(status == OrderStatusCode.one){
    return "Pending";
  }
  if(status == OrderStatusCode.two){
    return "In-Progress";
  }
  if(status == OrderStatusCode.three){
    return "Shipped";
  }
  if(status == OrderStatusCode.four){
    return "Delivered";
  }
  if(status == OrderStatusCode.negative){
    return "Cancelled";
  }
  return "Pending";
}

enum OrderCode {
  pending,
  approved,
  accepted_by_vendor,
  ready_to_packing,
  ready_to_pickup,
  Pickuped,
  shipped,
  Delivered,
  rejected_by_vendor,
  Rejected_by_customer,
  Failed_Delivery_Attempts,
  cancel
}

OrderStatusCode getStatusCode({ String? status }){
  print("statusCode $status");

  status ??= "pending";

  if(status.endsWith('pending')){
    return OrderStatusCode.one;
  }
  if(status.endsWith('approved')
      || status.endsWith('accepted_by_vendor')
      || status.endsWith('ready_to_packing')
      || status.endsWith('ready_to_pickup')
  ){
    return OrderStatusCode.two;
  }
  if(status.endsWith('Pickuped')
      || status.endsWith('shipped')){
    return OrderStatusCode.three;
  }
  if(status.endsWith('Delivered')){
    return OrderStatusCode.four;
  }
  if(status == "rejected_by_vendor" ||
      status == "Rejected_by_customer" ||
      status == "Failed_Delivery_Attempts" ||
      status == "cancel"){
    return OrderStatusCode.negative;
  }
  return OrderStatusCode.one;
}

class OrderLogic extends GetxController {
  final ApiClient apiClient;
  OrderLogic({required this.apiClient});

  int? orderId;
  dynamic argumentData = Get.arguments;

  getGrandTotal(){
    double totalAmount = orderDetailsModel?.orderDetaile?[0].onlyThisOrderProductTotal??0.0;
    double shippingCharges = orderDetailsModel?.orderDetaile?[0].shippingCharges??0.0;
    return PriceConverter.removeDecimalZeroFormat(totalAmount + shippingCharges);
  }

  @override
  void onInit() {
    super.onInit();
    orderId = int.tryParse((argumentData?['order_id']).toString());
    getOrderDetails();
  }

  List<StepModel> totalSteps = [];
  bool orderCancelled = false;
  initSteps(){
    int stepLevel = 1;

    if (orderStatusCode == OrderStatusCode.negative) {
      orderCancelled = true;
    }

    if(orderStatusCode == OrderStatusCode.four){
      stepLevel = 4;
    }else if(orderStatusCode == OrderStatusCode.three){
      stepLevel = 3;
    }else if(orderStatusCode == OrderStatusCode.two){
      stepLevel = 2;
    }

    totalSteps = [
      StepModel(isCompleted: stepLevel >= 1, name: "Order Received"),
      StepModel(isCompleted: stepLevel >= 2, name: "Order Processed"),
      StepModel(isCompleted: stepLevel >= 3, name: "Order Shipped"),
      StepModel(isCompleted: stepLevel >= 4, name: "Order Delivered"),
    ];
    update();
  }


  OrderDetailsModel? orderDetailsModel;
  bool apiProcess = false;

  OrderStatusCode orderStatusCode = OrderStatusCode.one;

  getOrderDetails() async{
    apiProcess = true;
    update();
   await apiClient.getAPI("${ApiProvider.orderDetails}?id=$orderId").then((value) => {
      if(value.body['success'] == true){
        orderDetailsModel = OrderDetailsModel.fromJson(value.body)
      },
    }).whenComplete(() => {
      apiProcess = false,
      orderStatusCode = getStatusCode(status: orderDetailsModel?.orderDetaile?[0].statusOrder),
      initSteps(),
      update(),
    });
  }


  final TextEditingController reasonController = TextEditingController();
  var closeProcess = false.obs;
  closeOrder({ required String orderID , Function? callBack }){
    closeProcess.value = true;
    apiClient.putAPI(ApiProvider.cancelOrder, {
      "order_id": orderID,
    }).then((value) => {
      if(value.body['status'] == true){
        // if(callBack != null){
        //   callBack(),
        // },
     //   orderDetailsModel?.orderDetaile?[0].statusOrder = "Rejected_by_customer",
        Toast.show(toastMessage: value.body['message']??"Your Order Cancelled"),
      }else{
        Toast.show(toastMessage: value.body['message']??"Something went wrong")
      },
      closeProcess.value = false
    }).whenComplete(() => {
      getOrderDetails(),
      closeProcess.value = false,
      update(),
      if(Get.isRegistered<OrderHistoryLogic>()){
        Get.find<OrderHistoryLogic>().getOrder()
      }
    });
  }


}
