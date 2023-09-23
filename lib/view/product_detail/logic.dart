import 'package:get/get.dart';
import 'package:indiakinursery/model/ProductReview.dart';

import '../../core/di/api_client.dart';
import '../../core/di/api_provider.dart';
import '../../model/ProductModel.dart';
import '../../utils/string_helper.dart';


class ProductDetailLogic extends GetxController {
  final ApiClient apiClient;
  ProductDetailLogic({required this.apiClient});

  dynamic argumentData = Get.arguments;

  //bool comeFromHome = false;

  ProductModel? productModel;
  List<String> productImage = [];
  int current = 0;
  List productId = [];
  List variantId = [];
  setIndex(int index){
    current = index;
    update();
  }

  changeVariation(ProductModel? model,{ bool fromGetProduct = true }){
    productModel = model;
    productImage.clear();
    String coverImage = model?.coverImage??"";
    productImage.addAll(StringHelper().listOfCommaSeparated(value: model?.allImagesUrl));
    if (coverImage.isNotEmpty) {
      productImage.remove(coverImage);
      String firstImageUrl = StringHelper.fistValueOfCommaSeparated(value: coverImage);
      if (firstImageUrl.isNotEmpty) {
        productImage.insert(0, firstImageUrl);
      }
    }
    update();
    getRelatedProduct(productModel?.category);
  }


  @override
  void onInit() {
    productId.add(argumentData?['product_id']??0);
    variantId.add(argumentData?['variant_id']??0);
    //comeFromHome = argumentData?['from_home']??false;
    super.onInit();
    getProduct();
    getProductVariation();
    getProductReview();
  }

  bool apiProcess = false;
  getProduct() async{
    productModel = null;
    productImage.clear();
    current = 0;
    apiProcess = true;
   await apiClient.postAPI("${ApiProvider.getProduct}?page=0&per_page=1", {
      "price_from":"",
      "price_to":"",
      "price__":"",
      "rating__":"",
      "name__":"",
      "created_on__":"",
      "search":"",
      "order_by":"",
      'product_verient_id' : variantId
    }).then((value) => {
      if(value.body['results'] != null){
        value.body['results'].forEach((v){
          productModel = ProductModel.fromJson(v);
        }),
        changeVariation(productModel,),
        if(productImage.isEmpty){
          productImage.add(StringHelper.defaultProductImage)
        },
        apiProcess = false,
        update(),
        //getRelatedProduct(productModel?.category),
      },
    },onError: (e){
      apiProcess = false;
      update();
    }).catchError((e){
      apiProcess = false;
      update();
    });
  }

  List<ProductModel> relatedProduct = [];
  getRelatedProduct(String? category) async{
    if(category?.isEmpty??true) return;
    relatedProduct.clear();
   await apiClient.postAPI("${ApiProvider.getProduct}?page=0&per_page=10&DESC=verient_created_on", {
      "price_from":"",
      "price_to":"",
      "price__":"",
      "rating__":"",
      "name__":"",
      "created_on__":"",
      "search":"",
      "order_by":"",
      "category":[StringHelper.fistValueOfCommaSeparated(value: category)]
    }).then((value) => {
      if(value.body['results'] != null){
        value.body['results'].forEach((v){
          if(v['id'].toString() != productId.first.toString()){
            relatedProduct.add(ProductModel.fromJson(v));
          }
        }),
      },
    }).whenComplete(() => {
      update(),
    });
  }


  ///
  List<ProductModel> productVariation = [];
  getProductVariation() async{
    productVariation.clear();
   await apiClient.postAPI("${ApiProvider.getProduct}?page=0&per_page=10&DESC=verient_created_on", {
      "price_from":"",
      "price_to":"",
      "price__":"",
      "rating__":"",
      "name__":"",
      "created_on__":"",
      "search":"",
      "order_by":"",
      "id": ["${argumentData?['product_id']??0}"]
    }).then((value) => {
      if(value.body['results'] != null){
        value.body['results'].forEach((v){
            productVariation.add(ProductModel.fromJson(v));
        }),
      },
    }).whenComplete(() => {
      update(),
    });
  }

  /// get revieww
  List<ProductReview> productReview = [];
  getProductReview() async{
    productVariation.clear();
   await apiClient.postAPI(ApiProvider.getProductReview,{
      "product_id": productId,
      "product_name":"",
      "status":""
    }).then((value) => {
      value.body.forEach((v){
        productReview.add(ProductReview.fromJson(v));
      }),
    }).whenComplete(() => {
      update(),
    });
  }

}
