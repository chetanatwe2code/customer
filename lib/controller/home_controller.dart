import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/theme/app_colors.dart';

import '../../model/BrandModel.dart';
import '../../model/CategoryModel.dart';
import '../../model/ProductModel.dart';
import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';
import '../core/routes.dart';
import '../model/BannerModel.dart';
import '../services/init_fcm.dart';
import '../view/widget/count_badge.dart';
import '../view/widget/toast.dart';
import 'account_controller.dart';

enum ProductType {  latest,featured,trending }

class HomeLogic extends GetxController implements GetxService{
  final ApiClient apiClient;
  HomeLogic({required this.apiClient});

  List<ProductModel> trendingList = [];
  List<ProductModel> featuredList = [];
  List<ProductModel> list = [];
  List<CategoryModel> categoryList = [];
  List<BrandModel> bandList = [];
  var notificationCount = 0.obs;
  var cartCount = 0.obs;

  int selectedIndex = 0;
  setBaseIndex(int index){
    if(index > 3){
      selectedIndex = 0;
    }else{
      selectedIndex = index;
    }
    update();
  }

  toIndex(int index,{ bool notify = true }){
    if(index > 3) return;
    selectedIndex = index;
    if(notify){
      update();
    }
  }

  setBaseIndex2(int index){
    if(index > 3){
      selectedIndex = 0;
    }else{
      selectedIndex = index;
    }
    Get.offAllNamed(rsBasePage);
  }

  getBackToBase(int index){
    selectedIndex = index;
    Get.offAllNamed(rsBasePage);
  }

  getBottomBar({ int activeIndex = 0 }){
    return BottomNavigationBar(
      onTap: setBaseIndex2,
      iconSize: 24,
      /// how can set selected color same as unselected
      selectedItemColor: const Color(0xFF737373),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      unselectedItemColor: const Color(0xFF737373),
      type: BottomNavigationBarType.fixed,
      currentIndex: activeIndex,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(FlutterRemix.home_fill),
            label: "Home".tr,
            backgroundColor: Colors.green
        ),

        BottomNavigationBarItem(
            icon: const Icon(FlutterRemix.dashboard_fill),
            label: "Category".tr,
            backgroundColor: Colors.green
        ),

        BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: "Search".tr,
            backgroundColor: Colors.green
        ),

