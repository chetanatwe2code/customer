import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/controller/home_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';
import '../model/BrandModel.dart';
import '../model/CategoryModel.dart';
import '../model/ProductModel.dart';
import '../view/search/widget/search_filter.dart';

class SearchLogic extends GetxController implements GetxService{
  final ApiClient apiClient;
  SearchLogic({required this.apiClient});

  /// product list
  List<ProductModel> list = [];
  List<int> selectedCategory = [];
  int? categoryFromCategory;
  String? productTypeName;// = Get.arguments?['productType'] ?? ProductType.latest.name;

  /// create list
  clearList({ bool notify = false }){
    list.clear();
    if(notify){
      update();
    }
  }


  /// for list pagination
  RefreshController refreshController = RefreshController(initialRefresh: false);

  getEndPoint(){
    print("productType $productTypeName");
    if(productTypeName == ProductType.trending.name){
      return "${ApiProvider.getTrendingProduct}?";
    }else if(productTypeName == ProductType.featured.name){
      return "${ApiProvider.getProduct}?is_featured=yes&";
    }
    return "${ApiProvider.getProduct}?";
  }

  String keyword = "";
  bool isSearching = false;
  int pageSize = 10;
  int pageKey = 0;
  bool isNext = false;


  getAsc(){
    if(selectedValue == ShortBy.aToZ){
      return "&ASC=verient_name";
    }
    if(selectedValue == ShortBy.zToA){
      return "&DESC=verient_name";
    }
    if(selectedValue == ShortBy.priceLToH){
      return "&DESC=price";
    }
    if(selectedValue == ShortBy.priceHToL){
      return "&ASC=price";
    }
    if(selectedValue == ShortBy.ratingLtoH){
      return "&DESC=avgRatings";
    }
    if(selectedValue == ShortBy.ratingHtoL){
      return "&ASC=avgRatings";
    }
    return "&DESC=verient_created_on";
  }


  /// search product by any txt key with filter option
  searchProduct({ bool withSearch = true , String keyword = "" , bool isNextPage = false }) async{
    if(isSearching && keyword.isNotEmpty) return;
    if(isNextPage){
      if(isNext){
        pageKey += 1;
      }else{
        refreshController.loadComplete();
        return;
      }
    }else{
      pageKey = 0;
      isSearching = true;
      list.clear();
    }
    this.keyword = keyword;
    String productTypeName = Get.arguments?['productType'] ?? ProductType.latest.name;
    if((categoryFromCategory != null) && !filterMap['category'].contains(categoryFromCategory!)){
      filterMap['category'].add(categoryFromCategory!);
      addSelectedCategory(categoryFromCategory);
      applyFilter();
      categoryFromCategory = null;
    }
    dynamic body = productTypeName == ProductType.trending.name ? {} : {
      "price_from":withSearch ?  filterMap['price_from'] : [],
      "price_to": withSearch ?  filterMap['price_to'] : [],
      "price__":"",
      "rating__":"",
      "name__":"",
      "created_on__":"",
      "search": withSearch ? keyword : "",
      "order_by":"",
      "category": withSearch ? filterMap['category'] : [],
      "avgRatings": withSearch ? filterMap['rating'] : [],
      "brand": withSearch ? filterMap['brand'] : [],
    };
    update();
   await apiClient.postAPI("${getEndPoint()}page=$pageKey&per_page=$pageSize${getAsc()}",body).then((value) => {
      if(value.body['results'] != null){
        value.body['results'].forEach((v){
          list.add(ProductModel.fromJson(v));
        }),
        if(value.body['pagination'] != null){
          if((int.tryParse(value.body['pagination']['next'].toString())??0) > 0){
            isNext = true,
          }else{
            isNext = false,
          }
        }else{
          isNext = false,
        },
      },
    }).catchError((onError){
      print("onError $onError");
    })
        .whenComplete(() => {
      isSearching = false,
      if(isNextPage){
        refreshController.loadComplete(),
      }else{
        refreshController.refreshCompleted(),
      },
      update(),
    });
  }


