/// id : 113
/// vendor_id : 17
/// name : "As"
/// seo_tag : "My_SEO"
/// brand : "Tree"
/// category : "Plant"
/// is_deleted : 1
/// status : "active"
/// review : "it is good Product"
/// rating : 5
/// description : "My Plant Is Good always in wintet"
/// is_active : 1
/// created_by : "undefined"
/// created_by_id : "17"
/// created_on : "2023-06-05T06:53:34.000Z"
/// updated_on : "2023-06-05T06:53:34.000Z"
/// product_verient_id : 1
/// product_id : 113
/// verient_name : "T2 plant  d"
/// quantity : 1
/// unit : "PCS"
/// product_stock_quantity : 10
/// price : 617.67
/// mrp : 650.18
/// gst : 18
/// sgst : 9
/// cgst : 9
/// verient_is_deleted : 1
/// verient_status : "active"
/// discount : 5
/// verient_description : "no"
/// verient_is_active : 1
/// verient_created_on : "2023-06-05T06:54:43.000Z"
/// verient_updated_on : "2023-06-05T06:54:43.000Z"
/// product_height : "undefined"
/// product_width : "undefined"
/// product_Weight : "undefined"
/// cover_image : "https://assets.winni.in/product/primary/2014/10/50382.jpeg?dpr=1&w=400"
/// all_images_url : "https://assets.winni.in/product/primary/2014/10/50382.jpeg?dpr=1&w=400,http://192.168.29.109:8888/product_images/test_32_img_384498.png"
/// avgRatings : null

class Test {
  Test({
      this.id, 
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
      this.coverImage, 
      this.allImagesUrl, 
      this.avgRatings,});

  Test.fromJson(dynamic json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    name = json['name'];
    seoTag = json['seo_tag'];
    brand = json['brand'];
    category = json['category'];
    isDeleted = json['is_deleted'];
    status = json['status'];
    review = json['review'];
    rating = json['rating'];
    description = json['description'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    createdById = json['created_by_id'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    productVerientId = json['product_verient_id'];
    productId = json['product_id'];
    verientName = json['verient_name'];
    quantity = json['quantity'];
    unit = json['unit'];
    productStockQuantity = json['product_stock_quantity'];
    price = json['price'];
    mrp = json['mrp'];
    gst = json['gst'];
    sgst = json['sgst'];
    cgst = json['cgst'];
    verientIsDeleted = json['verient_is_deleted'];
    verientStatus = json['verient_status'];
    discount = json['discount'];
    verientDescription = json['verient_description'];
    verientIsActive = json['verient_is_active'];
    verientCreatedOn = json['verient_created_on'];
    verientUpdatedOn = json['verient_updated_on'];
    productHeight = json['product_height'];
    productWidth = json['product_width'];
    productWeight = json['product_Weight'];
    coverImage = json['cover_image'];
    allImagesUrl = json['all_images_url'];
    avgRatings = json['avgRatings'];
  }
  num? id;
  num? vendorId;
  String? name;
  String? seoTag;
  String? brand;
  String? category;
  num? isDeleted;
  String? status;
  String? review;
  num? rating;
  String? description;
  num? isActive;
  String? createdBy;
  String? createdById;
  String? createdOn;
  String? updatedOn;
  num? productVerientId;
  num? productId;
  String? verientName;
  num? quantity;
  String? unit;
  num? productStockQuantity;
  num? price;
  num? mrp;
  num? gst;
  num? sgst;
  num? cgst;
  num? verientIsDeleted;
  String? verientStatus;
  num? discount;
  String? verientDescription;
  num? verientIsActive;
  String? verientCreatedOn;
  String? verientUpdatedOn;
  String? productHeight;
  String? productWidth;
  String? productWeight;
  String? coverImage;
  String? allImagesUrl;
  dynamic avgRatings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
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
    map['cover_image'] = coverImage;
    map['all_images_url'] = allImagesUrl;
    map['avgRatings'] = avgRatings;
    return map;
  }

}