        BottomNavigationBarItem(
            icon: GetBuilder<HomeLogic>(
              assignId: true,
              builder: (logic) {
                return CountBadge(
                    icon: FlutterRemix.shopping_basket_2_fill, count: logic
                    .cartCount
                    .value);
              },
            ),
            label: "Cart".tr,
            backgroundColor: Colors.green
        ),

      ],
    );
  }

  dynamic argumentData = Get.arguments;

  final GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    pullRefresh();
   // initFCMToken();
  }

  getProduct(){
    getLatestProduct();
    getFeaturedProduct();
    getTrendingProduct();
  }

  bool noInternet = false;

  initFCMToken() async{
    InitFcm().initialize();
    if((argumentData?['from_login']??0)==1){
      await FirebaseMessaging.instance.getToken().then((value) => {
        Get.find<AccountLogic>().setFCMToken(token: value ?? "")
      });
    }
  }

  increaseNotificationCount(){
    notificationCount.value += 1;
    update();
  }


  resetNotificationCount(){
    notificationCount.value = 0;
    update();
  }

  decreaseCartCount(){
    print("CART_UPDATE");
    cartCount.value -= 1;
    update();
  }

  increaseCartCount(){
    print("CART_UPDATE");
    cartCount.value += 1;
    update();
  }

  updateWhenCheckOut() async{
    cartCount.value = 0;
    await getProduct();
  }

  pullRefresh() async{
   getBanner();
   getCategoryAndBrand();
   getProduct();
   getCartNotificationCount();
   if(Get.find<AccountLogic>().userModel == null){
     await Get.find<AccountLogic>().getAccountDetails();
   }
  }

  int bannerCurrentIndex = 0;
  setIndex(int index){
    bannerCurrentIndex = index;
    update();
  }
  List<BannerModel> bannerList = [];
  bool getBannerProcess = false;
  getBanner() async{
    getBannerProcess = true;
    bannerList.clear();
    update();
    bannerList.add(BannerModel(bannerImageUrl: "https://thumbs.dreamstime.com/b/child-his-father-plant-nursery-garden-selective-focus-people-child-his-father-plant-nursery-garden-selective-186355704.jpg"));
    bannerList.add(BannerModel(bannerImageUrl: "https://m.media-amazon.com/images/I/51Wb8gigSML._AC_UF894,1000_QL80_.jpg"));
   // await apiClient.postAPI(ApiProvider.getBanner,{}).then((value) => {
   //    if(value.statusCode == 200){
   //      if(value.body['success'] == true){
   //        value.body['response'].forEach((v){
   //          bannerList.add(BannerModel.fromJson(v));
   //        }),
   //      }
   //    },
   //  },onError: (e){
   //    if(e.message == ApiClient.noInternetMessage){
   //      noInternet = true;
   //      Toast.show(isError: true,toastMessage: e.message);
   //    }
   //  }).whenComplete(() => {
   //    getBannerProcess = false,
   //      update()
   //  });
    getBannerProcess = false;
    update();
  }

  bool getBrandProcess = false;
  getCategoryAndBrand() async{
    bandList.clear();
    categoryList.clear();
    getBrandProcess = true;
    noInternet = false;
   await apiClient.postAPI(ApiProvider.getCategory,{"parent_id": 0}).then((value) => {
      value.body['response'].forEach((v){
        categoryList.add(CategoryModel.fromJson(v));
      }),
    },onError: (e){
      if(e.message == ApiClient.noInternetMessage){
        noInternet = true;
      }
    }).whenComplete(() => {
      getBrandProcess = false,
      update(),
    });
  }

  bool getProductProcess = false;
  getLatestProduct() async{
    list.clear();
    getProductProcess = true;
    update();
   await apiClient.postAPI("${ApiProvider.getProduct}?page=0&per_page=10&DESC=verient_created_on", {
      "price_from":"",
      "price_to":"",
      "price__":"",
      "rating__":"",
      "name__":"",
      "created_on__":"",
      "search":"",
      "order_by":""
    }).then((value) => {
      if(value.body['results'] != null){
        value.body['results'].forEach((v){
          list.add(ProductModel.fromJson(v));
        }),
      },
    },onError: (e){
      if(e.message == ApiClient.noInternetMessage){
        noInternet = true;
      }
    }).whenComplete(() => {
        getProductProcess = false,
        update(),
    });
  }

  bool getFeaturedProductProcess = false;
  getFeaturedProduct() async{
    featuredList.clear();
    getFeaturedProductProcess = true;
    update();
   await apiClient.postAPI("${ApiProvider.getProduct}?page=0&per_page=10&is_featured=yes&DESC=verient_created_on", {
      "price_from":"",
      "price_to":"",
      "price__":"",
      "rating__":"",
      "name__":"",
      "created_on__":"",
      "search":"",
      "order_by":""
    }).then((value) => {
      if(value.body['results'] != null){
        value.body['results'].forEach((v){
          featuredList.add(ProductModel.fromJson(v));
        }),
      },
    },onError: (e){
      if(e.message == ApiClient.noInternetMessage){
        noInternet = true;
      }
    }).whenComplete(() => {
      getFeaturedProductProcess = false,
      update(),
    });
  }

  bool getTrendingProductProcess = false;
  getTrendingProduct() async{
    trendingList.clear();
    getTrendingProductProcess = true;
    update();
   await apiClient.postAPI("${ApiProvider.getTrendingProduct}?page=0&per_page=10&DESC=verient_created_on", {}).then((value) => {
      if(value.body['results'] != null){
        value.body['results'].forEach((v){
          trendingList.add(ProductModel.fromJson(v));
        }),
      },
    },onError: (e){
      if(e.message == ApiClient.noInternetMessage){
        noInternet = true;
      }
    }).whenComplete(() => {
      getTrendingProductProcess = false,
      update(),
    });
  }

  getCartNotificationCount() async{
    print("STEP____D");
   await Get.find<ApiClient>().getAPI(ApiProvider.getCartNotificationCount).then((value) => {
      if(value.body['success'] == true){
        print("STEP____E__${value.body}"),
        notificationCount.value = int.tryParse(value.body['response'][1]['unread_notification_count'].toString())??0,
        cartCount.value = int.tryParse(value.body['response'][0]['cart_count'].toString())??0,
        update()
      }
    });
  }
}
