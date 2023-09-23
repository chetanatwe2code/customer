import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/controller/account_controller.dart';
import 'package:indiakinursery/core/di/api_provider.dart';
import 'package:indiakinursery/model/ProductModel.dart';
import 'package:indiakinursery/view/widget/toast.dart';

import '../../core/di/api_client.dart';

class AddReviewLogic extends GetxController {
  final ApiClient apiClient;
  AddReviewLogic({required this.apiClient});


  double? rating;
  ProductModel? product;

  dynamic argumentData = Get.arguments;

  @override
  void onInit() {
    rating = double.tryParse((argumentData?['rating']??"").toString());
    product = ProductModel.fromJson(argumentData?['product']??{});
    super.onInit();
  }


  final TextEditingController commentController = TextEditingController();

  bool isSubmitting = false;
  bool withReview = true;
  submitReview() async{
    if((rating??0)<=0){
      Toast.show(toastMessage: "Please Give rating",isError: true);
      return;
    }
    if(withReview && commentController.text.isEmpty){
      Toast.show(toastMessage: "Please Write review",isError: true);
      return;
    }
    isSubmitting = true;
    update();
    dynamic body = {
      "product_id": product?.id,
      "user_name": "${Get.find<AccountLogic>().userModel?.firstName??""} ${Get.find<AccountLogic>().userModel?.lastName??""}" ,
      "product_name": product?.name,
      "review_date":  "${DateTime.now()}",
      "review_rating": rating,
     "comment": withReview ? commentController.text : ""
    };
     await apiClient.postAPI(ApiProvider.addProductReview, body).then((value) => {
       if(value.body['status'] == true){
         Get.back(),
       },
       Toast.show(toastMessage: value.body['message'])
     }).whenComplete(() => {
         isSubmitting = false,
         update(),
     });


  }

}
