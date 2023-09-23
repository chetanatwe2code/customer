/// id : 1
/// order_id : "977956"
/// user_id : 20
/// product_id : 53
/// total_order_product_quantity : "1"
/// total_amount : "97"
/// total_gst : "5"
/// total_cgst : "2"
/// total_sgst : "2"
/// shipping_charges : "0"
/// invoice_id : 977956
/// payment_mode : "cod"
/// payment_ref_id : ""
/// order_date : "2023-04-25T06:41:26.000Z"
/// delivery_date : "2023-04-25T06:41:26.000Z"
/// invoice_date : "2023-04-25T06:41:26.000Z"
/// discount_coupon : ""
/// discount_coupon_value : ""
/// created_on : "2023-04-25T06:41:26.000Z"
/// status_order : "pending"
/// vendor_id : 2
/// name : "newProduct"
/// seo_tag : "rose seo"
/// brand : "Cactus Collective"
/// quantity : 5
/// unit : "gram"
/// product_stock_quantity : 9
/// price : 97
/// mrp : "100"
/// sgst : 2.5
/// cgst : 2.5
/// gst : "5"
/// category : "Shrubs"
/// is_deleted : "0"
/// status : "active"
/// review : "nice one"
/// discount : "03"
/// rating : "3"
/// description : "A product description is the marketing copy that explains what a product is and why it's worth purchasing. "
/// is_active : 0
/// product_created_on_product : "2023-04-25T06:15:13.000Z"
/// product_updated_on : "2023-04-25T06:15:13.000Z"
/// all_images_url : "http://192.168.29.109:8888/product_images/download(3).jpeg053_560504.png"
/// cover_image : "http://192.168.29.109:8888/product_images/download(3).jpeg053_560504.png"

class OrderModel {
  OrderModel({
      this.id, 
      this.orderId, 
      this.userId, 
      this.productId, 
      this.totalOrderProductQuantity, 
      this.totalAmount, 
      this.totalGst, 
      this.totalCgst, 
      this.totalSgst, 
      this.shippingCharges, 
      this.invoiceId, 
      this.paymentMode, 
      this.paymentRefId, 
      this.orderDate, 
      this.deliveryDate, 
      this.invoiceDate, 
      this.discountCoupon, 
      this.discountCouponValue, 
      this.createdOn, 
      this.statusOrder, 
      this.vendorId, 
      this.name, 
      this.verientName,
      this.seoTag,
      this.quantity,
      this.unit, 
      this.productStockQuantity, 
      this.price, 
      this.mrp, 
      this.sgst, 
      this.cgst, 
      this.gst, 
      this.category, 
      this.isDeleted, 
      this.status, 
      this.review, 
      this.discount, 
      this.rating, 
      this.description, 
      this.isActive, 
      this.productCreatedOnProduct, 
      this.productUpdatedOn, 
      this.allImagesUrl, 
      this.coverImage,});

