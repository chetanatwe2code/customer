import 'package:get/get.dart';
import 'package:indiakinursery/controller/home_controller.dart';
import 'package:indiakinursery/model/CategoryModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/di/api_client.dart';
import '../../core/di/api_provider.dart';
import '../../model/ProductModel.dart';



class ProductLogic extends GetxController {
  final ApiClient apiClient;
  ProductLogic({required this.apiClient});

  dynamic argumentData = Get.arguments;

  List<String> category = [];
  List<String> brand = [];

  List<ProductModel> list = [];

  String? appBarTitle;

  ProductType? productType;


  @override
  void onInit() {
    productType = argumentData?['productType'] ?? ProductType.latest;
    if(argumentData?['category'] != null){
      category.add(argumentData?['category']??"");
      appBarTitle = argumentData?['category'] ?? "";
    }
    // if(argumentData?['brand'] != null){
    //   brand.add(argumentData?['brand']??"");
    // }

    super.onInit();
    update();
  }

  getEndPoint(){
    if(productType == ProductType.trending){
      return ApiProvider.getTrendingProduct;
    }else if(productType == ProductType.featured){
     return "${ApiProvider.getProduct}?is_featured=yes&";
    }
    return "${ApiProvider.getProduct}?";
  }

  getFormData(){
    if(productType == ProductType.trending){
      return {};
    }
    return {
      "price_from":"",
      "price_to":"",
      "price__":"",
      "rating__":"",
      "name__":"",
      "created_on__":"",
      "search":"",
      "order_by":"",
      "category": category,
      "brand":brand,
    };
  }

  int pageSize = 10;
  int pageKey = 0;
  bool isNext = false;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  ///
  bool apiProcess = false;
  getProduct({ bool isNextPage = false }) async{
    if(isNextPage){
      if(isNext){
        pageKey += 1;
      }else{
        refreshController.loadComplete();
        return;
      }
    }else{
      apiProcess = true;
      pageKey = 0;
      list.clear();
    }
   await apiClient.postAPI("${getEndPoint()}page=$pageKey&per_page=$pageSize&DESC=verient_created_on", getFormData()).then((value) => {
      if(value.body['results'] != null){
        value.body['results'].forEach((v){
          list.add(ProductModel.fromJson(v));
        }),
        if((int.tryParse(value.body['pagination']['next'].toString())??0) > 0){
          isNext = true,
        }else{
          isNext = false,
        },
        apiProcess = false,
        update(),
        if(isNextPage){
          refreshController.loadComplete(),
        }else{
          refreshController.refreshCompleted(),
        },
      },
    },onError: (e){
      apiProcess = false;
      update();
    }).catchError((e){
      apiProcess = false;
      update();
    });
  }

}
