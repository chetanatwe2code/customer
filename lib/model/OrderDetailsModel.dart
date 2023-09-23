/// success : true
/// order_detaile : [{"id":30,"order_id":"460716","product_id":111,"user_id":20,"vendor_id":"17","total_order_product_quantity":"1","total_amount":"100","total_gst":"11","total_cgst":"5.5","total_sgst":"5.5","total_discount":"11","shipping_charges":"0","invoice_id":460716,"payment_mode":"cod","payment_ref_id":"0","order_date":"2023-06-22T11:08:55.000Z","delivery_date":"2023-06-22T11:08:55.000Z","invoice_date":"2023-06-22T11:08:55.000Z","discount_coupon":"0","discount_coupon_value":"0","created_on":"2023-06-22T11:08:55.000Z","updated_on":"2023-06-22T11:08:55.000Z","status_order":"pending","delivery_lat":12.15,"delivery_log":12.15,"user_name":"t t","address":"jfjr","email":"chetan.barod.we2code@gmail.com","pin_code":"452020","city":"jyj5","user_image":"http://192.168.29.109:8888/user_profile/image1682489239867.octet-stream","phone_no":"8686864333","delivery_verify_code":"5989308","verify_by_vendor":"pending","only_this_order_product_total":500,"only_this_order_product_quantity":522}]
/// order_product_detaile : [{"id":111,"order_id":460716,"order_cart_count":12,"vendor_id":17,"name":"mango plant","seo_tag":"plant mango ","brand":"greenEarth","category":"bonsai","is_deleted":1,"status":"active","review":"very good plant","rating":4.5,"description":"awesome and healthy plant","is_active":1,"created_by":"vendor","created_by_id":"22","created_on":"2023-06-03T10:41:11.000Z","updated_on":"2023-06-03T10:41:11.000Z","product_verient_id":2,"product_id":111,"verient_name":"small tree","quantity":1,"unit":"pcs","product_stock_quantity":1779,"price":100.5,"mrp":110.5,"gst":10,"sgst":5,"cgst":5,"verient_is_deleted":1,"verient_status":"active","discount":10,"verient_description":"very good product","verient_is_active":1,"verient_created_on":"2023-05-19T14:28:03.000Z","verient_updated_on":"2023-05-19T14:28:03.000Z","product_height":"10 mm","product_width":"3 mm","product_Weight":"3 kg","all_images_url":"https://assets.winni.in/product/primary/2014/10/50414.jpeg?dpr=1&w=400,https://assets.winni.in/product/primary/2014/6/33398.jpeg?dpr=1&w=400,https://assets.winni.in/product/primary/2022/9/74185.jpeg?dpr=1&w=400,https://assets.winni.in/product/primary/2014/6/34789.jpeg?dpr=1&w=400","cover_image":"https://assets.winni.in/product/primary/2014/10/50414.jpeg?dpr=1&w=400,https://assets.winni.in/product/primary/2014/6/33398.jpeg?dpr=1&w=400,https://assets.winni.in/product/primary/2022/9/74185.jpeg?dpr=1&w=400"}]
/// user_detaile : [{"id":20,"first_name":"Chetan","last_name":"Barod","email":"chetan.barod.we2code@gmail.com","password":"12345@abcd","phone_no":"8686864333","pincode":"452020","city":"jyj5","address":"jfjr","alternate_address":"undefined","created_on":"2023-04-20T14:00:11.000Z","updated_on":"2023-04-20T14:00:11.000Z","is_deleted":"0","image":"http://192.168.29.109:8888/user_profile/image1682489239867.octet-stream","token_for_notification":"dPopDOxIT-GhQEk9_Eq8TE:APA91bEPqXpsk0Z6F2w7PlmZWOmbAq6Xi40-A9JU25NU-DjsCY7QMuva4ZbQKoa9FwgN-7QzSMVVbazj99PBqEW8XBis7gJm-pnKhDOiIsC302QCxo-fC3zuq3s329S6XlBPv7loTDQ8","user_type":12.15,"user_log":12.15,"user_lat":12.15,"alternetive_user_lat":12.15,"alternetive_user_log":15.25,"active_address":"main_address"}]

class OrderDetailsModel {
  OrderDetailsModel({
      this.success, 
      this.orderDetaile, 
      this.orderProductDetaile, 
      this.userDetaile,});

  OrderDetailsModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['order_detaile'] != null) {
      orderDetaile = [];
      json['order_detaile'].forEach((v) {
        orderDetaile?.add(OrderDetaile.fromJson(v));
      });
    }
    if (json['order_product_detaile'] != null) {
      orderProductDetaile = [];
      json['order_product_detaile'].forEach((v) {
        orderProductDetaile?.add(OrderProductDetaile.fromJson(v));
      });
    }
    if (json['user_detaile'] != null) {
      userDetaile = [];
      json['user_detaile'].forEach((v) {
        userDetaile?.add(UserDetaile.fromJson(v));
      });
    }
  }
  bool? success;
  List<OrderDetaile>? orderDetaile;
  List<OrderProductDetaile>? orderProductDetaile;
  List<UserDetaile>? userDetaile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (orderDetaile != null) {
      map['order_detaile'] = orderDetaile?.map((v) => v.toJson()).toList();
    }
    if (orderProductDetaile != null) {
      map['order_product_detaile'] = orderProductDetaile?.map((v) => v.toJson()).toList();
    }
    if (userDetaile != null) {
      map['user_detaile'] = userDetaile?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 20
/// first_name : "Chetan"
/// last_name : "Barod"
/// email : "chetan.barod.we2code@gmail.com"
/// password : "12345@abcd"
/// phone_no : "8686864333"
/// pincode : "452020"
/// city : "jyj5"
/// address : "jfjr"
/// alternate_address : "undefined"
/// created_on : "2023-04-20T14:00:11.000Z"
/// updated_on : "2023-04-20T14:00:11.000Z"
/// is_deleted : "0"
/// image : "http://192.168.29.109:8888/user_profile/image1682489239867.octet-stream"
/// token_for_notification : "dPopDOxIT-GhQEk9_Eq8TE:APA91bEPqXpsk0Z6F2w7PlmZWOmbAq6Xi40-A9JU25NU-DjsCY7QMuva4ZbQKoa9FwgN-7QzSMVVbazj99PBqEW8XBis7gJm-pnKhDOiIsC302QCxo-fC3zuq3s329S6XlBPv7loTDQ8"
/// user_type : 12.15
/// user_log : 12.15
/// user_lat : 12.15
/// alternetive_user_lat : 12.15
/// alternetive_user_log : 15.25
/// active_address : "main_address"

class UserDetaile {
  UserDetaile({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.password, 
      this.phoneNo, 
      this.pincode, 
      this.city, 
      this.address, 
      this.alternateAddress, 
      this.createdOn, 
      this.updatedOn, 
      this.isDeleted, 
      this.image, 
      this.tokenForNotification, 
      this.userType, 
      this.userLog, 
      this.userLat, 
      this.alternetiveUserLat, 
      this.alternetiveUserLog, 
      this.activeAddress,});

  UserDetaile.fromJson(dynamic json) {
    try{
      id = json['id'];
      firstName = json['first_name'];
      lastName = json['last_name'];
      email = json['email'];
      password = json['password'];
      phoneNo = json['phone_no'];
      pincode = json['pincode'];
      city = json['city'];
      address = json['address'];
      alternateAddress = json['alternate_address'];
      createdOn = json['created_on'];
      updatedOn = json['updated_on'];
      isDeleted = json['is_deleted'];
      image = json['image'];
      tokenForNotification = json['token_for_notification'];
      userType = json['user_type'];
      userLog = json['user_log'];
      userLat = json['user_lat'];
      alternetiveUserLat = json['alternetive_user_lat'];
      alternetiveUserLog = json['alternetive_user_log'];
      activeAddress = json['active_address'];
    }catch(e){
      print("ERROR_BOX_ C $e");
    }
  }
  num? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNo;
  String? pincode;
  String? city;
  String? address;
  String? alternateAddress;
  String? createdOn;
  String? updatedOn;
  String? isDeleted;
  String? image;
  String? tokenForNotification;
  num? userType;
  num? userLog;
  num? userLat;
  num? alternetiveUserLat;
  num? alternetiveUserLog;
  String? activeAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['password'] = password;
    map['phone_no'] = phoneNo;
    map['pincode'] = pincode;
    map['city'] = city;
    map['address'] = address;
    map['alternate_address'] = alternateAddress;
    map['created_on'] = createdOn;
    map['updated_on'] = updatedOn;
    map['is_deleted'] = isDeleted;
    map['image'] = image;
    map['token_for_notification'] = tokenForNotification;
    map['user_type'] = userType;
    map['user_log'] = userLog;
    map['user_lat'] = userLat;
    map['alternetive_user_lat'] = alternetiveUserLat;
    map['alternetive_user_log'] = alternetiveUserLog;
    map['active_address'] = activeAddress;
    return map;
  }

}

