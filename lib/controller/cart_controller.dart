import 'package:get/get.dart';
import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';
import '../model/CartModel.dart';
import '../model/VendorProductModel.dart';
import '../utils/price_converter.dart';
import '../view/product/logic.dart';
import '../view/widget/toast.dart';
import 'home_controller.dart';

class CartController extends GetxController implements GetxService{
  final ApiClient apiClient;
  CartController({required this.apiClient});

  //List<VendorProductModel> v = [];
  final List<VendorProductModel> _vendorProducts = [];
  List<VendorProductModel> get vendorProducts => _vendorProducts;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("onClose:: onClose");
  }

  //var cartPrice = 0.0.obs;
  bool noInternet = false;
  bool apiProgress = false;

  // VendorProductModel

  double totalGst = 0;
  double taxableAmount = 0;
  double subTotal = 0;
  double totalDiscount = 0;
  double totalDeliveryCharge = 0;

  // inCreaseValue(double v){
  //   subTotal = (subTotal) + v;
  //   update();
  // }
  //
  // deCreaseValue(double v){
  //   subTotal = (subTotal) - v;
  //   update();
  // }

  Future<void> getCart({ bool notify = true }) async{
    if(apiProgress) return;
    if(notify){
      apiProgress = true;
    }
    print("ABC_A:::");
    noInternet = false;
    _vendorProducts.clear();
   await apiClient.getAPI(ApiProvider.getCart).then((value) => {
      if(value.body['status']){
        value.body['response'].forEach((e){
          _vendorProducts.add(VendorProductModel.fromJson(e));
          //_cartList.add(CartModel.fromJson(e));
          //cartPrice.value += (double.tryParse(e['price'].toString()) ?? 0.0) * (int.tryParse(e['cart_product_quantity'].toString()) ?? 0);
        }),
        totalGst = double.tryParse(value.body['total_gst'].toString())??0,
        taxableAmount = double.tryParse(value.body['taxable_amount'].toString())??0,
        subTotal = double.tryParse(value.body['sub_total'].toString())??0,
        totalDiscount = double.tryParse(value.body['total_discount'].toString())??0,
        totalDeliveryCharge = double.tryParse(value.body['total_delivery_charge'].toString())??0,
      }else{
        totalGst = 0,
        taxableAmount = 0,
        subTotal = 0,
        totalDiscount = 0,
        totalDeliveryCharge = 0,
      }
     // cartPrice.value = PriceConverter.removeDecimalZeroFormat(cartPrice.value),
    },onError: (e){
       if(e.message == ApiClient.noInternetMessage){
        noInternet = true;
      }
      Toast.show(isError: true,toastMessage: e.message);
    }).whenComplete(() => {
      apiProgress = false,
      update(),
      if(!notify){
        Get.find<HomeLogic>().pullRefresh(),
      }
    });
  }

  Future<Response> updateQuantity({ required int productId,required int variantId,required int quantity , bool fromProductDetail = false,bool fromHome = false}) {
    print("I_AM_CALLING");
    Future<Response> response =   apiClient.putAPI(ApiProvider.updateCart,{
      "product_id":productId,
      "product_verient_id":variantId,
      "cart_product_quantity":quantity
    });
    bool isError = false;
    response.then((value) => {
      if(value.body['success'] == true){
        if (Get.isRegistered<ProductLogic>()) {
          Get.find<ProductLogic>().getProduct(),
        },
        if(!fromHome){
          Get.find<HomeLogic>().getProduct(),
        },
        if(quantity==0){
          Get.find<HomeLogic>().decreaseCartCount()
        }
      }else{
        isError = true
      }
    });
    if(isError){
      throw Exception("Internal Server Error");
    }else{
      return response;
    }
  }

  Future<Response> addToCart({ required int productId,required int variantId,required int quantity, bool fromProductDetail = false,bool fromHome = false}) async{
  Future<Response> response = apiClient.postAPI(ApiProvider.addToCart, {
    "product_id":productId,
    "product_verient_id":variantId,
    "cart_product_quantity":quantity
  });
  bool isError = false;
  response.then((value) => {
    if(value.body['success'] == true){
      if(Get.isRegistered<ProductLogic>()) {
        Get.find<ProductLogic>().getProduct(),
      },
      if(!fromHome){
        Get.find<HomeLogic>().getProduct(),
      },
      Get.find<HomeLogic>().increaseCartCount()
    }else{
      isError = true,
    }
  });
  if(isError){
    throw Exception("Internal Server Error");
  }else{
    return response;
  }
  }

  void increaseQuantity({required int i , required int index }) async{
   CartModel cartModel = vendorProducts[i].cartProducts![index];
    int quantity =((cartModel.cartProductQuantity??0)+1);
   if((cartModel.productStockQuantity??0) < quantity) {
     Toast.show(title: "Product Stock Limited",
         toastMessage: "you cannot add more then ${cartModel.productStockQuantity??0}",
      isError: true);
     return;
   }
   vendorProducts[i].cartProducts![index].isIncrease = true;
   update();
   await apiClient.putAPI(ApiProvider.updateCart, {
      "id": cartModel.id,
     "product_id":cartModel.productId,
     "product_verient_id":cartModel.productVerientId,
     "cart_product_quantity":quantity
    }).whenComplete(() => {
     getCart(notify: false),
   });
  }

  void decreaseQuantity({required int i ,required int index }) async{
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
   await apiClient.putAPI(ApiProvider.updateCart, {
      "id": cartModel.id,
     "product_id":cartModel.productId,
     "product_verient_id":cartModel.productVerientId,
     "cart_product_quantity":quantity
    }).whenComplete(() => {
     getCart(notify: false),
   });
  }

  deleteCart({required int i ,required int index , bool fromView = true }) async{
    CartModel cartModel = vendorProducts[i].cartProducts![index];
    if(fromView){
      vendorProducts[i].cartProducts![index].isDeleting = true;
      update();
    }
    apiClient.putAPI(ApiProvider.deleteCart,
        {"product_id":cartModel.productId,
          "product_verient_id": cartModel.productVerientId,}).whenComplete(() => {
      getCart(notify: false),
    });
  }

}