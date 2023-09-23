import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/controller/account_controller.dart';
import 'package:indiakinursery/core/di/api_provider.dart';

import '../../core/di/api_client.dart';
import '../../model/OrderModel.dart';
import '../widget/toast.dart';

class SupportLogic extends GetxController {
  final ApiClient apiClient;
  SupportLogic({required this.apiClient});

  int? orderId;
  dynamic argumentData = Get.arguments;

  @override
  void onInit() {
    if(argumentData?['order_id'] != null){
      orderId = int.tryParse(argumentData['order_id'].toString());
      orderIdController.text = "${orderId??''}";
      update();
    }
    super.onInit();

  }

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController orderIdController = TextEditingController();
  final TextEditingController issueController = TextEditingController();
  
  submitNow() async{
    if(validateLoginData()) return;
   await apiClient.postAPI(ApiProvider.addComplain, {
      "order_id": orderIdController.text,
      "first_name": Get.find<AccountLogic>().userModel?.firstName??"",
      "last_name": Get.find<AccountLogic>().userModel?.lastName??"",
      "contect_no": Get.find<AccountLogic>().userModel?.phoneNo??"",
      "subject": subjectController.text,
      "email": Get.find<AccountLogic>().userModel?.email??"",
      "description": issueController.text
    }).then((value) => {
      if(value.body['status'] == true){
        Get.back(),
        Toast.show(toastMessage: value.body["Message"]??"Your Request Submitted")
      }
    });
  }


  validateLoginData(){
    if(subjectController.text.isNotEmpty)
      if(issueController.text.isNotEmpty)
        return false;
      else
        Toast.show(toastMessage: "Enter Subject",isError: true);
    else
      Toast.show(toastMessage: "Enter description you have",isError: true);
    return true;

  }
  

}
