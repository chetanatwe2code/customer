import 'CartModel.dart';

class VendorProductModel {
  VendorProductModel({
      this.ownerName,
      this.deliveryCharges,
      this.priceXCartQtyAmount,
      this.mrpXCartQtyAmount,
      this.taxableAmount,
      this.gstAmount,
      this.discountAmount,
      this.productQtyTotal,
      this.vendorId,
      this.cartProducts,});

  VendorProductModel.fromJson(dynamic json) {
    print("cart_json $json");
    ownerName = json['owner_name'];
    deliveryCharges = double.tryParse(json['delivery_charges'].toString());

    priceXCartQtyAmount = double.tryParse(json['${json['vendor_id']}_price_x_cart_qty_amount'].toString());
    mrpXCartQtyAmount = double.tryParse(json['${json['vendor_id']}_mrp_x_cart_qty_amount'].toString());
    taxableAmount = double.tryParse(json['${json['vendor_id']}_taxable_amount'].toString());
    gstAmount = double.tryParse(json['${json['vendor_id']}_gst_amount'].toString());
    discountAmount = double.tryParse(json['${json['vendor_id']}_discount_amount'].toString());
    productQtyTotal = double.tryParse(json['${json['vendor_id']}_product_qty_total'].toString());

    vendorId = json['vendor_id'];

    if (json['cart_products'] != null) {
      cartProducts = [];
      json['cart_products'].forEach((v) {
        cartProducts!.add(CartModel.fromJson(v));
      });
    }
  }
  String? ownerName;
  double? deliveryCharges;
  double? priceXCartQtyAmount;
  double? mrpXCartQtyAmount;
  double? taxableAmount;
  double? gstAmount;
  double? discountAmount;
  double? productQtyTotal;

  int? vendorId;
  List<CartModel>? cartProducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['owner_name'] = ownerName;
    map['delivery_charges'] = deliveryCharges;
    map['$vendorId}_price_x_cart_qty_amount'] = priceXCartQtyAmount;
    map['$vendorId}_mrp_x_cart_qty_amount'] = mrpXCartQtyAmount;
    map['$vendorId}_taxable_amount'] = taxableAmount;
    map['$vendorId}_gst_amount'] = gstAmount;
    map['$vendorId}_discount_amount'] = discountAmount;
    map['$vendorId}_product_qty_total'] = productQtyTotal;

    map['vendor_id'] = vendorId;
    if (cartProducts != null) {
      map['cart_products'] = cartProducts!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}