  /// get default category and brands
  List<CategoryModel> categoryList = [];
  getCategory() async{
    if(categoryList.isNotEmpty) return;
    categoryList.clear();
    sortedCategories.clear();
   await apiClient.postAPI(ApiProvider.getCategory,{}).then((value) => {
      if(value.body['status'] == true){
        value.body['response'].forEach((v){
          categoryList.add(CategoryModel.fromJson(v));
        }),
        sortedCategories = categoryList,
        update()
      }
    });
  }



  /// Category Filter code
  bool checkIfExist(int? category){
    if (category != null && selectedCategory.contains(category)) {
      return true;
    }
    return false;
  }
  addSelectedCategory(int? category){
    if ((category != null) && !selectedCategory.contains(category)) {
      selectedCategory.add(category);
      update();
    }
  }
  removeSelectedCategory(int? category){
    if ((category != null) && selectedCategory.contains(category)) {
      selectedCategory.remove(category);
      update();
    }
  }

  List<CategoryModel> sortedCategories = [];
  final TextEditingController categoryController = TextEditingController();
  searchCategory(String key) async {
    sortedCategories = categoryList.where((category) => (category.category??"").contains(key)).toList();
    update();
  }


  clearCategoryText(){
    selectedCategory.clear();
    categoryController.clear();
    checkFilterAdded(notify: true);
  }


  /// Price Filter code
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  bool invalidMaxPrice = false;
  setMaxError({ bool? error }){
    if(minPriceController.text.isNotEmpty){
      invalidMaxPrice = error ?? (double.tryParse(minPriceController.text)??0) > (double.tryParse(maxPriceController.text)??0);
    }else{
      invalidMaxPrice = error ?? false;
    }
    update();
  }

  isValidPriceFilter(){
    if(minPriceController.text.isNotEmpty && maxPriceController.text.isNotEmpty){
      return (double.tryParse(minPriceController.text)??0) <= (double.tryParse(maxPriceController.text)??0);
    }
    if(minPriceController.text.isNotEmpty || maxPriceController.text.isNotEmpty){
      return true;
    }
    return false;
  }

  /// for update UI {un_used}
  FilterType filterTYpe = FilterType.price;
  activeFilterType({FilterType? type}){
    filterTYpe = type??FilterType.price;
    update();
  }

  ///   String? selectedValue;
  ShortBy? selectedValue;

 /// Apply filter for any product search
  Map<String, dynamic> filterMap = {
    "price_from": "",
    "price_to": "",
    "brand": [],
    "category": [],
    "rating": [],
  };
  applyFilter(){
    bool isValidPrice = isValidPriceFilter();
    filterMap = {
      "price_from": isValidPrice ? minPriceController.text : "",
      "price_to": isValidPrice ? maxPriceController.text : "",
      "brand": [],
      "category": selectedCategory,
      "rating": rating > 0 ? [rating] : []
    };
  }

  bool filterIsAdded = false;
  changeFilterIsAdded(bool b,{bool notify = false}){
    filterIsAdded = b;
    update();
  }

  checkFilterAdded({bool notify = true}){
    if(isValidPriceFilter() || selectedCategory.isNotEmpty || rating > 0 || selectedValue != null){
      filterIsAdded = true;
    }else{
      filterMap = {
        "price_from": "",
        "price_to": "",
        "brand": [],
        "category": [],
        "rating": []
      };
      filterIsAdded = false;
    }
    if(notify){
      update();
    }
  }

  // Rating
  double rating = 0;
  updateRating(double rating){
    this.rating = rating;
    checkFilterAdded();
    update();
  }


  /// clear filter
  clearFilter({ bool notify = true }){
    minPriceController.clear();
    maxPriceController.clear();
    categoryController.clear();
    rating = 0;
    selectedCategory.clear();
    filterIsAdded = false;
    invalidMaxPrice = false;
    selectedValue = null;
    productTypeName = null;
    filterMap = {
      "price_from": "",
      "price_to": "",
      "brand": [],
      "category": [],
      "rating": []
    };
    if(notify){
      update();
    }
  }

}

enum FilterType { price, brand, category , rating }
