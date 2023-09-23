/// id : 4
/// user_id : 37
/// user_name : "mayur"
/// product_id : 3
/// product_name : "abcdef"
/// review_date : "2022-12-01T12:00:00.000Z"
/// review_rating : 1
/// comment : "wrost product"
/// status : "pending"
/// note : ""
/// is_active : 1
/// created_on : "2023-06-19T13:01:14.000Z"
/// updated_on : "2023-06-19T13:01:14.000Z"

class ProductReview {
  ProductReview({
      this.id, 
      this.userId, 
      this.userName, 
      this.productId, 
      this.productName, 
      this.reviewDate, 
      this.reviewRating, 
      this.comment, 
      this.status, 
      this.note, 
      this.isActive, 
      this.createdOn, 
      this.updatedOn,});

  ProductReview.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    productId = json['product_id'];
    productName = json['product_name'];
    reviewDate = json['review_date'];
    reviewRating = double.tryParse(json['review_rating'].toString());
    comment = json['comment'];
    status = json['status'];
    note = json['note'];
    isActive = json['is_active'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
  }
  num? id;
  num? userId;
  String? userName;
  num? productId;
  String? productName;
  String? reviewDate;
  double? reviewRating;
  String? comment;
  String? status;
  String? note;
  num? isActive;
  String? createdOn;
  String? updatedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['user_name'] = userName;
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['review_date'] = reviewDate;
    map['review_rating'] = reviewRating;
    map['comment'] = comment;
    map['status'] = status;
    map['note'] = note;
    map['is_active'] = isActive;
    map['created_on'] = createdOn;
    map['updated_on'] = updatedOn;
    return map;
  }

}