/// id : 111
/// order_id : 460716
/// order_cart_count : 12
/// vendor_id : 17
/// name : "mango plant"
/// seo_tag : "plant mango "
/// brand : "greenEarth"
/// category : "bonsai"
/// is_deleted : 1
/// status : "active"
/// review : "very good plant"
/// rating : 4.5
/// description : "awesome and healthy plant"
/// is_active : 1
/// created_by : "vendor"
/// created_by_id : "22"
/// created_on : "2023-06-03T10:41:11.000Z"
/// updated_on : "2023-06-03T10:41:11.000Z"
/// product_verient_id : 2
/// product_id : 111
/// verient_name : "small tree"
/// quantity : 1
/// unit : "pcs"
/// product_stock_quantity : 1779
/// price : 100.5
/// mrp : 110.5
/// gst : 10
/// sgst : 5
/// cgst : 5
/// verient_is_deleted : 1
/// verient_status : "active"
/// discount : 10
/// verient_description : "very good product"
/// verient_is_active : 1
/// verient_created_on : "2023-05-19T14:28:03.000Z"
/// verient_updated_on : "2023-05-19T14:28:03.000Z"
/// product_height : "10 mm"
/// product_width : "3 mm"
/// product_Weight : "3 kg"
/// all_images_url : "https://assets.winni.in/product/primary/2014/10/50414.jpeg?dpr=1&w=400,https://assets.winni.in/product/primary/2014/6/33398.jpeg?dpr=1&w=400,https://assets.winni.in/product/primary/2022/9/74185.jpeg?dpr=1&w=400,https://assets.winni.in/product/primary/2014/6/34789.jpeg?dpr=1&w=400"
/// cover_image : "https://assets.winni.in/product/primary/2014/10/50414.jpeg?dpr=1&w=400,https://assets.winni.in/product/primary/2014/6/33398.jpeg?dpr=1&w=400,https://assets.winni.in/product/primary/2022/9/74185.jpeg?dpr=1&w=400"

class OrderProductDetaile {
  OrderProductDetaile({
      this.id, 
      this.orderId, 
      this.orderCartCount, 
      this.vendorId, 
      this.name, 
      this.seoTag, 
      this.brand, 
      this.category, 
      this.isDeleted, 
      this.status, 
      this.review, 
      this.rating, 
      this.description, 
      this.isActive, 
      this.createdBy, 
      this.createdById, 
      this.createdOn, 
      this.updatedOn, 
      this.productVerientId, 
      this.productId, 
      this.verientName, 
      this.quantity, 
      this.unit, 
      this.productStockQuantity, 
      this.price, 
      this.mrp, 
      this.gst, 
      this.sgst, 
      this.cgst, 
      this.verientIsDeleted, 
      this.verientStatus, 
      this.discount, 
      this.verientDescription, 
      this.verientIsActive, 
      this.verientCreatedOn, 
      this.verientUpdatedOn, 
      this.productHeight, 
      this.productWidth, 
      this.productWeight, 
      this.allImagesUrl, 
      this.coverImage,});

