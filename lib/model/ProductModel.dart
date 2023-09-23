/// id: 113,
/// vendor_id: 17,
/// name: As,
/// seo_tag: My_SEO,
/// brand: Tree,
/// category: Plant,
/// is_deleted: 1,
/// status: active,
/// review: it is good Product,
/// rating: 5,
/// description: My Plant Is Good always in wintet,
/// is_active: 1,
/// created_by: undefined,
/// created_by_id: 17,
/// created_on: 2023-06-05T06:53:34.000Z,
/// updated_on: 2023-06-05T06:53:34.000Z,
/// product_verient_id: 1,
/// product_id: 113,
/// verient_name: T2 plant  d,
/// quantity: 1,
/// unit: PCS,
/// product_stock_quantity: 10,
/// price: 617.67,
/// mrp: 650.18, gst: 18,
/// sgst: 9,
/// cgst: 9,
/// verient_is_deleted: 1,
/// verient_status: active,
/// discount: 5,
/// verient_description: no,
/// verient_is_active: 1,
/// verient_created_on: 2023-06-05T06:54:43.000Z,
/// verient_updated_on: 2023-06-05T06:54:43.000Z,
/// product_height: undefined,
/// product_width: undefined,
/// product_Weight: undefined,
/// cover_image: https://assets.winni.in/product/primary/2014/10/50382.jpeg?dpr=1&w=400,
/// all_images_url: https://assets.winni.in/product/primary/2014/10/50382.jpeg?dpr=1&w=400,http://192.168.29.109:8888/product_images/test_32_img_384498
class ProductModel {
  ProductModel({
      this.id, 
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
      this.categoryName,
      this.isDeleted,
      this.status, 
      this.review, 
      this.discount, 
      this.rating, 
      this.ratingsCount,
      this.description,
      this.isActive, 
      this.createdOn, 
      this.updatedOn, 
      this.cartCount,
      this.isFetured,
      this.allImagesUrl, 
      this.coverImage,
  this.verientName,this.productVerientId,this.verientDescription,this.benefits,this.careAndInstructions
  });

  ProductModel.fromJson(dynamic json) {
    try{
      id = int.tryParse(json['id'].toString());
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
      categoryName = json['category_name'];
      isDeleted = int.tryParse(json['is_deleted'].toString());
      status = json['status'];
      review = json['review'];
      discount = double.tryParse(json['discount'].toString());
      rating = double.tryParse(json['avgRatings'].toString());
      ratingsCount = double.tryParse(json['count_avgRatings'].toString());
      description = json['description'];
      isActive = int.tryParse(json['is_active'].toString());
      createdOn = json['created_on'];
      updatedOn = json['updated_on'];
      cartCount = int.tryParse(json['cart_count'].toString());
      allImagesUrl = json['all_images_url'];
      isFetured = json['is_fetured'];
      coverImage = json['cover_image'];
      productVerientId = json['product_verient_id'];
      verientName = json['verient_name'];
      verientDescription = json['verient_description'];
      careAndInstructions = json['care_and_Instructions'];
      benefits = json['benefits'];

    }catch(e){
      print("ON_ERROR $e");
    }
  }
  int? id;
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
  String? categoryName;
  int? isDeleted;
  String? status;
  String? review;
  double? discount;
  double? rating;
  double? ratingsCount;
  String? description;
  int? isActive;
  String? createdOn;
  String? updatedOn;
  int? cartCount;
  String? isFetured;
  String? allImagesUrl;
  String? coverImage;
  bool isIncrease = false;
  bool isDecrease = false;

  int? productVerientId;
  String? verientName;
  String? verientDescription;
  String? careAndInstructions;
  String? benefits;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['vendor_id'] = vendorId;
    map['name'] = name;
    map['seo_tag'] = seoTag;
    map['brand'] = brand;
    map['quantity'] = quantity;
    map['unit'] = unit;
    map['product_stock_quantity'] = productStockQuantity;
    map['price'] = price;
    map['mrp'] = mrp;
    map['gst'] = gst;
    map['sgst'] = sgst;
    map['cgst'] = cgst;
    map['category'] = category;
    map['category_name'] = categoryName;
    map['is_deleted'] = isDeleted;
    map['status'] = status;
    map['review'] = review;
    map['discount'] = discount;
    map['avgRatings'] = rating;
    map['count_avgRatings'] = ratingsCount;
    map['description'] = description;
    map['is_active'] = isActive;
    map['created_on'] = createdOn;
    map['updated_on'] = updatedOn;
    map['cart_count'] = cartCount;
    map['all_images_url'] = allImagesUrl;
    map['cover_image'] = coverImage;
    map['is_fetured'] = isFetured;
    map['product_verient_id'] = productVerientId;
    map['verient_name'] = verientName;
    map['verient_description'] = verientDescription;
    map['care_and_Instructions'] = careAndInstructions;
    map['benefits'] = benefits;
    return map;
  }

}