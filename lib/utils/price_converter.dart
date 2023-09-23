
import '../controller/checkout_logic.dart';
import '../model/CartModel.dart';

class PriceConverter {

 // 50.70
  static getGst({ double? gst,double? price,int? count }){

    gst ??= 0;
    price ??= 0;
    count ??= 0;
    double v = (price - (price / (1 + (gst / 100))))*count;
    return removeDecimalZeroFormat(v);
  }

  static CheckoutSummary getCartGstAndDiscountPrice({List<CartModel>? cartModel,bool withShip = true}) {
    double gstPrice     = 0;
    double discountPrice = 0;
    double totalAmount = 0;
    double totalMrpAmount = 0;
    double subTotalAmount = 0;
    double gstOnPrice    =  0;

    List<int> vendorId = [];
    double shippingCharge    =  0;
    for(int i = 0;i < (cartModel?.length??0);i++){
      if(!vendorId.contains(cartModel?[i].vendorId)){
        print("cartModel?[i].vendorId ${cartModel?[i].vendorId}");
        vendorId.add(cartModel?[i].vendorId??-1);
        shippingCharge += withShip ? 100 : 0;
      }
      double unitPrice           =  0;

      int cartQuantity  = cartModel?[i].cartProductQuantity ?? 1;// 500
      double mrp           = cartModel?[i].mrp ?? 0; /// 550
      double discount      = cartModel?[i].discount ?? 0; /// 10
      double price          = cartModel?[i].price ?? 0; // 10
      double gst          = cartModel?[i].gst ?? 0; // 10


      if(mrp > 0){
        totalMrpAmount += mrp*cartQuantity;
        unitPrice = mrp / (1 + (gst / 100));
        subTotalAmount += unitPrice;
      }
      if(discount > 0){
        discountPrice += ((mrp * discount) / 100)*cartQuantity;
      }
      if(gst > 0){
        gstPrice += getGst(count: cartQuantity,gst: gst,price: price);
      }
      totalAmount += ((cartModel?[i].price??0)*cartQuantity);
    }

    return CheckoutSummary(
        totalMrpAmount: removeDecimalZeroFormat(totalMrpAmount),
        totalAmount: removeDecimalZeroFormat(totalAmount + shippingCharge),
        totalShipCharge: removeDecimalZeroFormat(shippingCharge),
        totalGst: removeDecimalZeroFormat(gstPrice),
        subTotalAmount: removeDecimalZeroFormat(subTotalAmount),
        totalDiscount: removeDecimalZeroFormat(discountPrice));
   }

  // static Map<String,String> getGstAndDiscountPrice({
  //   double? mrp,
  //   double? discount,
  //   double? sGst,
  //   double? cGst}) {
  //   mrp ??= 0;
  //   discount ??= 0;
  //   sGst ??= 0;
  //   cGst ??= 0;
  //   double sGstPrice = 0;
  //   double cGstPrice = 0;
  //   double discountPrice = 0;
  //   if(sGst > 0){
  //     sGstPrice += mrp * (sGst / 100) / (1 + (sGst / 100));
  //   }
  //   if(sGst > 0){
  //     cGstPrice += mrp * (cGst / 100) / (1 + (cGst / 100));
  //   }
  //   if(discount > 0){
  //     discountPrice += (mrp * discount) / 100;
  //   }
  //
  //   return {
  //     "gst" : "\u{20B9}${removeDecimalZeroFormat(sGstPrice + cGstPrice)}",
  //     "sGst" : "\u{20B9}${removeDecimalZeroFormat(sGstPrice)}",
  //     "cGst" : "\u{20B9}${removeDecimalZeroFormat(cGst)}",
  //     "discountPrice" : "\u{20B9}${removeDecimalZeroFormat(discountPrice)}"
  //   };
  // }

  static String getSingleDigit(double? value) {
    return (value??0.0).toStringAsFixed(0);
  }

  static double removeDecimalZeroFormat(double value , { int asFixed = 2 }) {
    return double.tryParse(value.toStringAsFixed(asFixed))??0.0;
  }

  static String removeDecimalZeroFormat2(double value , { int asFixed = 2 }) {
    return value.toStringAsFixed(asFixed);
  }

  static String removeDecimalZeroFormatWithFlag(double value , { int asFixed = 2 }) {
    return "\u{20B9}${value.toStringAsFixed(asFixed)}";
  }

  static String getFlag() {
    return "\u{20B9}";
  }

}