  OrderProductDetaile.fromJson(dynamic json) {
   try{
      id = int.tryParse(json['id'].toString());
      orderId = int.tryParse(json['order_id'].toString());
      orderCartCount = int.tryParse(json['order_cart_count'].toString());
     vendorId = int.tryParse(json['vendor_id'].toString());
     name = json['name'];
     seoTag = json['seo_tag'];
     brand = json['brand'];
     category = json['category'];
     isDeleted = int.tryParse(json['is_deleted'].toString());
     status = json['status'];
     review = json['review'];
     rating = double.tryParse(json['rating'].toString());
     description = json['description'];
     isActive = int.tryParse(json['is_active'].toString());
     createdBy = json['created_by'];
     createdById = json['created_by_id'];
     createdOn = json['created_on'];
     updatedOn = json['updated_on'];
     productVerientId = int.tryParse(json['product_verient_id'].toString());
     productId = int.tryParse(json['product_id'].toString());
     verientName = json['verient_name'];
     quantity = int.tryParse(json['quantity'].toString());
     unit = json['unit'];
     productStockQuantity = int.tryParse(json['product_stock_quantity'].toString());
     price = double.tryParse(json['price'].toString());
     mrp = double.tryParse(json['mrp'].toString());
     gst = double.tryParse(json['gst'].toString());
     sgst = double.tryParse( json['sgst'].toString());
     cgst = double.tryParse(json['cgst'].toString());
     verientIsDeleted = int.tryParse(json['verient_is_deleted'].toString());
     verientStatus = json['verient_status'];
     discount = double.tryParse(json['discount'].toString());
     allImagesUrl = json['all_images_url'];
     coverImage = json['cover_image'];
     verientCreatedOn = json['verient_created_on'];
     verientUpdatedOn = json['verient_updated_on'];
     verientDescription = json['verient_description'];
     verientIsActive = int.tryParse(json['verient_is_active'].toString());
     productHeight = json['product_height'];
     productWidth = json['product_width'];
     productWeight = json['product_Weight'];

   }catch(e){
     print("ERROR_BOX_ B $e");
   }


    //
  }
  int? id;
  int? orderId;
  int? orderCartCount;
  int? vendorId;
  String? name;
  String? seoTag;
  String? brand;
  String? category;
  int? isDeleted;
  String? status;
  String? review;
  double? rating;
  String? description;
  int? isActive;
  String? createdBy;
  String? createdById;
  String? createdOn;
  String? updatedOn;
  int? productVerientId;
  int? productId;
  String? verientName;
  int? quantity;
  String? unit;
  int? productStockQuantity;
  double? price;
  double? mrp;
  double? gst;
  double? sgst;
  double? cgst;
  int? verientIsDeleted;
  String? verientStatus;
  double? discount;
  String? verientDescription;
  int? verientIsActive;
  String? verientCreatedOn;
  String? verientUpdatedOn;
  String? productHeight;
  String? productWidth;
  String? productWeight;
  String? allImagesUrl;
  String? coverImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['order_cart_count'] = orderCartCount;
    map['vendor_id'] = vendorId;
    map['name'] = name;
    map['seo_tag'] = seoTag;
    map['brand'] = brand;
    map['category'] = category;
    map['is_deleted'] = isDeleted;
    map['status'] = status;
    map['review'] = review;
    map['rating'] = rating;
    map['description'] = description;
    map['is_active'] = isActive;
    map['created_by'] = createdBy;
    map['created_by_id'] = createdById;
    map['created_on'] = createdOn;
    map['updated_on'] = updatedOn;
    map['product_verient_id'] = productVerientId;
    map['product_id'] = productId;
    map['verient_name'] = verientName;
    map['quantity'] = quantity;
    map['unit'] = unit;
    map['product_stock_quantity'] = productStockQuantity;
    map['price'] = price;
    map['mrp'] = mrp;
    map['gst'] = gst;
    map['sgst'] = sgst;
    map['cgst'] = cgst;
    map['verient_is_deleted'] = verientIsDeleted;
    map['verient_status'] = verientStatus;
    map['discount'] = discount;
    map['verient_description'] = verientDescription;
    map['verient_is_active'] = verientIsActive;
    map['verient_created_on'] = verientCreatedOn;
    map['verient_updated_on'] = verientUpdatedOn;
    map['product_height'] = productHeight;
    map['product_width'] = productWidth;
    map['product_Weight'] = productWeight;
    map['all_images_url'] = allImagesUrl;
    map['cover_image'] = coverImage;
    return map;
  }

}

/// id : 30
/// order_id : "460716"
/// product_id : 111
/// user_id : 20
/// vendor_id : "17"
/// total_order_product_quantity : "1"
/// total_amount : "100"
/// total_gst : "11"
/// total_cgst : "5.5"
/// total_sgst : "5.5"
/// total_discount : "11"
/// shipping_charges : "0"
/// invoice_id : 460716
/// payment_mode : "cod"
/// payment_ref_id : "0"
/// order_date : "2023-06-22T11:08:55.000Z"
/// delivery_date : "2023-06-22T11:08:55.000Z"
/// invoice_date : "2023-06-22T11:08:55.000Z"
/// discount_coupon : "0"
/// discount_coupon_value : "0"
/// created_on : "2023-06-22T11:08:55.000Z"
/// updated_on : "2023-06-22T11:08:55.000Z"
/// status_order : "pending"
/// delivery_lat : 12.15
/// delivery_log : 12.15
/// user_name : "t t"
/// address : "jfjr"
/// email : "chetan.barod.we2code@gmail.com"
/// pin_code : "452020"
/// city : "jyj5"
/// user_image : "http://192.168.29.109:8888/user_profile/image1682489239867.octet-stream"
/// phone_no : "8686864333"
/// delivery_verify_code : "5989308"
/// verify_by_vendor : "pending"
/// only_this_order_product_total : 500
/// only_this_order_product_quantity : 522