  OrderModel.fromJson(dynamic json) {
    try{
      print("fromJson__ ${json['order_id']}");
      id = json['id'];
      orderId = json['order_id'];
      userId = json['user_id'];
      productId = json['product_id'];
      totalOrderProductQuantity = int.tryParse(json['total_order_product_quantity'].toString());
      totalAmount = double.tryParse(json['total_amount'].toString());
      totalGst = double.tryParse(json['total_gst'].toString());
      totalCgst = json['total_cgst'];
      totalSgst = json['total_sgst'];
      shippingCharges = double.tryParse(json['shipping_charges'].toString());
      invoiceId = json['invoice_id'];
      paymentMode = json['payment_mode'];
      paymentRefId = json['payment_ref_id'];
      orderDate = json['order_date'];
      deliveryDate = json['delivery_date'];
       invoiceDate = json['invoice_date'];
       discountCoupon = json['discount_coupon'];
       discountCouponValue = json['discount_coupon_value'];
       createdOn = json['created_on'];
       statusOrder = json['status_order'];
       vendorId = int.tryParse(json['vendor_id'].toString());
       name = json['name'];
       verientName = json['verient_name'];
       seoTag = json['seo_tag'];
       quantity = int.tryParse(json['quantity'].toString());
       unit = json['unit'];
       productStockQuantity = int.tryParse(json['product_stock_quantity'].toString());

       price = double.tryParse(json['price'].toString());
       mrp = double.tryParse(json['mrp'].toString());
       sgst = double.tryParse(json['sgst'].toString());
       cgst = double.tryParse(json['cgst'].toString());
       gst = double.tryParse(json['gst'].toString());
      category = json['category'];
      isDeleted = json['is_deleted'];
      status = json['status'];
      review = json['review'];
      rating = double.tryParse(json['rating'].toString());
      discount = double.tryParse(json['discount'].toString());
      description = json['description'];
      deliveryVerifyCode = int.tryParse(json['delivery_verify_code'].toString());
      isActive = json['is_active'];
      productCreatedOnProduct = json['product_created_on_product'];
      productUpdatedOn = json['product_updated_on'];
      allImagesUrl = json['all_images_url'];
      coverImage = json['cover_image'];

      onlyThisOrderProductTotal = double.tryParse(json['only_this_order_product_total'].toString());
      onlyThisOrderProductQuantity = int.tryParse(json['only_this_order_product_quantity'].toString());

    }catch(e){
      print("all_images_url $e");
    }
  }
  int? id;
  String? orderId;
  int? userId;
  int? productId;
  int? totalOrderProductQuantity;
  double? totalAmount;
  double? totalGst;
  String? totalCgst;
  String? totalSgst;
  double? shippingCharges;
  int? invoiceId;
  String? paymentMode;
  String? paymentRefId;
  String? orderDate;
  String? deliveryDate;
  String? invoiceDate;
  String? discountCoupon;
  String? discountCouponValue;
  String? createdOn;
  String? statusOrder;
  int? vendorId;
  String? name;
  String? verientName;
  String? seoTag;
  int? quantity;
  String? unit;
  int? productStockQuantity;
  double? price;
  double? mrp;
  double? sgst;
  double? cgst;
  double? gst;
  String? category;
  int? isDeleted;
  String? status;
  String? review;
  double? discount;
  double? rating;
  String? description;
  int? isActive;
  int? deliveryVerifyCode;
  String? productCreatedOnProduct;
  String? productUpdatedOn;
  String? allImagesUrl;
  String? coverImage;
  double?  onlyThisOrderProductTotal;
  int? onlyThisOrderProductQuantity;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['user_id'] = userId;
    map['product_id'] = productId;
    map['total_order_product_quantity'] = totalOrderProductQuantity;
    map['total_amount'] = totalAmount;
    map['total_gst'] = totalGst;
    map['total_cgst'] = totalCgst;
    map['total_sgst'] = totalSgst;
    map['shipping_charges'] = shippingCharges;
    map['invoice_id'] = invoiceId;
    map['payment_mode'] = paymentMode;
    map['payment_ref_id'] = paymentRefId;
    map['order_date'] = orderDate;
    map['delivery_date'] = deliveryDate;
    map['invoice_date'] = invoiceDate;
    map['discount_coupon'] = discountCoupon;
    map['discount_coupon_value'] = discountCouponValue;
    map['created_on'] = createdOn;
    map['status_order'] = statusOrder;
    map['vendor_id'] = vendorId;
    map['name'] = name;
    map['verient_name'] = verientName;
    map['seo_tag'] = seoTag;
    map['quantity'] = quantity;
    map['unit'] = unit;
    map['product_stock_quantity'] = productStockQuantity;
    map['price'] = price;
    map['mrp'] = mrp;
    map['sgst'] = sgst;
    map['cgst'] = cgst;
    map['gst'] = gst;
    map['category'] = category;
    map['is_deleted'] = isDeleted;
    map['status'] = status;
    map['review'] = review;
    map['discount'] = discount;
    map['rating'] = rating;
    map['description'] = description;
    map['is_active'] = isActive;
    map['delivery_verify_code'] = deliveryVerifyCode;
    map['product_created_on_product'] = productCreatedOnProduct;
    map['product_updated_on'] = productUpdatedOn;
    map['all_images_url'] = allImagesUrl;
    map['cover_image'] = coverImage;

    map['only_this_order_product_total'] = onlyThisOrderProductTotal;
    map['only_this_order_product_quantity'] = onlyThisOrderProductQuantity;
    return map;
  }

}