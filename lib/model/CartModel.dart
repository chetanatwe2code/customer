/// id : 8
/// user_id : 19
/// product_id : 16
/// cart_product_quantity : 2
/// created_on : "2023-04-08T11:51:29.000Z"
/// updated_on : "2023-04-08T11:51:29.000Z"
/// is_status : null
/// vendor_id : 4
/// name : "jesmine"
/// seo_tag : "jesmine seo"
/// brand : "Cactus Collective"
/// quantity : 8
/// unit : "piece"
/// product_stock_quantity : 11
/// price : 230
/// mrp : "250"
/// sgst : 4
/// cgst : 4
/// category : "Trees"
/// is_deleted : "0"
/// status : "draft"
/// review : "nice product"
/// discount : "5"
/// rating : "3"
/// description : "all good"
/// is_active : 1
/// product_created_on_product : "2023-04-04T12:27:37.000Z"
/// product_updated_on : "2023-04-04T12:27:37.000Z"
/// all_images_url : "http://192.168.29.108:8888/product_images/download.jpeg016_721292.png,http://192.168.29.108:8888/product_images/pexels-essow-1042143.jpg016_829797.png,http://192.168.29.108:8888/product_images/download(4).jpeg016_554940.png"
/// cover_image : "http://192.168.29.108:8888/product_images/download.jpeg016_721292.png"

class CartModel {
  CartModel({
      this.id, 
      this.userId, 
      this.productId, 
      this.cartProductQuantity, 
      this.createdOn, 
      this.updatedOn, 
      this.isStatus, 
      this.vendorId, 
      this.name, 
      this.seoTag, 
      this.brand, 
      this.quantity, 
      this.unit, 
      this.productStockQuantity, 
      this.price, 
      this.mrp, 
      this.gst,
      this.sgst,
      this.cgst,
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
      this.coverImage,
      this.verientName,
      this.productVerientId,
      this.verientDescription});

// price: 500, mrp: 550, gst: 18, sgst: 9, cgst: 9, discount: 5,   name: T2 plant d, price should be 522
// price: 500, mrp: 550, gst: 10, sgst: 5, cgst: 5, discount: 10,  name: small tree,  price should be 495
// price: 500, mrp: 550, gst: 10, sgst: 5, cgst: 5, discount: 10,  name: table decoration plant, price should be 495
  /// unitPrice = mrp / (1 + (gst / 100));
  ///  Test DATA
  ///
  ///  price 489
  ///  tax   28 / 136.92
  ///  mrp   625.92
  ///
  ///  price 989 /
  ///  tax   18 / 178.02
  ///  mrp   1167.02
  ///
  CartModel.fromJson(dynamic json) {
    try{
      print("cart_json $json");
      id = int.tryParse(json['id'].toString());
      userId = json['user_id'];
      productId = json['product_id'];
      cartProductQuantity = json['cart_product_quantity'];
      createdOn = json['created_on'];
      updatedOn = json['updated_on'];
      isStatus = json['is_status'];
      vendorId = int.tryParse(json['vendor_id'].toString());
      name = json['name'];
      seoTag = json['seo_tag'];
      brand = json['brand'];
      quantity = int.tryParse(json['quantity'].toString());
      unit = json['unit'];
      productStockQuantity = int.tryParse(json['product_stock_quantity'].toString());
      price = double.tryParse(json['price'].toString());
      mrp = double.tryParse(json['mrp'].toString());
      gst = double.tryParse(json['gst'].toString());
      sgst = double.tryParse(json['sgst'].toString());
      cgst = double.tryParse(json['cgst'].toString());
      category = json['category'];
      isDeleted = int.tryParse(json['is_deleted'].toString());
      status = json['status'];
      review = json['review'];
      discount = double.tryParse(json['discount'].toString());
      rating = double.tryParse(json['rating'].toString());
      description = json['description'];
      isActive = int.tryParse(json['is_active'].toString());
      productCreatedOnProduct = json['product_created_on_product'];
      productUpdatedOn = json['product_updated_on'];
      allImagesUrl = json['all_images_url'];
      coverImage = json['cover_image'];

      productVerientId = json['product_verient_id'];
      verientName = json['verient_name'];
      verientDescription = json['verient_description'];

    }catch(e){
      print("_cartList $e");
    }
  }

  int? id;
  int? userId;
  int? productId;
  int? cartProductQuantity;
  String? createdOn;
  String? updatedOn;
  dynamic isStatus;
  int? vendorId;
  String? name;
  String? seoTag;
  String? brand;
  int? quantity;
  String? unit;
  int? productStockQuantity;
  double? price;
  double? mrp;
  double? gst;
  double? sgst;
  double? cgst;
  String? category;
  int? isDeleted;
  String? status;
  String? review;
  double? discount;
  double? rating;
  String? description;
  int? isActive;
  String? productCreatedOnProduct;
  String? productUpdatedOn;
  String? allImagesUrl;
  String? coverImage;
  bool isIncrease = false;
  bool isDecrease = false;
  bool isDeleting = false;

  int? productVerientId;
  String? verientName;
  String? verientDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['product_id'] = productId;
    map['cart_product_quantity'] = cartProductQuantity;
    map['created_on'] = createdOn;
    map['updated_on'] = updatedOn;
    map['is_status'] = isStatus;
    map['vendor_id'] = vendorId;
    map['name'] = name;
    map['seo_tag'] = seoTag;
    map['brand'] = brand;
    map['quantity'] = quantity;
    map['unit'] = unit;
    map['product_stock_quantity'] = productStockQuantity;
    map['price'] = price;
    map['mrp'] = mrp;
    map['sgst'] = sgst;
    map['cgst'] = cgst;
    map['category'] = category;
    map['is_deleted'] = isDeleted;
    map['status'] = status;
    map['review'] = review;
    map['discount'] = discount;
    map['rating'] = rating;
    map['description'] = description;
    map['is_active'] = isActive;
    map['product_created_on_product'] = productCreatedOnProduct;
    map['product_updated_on'] = productUpdatedOn;
    map['all_images_url'] = allImagesUrl;
    map['cover_image'] = coverImage;

    map['product_verient_id'] = productVerientId;
    map['verient_name'] = verientName;
    map['verient_description'] = verientDescription;
    return map;
  }

}