class OrderDetaile {
  OrderDetaile({
      this.id, 
      this.orderId, 
      this.productId, 
      this.userId, 
      this.vendorId, 
      this.totalOrderProductQuantity, 
      this.totalAmount, 
      this.totalGst, 
      this.totalCgst, 
      this.totalSgst, 
      this.totalDiscount, 
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
      this.updatedOn, 
      this.statusOrder, 
      this.deliveryLat, 
      this.deliveryLog, 
      this.userName, 
      this.address, 
      this.email, 
      this.pinCode, 
      this.city, 
      this.userImage, 
      this.phoneNo, 
      this.deliveryVerifyCode, 
      this.verifyByVendor, 
      this.onlyThisOrderProductTotal, 
      this.onlyThisOrderProductQuantity,
      this.onlyThisProductSGst,
      this.onlyThisProductCGst,
      this.onlyThisProductGst
  });

  OrderDetaile.fromJson(dynamic json) {
    try{
      id = json['id'];
      orderId = json['order_id'];
      productId = json['product_id'];
      userId = json['user_id'];
      vendorId = json['vendor_id'];
      totalOrderProductQuantity = json['total_order_product_quantity'];
      totalAmount = json['total_amount'];
      totalGst = json['total_gst'];
      totalCgst = json['total_cgst'];
      totalSgst = json['total_sgst'];
      totalDiscount = json['total_discount'];
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
      updatedOn = json['updated_on'];
      statusOrder = json['status_order'];
      deliveryLat = json['delivery_lat'];
      deliveryLog = json['delivery_log'];
      userName = json['user_name'];
      address = json['address'];
      email = json['email'];
      pinCode = json['pin_code'];
      city = json['city'];
      userImage = json['user_image'];
      phoneNo = json['phone_no'];
      deliveryVerifyCode = json['delivery_verify_code'];
      verifyByVendor = json['verify_by_vendor'];
      onlyThisOrderProductTotal = double.tryParse(json['only_this_order_product_total'].toString());
      onlyThisOrderProductQuantity = int.tryParse(json['only_this_order_product_quantity'].toString());

      onlyThisProductGst = double.tryParse(json['only_this_product_gst'].toString());
      onlyThisProductCGst = double.tryParse(json['only_this_product_cgst'].toString());
      onlyThisProductSGst = double.tryParse(json['only_this_product_sgst'].toString());
    }catch(e){
      print("ERROR_BOX_ A $e");
    }
  }

  num? id;
  String? orderId;
  num? productId;
  num? userId;
  String? vendorId;
  String? totalOrderProductQuantity;
  String? totalAmount;
  String? totalGst;
  String? totalCgst;
  String? totalSgst;
  String? totalDiscount;
  double? shippingCharges;
  num? invoiceId;
  String? paymentMode;
  String? paymentRefId;
  String? orderDate;
  String? deliveryDate;
  String? invoiceDate;
  String? discountCoupon;
  String? discountCouponValue;
  String? createdOn;
  String? updatedOn;
  String? statusOrder;
  num? deliveryLat;
  num? deliveryLog;
  String? userName;
  String? address;
  String? email;
  String? pinCode;
  String? city;
  String? userImage;
  String? phoneNo;
  String? deliveryVerifyCode;
  String? verifyByVendor;

  /// total of vendor products
  double? onlyThisOrderProductTotal;
  int? onlyThisOrderProductQuantity;
  double? onlyThisProductGst;
  double? onlyThisProductCGst;
  double? onlyThisProductSGst;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['product_id'] = productId;
    map['user_id'] = userId;
    map['vendor_id'] = vendorId;
    map['total_order_product_quantity'] = totalOrderProductQuantity;
    map['total_amount'] = totalAmount;
    map['total_gst'] = totalGst;
    map['total_cgst'] = totalCgst;
    map['total_sgst'] = totalSgst;
    map['total_discount'] = totalDiscount;
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
    map['updated_on'] = updatedOn;
    map['status_order'] = statusOrder;
    map['delivery_lat'] = deliveryLat;
    map['delivery_log'] = deliveryLog;
    map['user_name'] = userName;
    map['address'] = address;
    map['email'] = email;
    map['pin_code'] = pinCode;
    map['city'] = city;
    map['user_image'] = userImage;
    map['phone_no'] = phoneNo;
    map['delivery_verify_code'] = deliveryVerifyCode;
    map['verify_by_vendor'] = verifyByVendor;
    map['only_this_order_product_total'] = onlyThisOrderProductTotal;
    map['only_this_order_product_quantity'] = onlyThisOrderProductQuantity;
    map['only_this_product_gst'] = onlyThisProductGst;
    map['only_this_product_cgst'] = onlyThisProductCGst;
    map['only_this_product_sgst'] = onlyThisProductSGst;
    return map;
  }

}