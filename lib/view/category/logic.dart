import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/controller/home_controller.dart';
import 'package:indiakinursery/model/CategoryModel.dart';

import '../../core/di/api_client.dart';
import '../../core/di/api_provider.dart';

class CategoryLogic extends GetxController {
  final ApiClient apiClient;
  CategoryLogic({required this.apiClient});

  List<CategoryModel>? listCategory;
  CategoryModel? selectedCategory;

  initData(){
    listCategory = Get.find<HomeLogic>().categoryList;
    if(Get.arguments?['category'] != null && selectedCategory == null){
      selectedCategory =  CategoryModel.fromJson(Get.arguments?['category']);
    }else if(listCategory?.isNotEmpty??false){
      selectedCategory = listCategory?.first;
    }
    getChildCategory(fromInit: true);
  }


  setSelectedCategory(CategoryModel? cat){
    selectedCategory = cat;
    update();
    getChildCategory();
  }

  List<CategoryModel> childCategory = [];
  bool getChildCategoryProcess = false;
  getChildCategory({ bool fromInit = false }) async{
    if(getChildCategoryProcess) return;
    getChildCategoryProcess = true;
    childCategory.clear();
    if(fromInit){
      WidgetsBinding.instance.addPostFrameCallback((_){
        update();
      });
    }else{
      update();
    }
   await apiClient.postAPI(ApiProvider.getCategory,{"parent_id": selectedCategory?.id}).then((value) => {
      value.body['response'].forEach((v){
        childCategory.add(CategoryModel.fromJson(v));
      }),
      print("childCategory ${value.body}")
    }).whenComplete(() => {
      getChildCategoryProcess = false,
      update(),
    });
  }

}
