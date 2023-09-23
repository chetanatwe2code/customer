/// id : 1
/// banner_name : "fetured image 1"
/// banner_image_url : "http://192.168.29.109:8888/banner/J5Am108202.jpg"
/// type : "fetured_product"
/// position : "1"
/// description : "fetured product"
/// is_deleted : 0
/// created_on : "2023-05-20T07:13:06.000Z"
/// updated_on : "2023-05-20T07:13:06.000Z"

class BannerModel {
  BannerModel({
      this.id, 
      this.bannerName, 
      this.bannerImageUrl, 
      this.type, 
      this.position, 
      this.description, 
      this.isDeleted, 
      this.createdOn, 
      this.updatedOn,});

  BannerModel.fromJson(dynamic json) {
    try{
      id = json['id'];
      bannerName = json['banner_name'];
      bannerImageUrl = json['banner_image_url'];
      type = json['type'];
      position = json['position'];
      description = json['description'];
      isDeleted = json['is_deleted'];
      createdOn = json['created_on'];
      updatedOn = json['updated_on'];
    }catch(e){
      //
    }
  }
  int? id;
  String? bannerName;
  String? bannerImageUrl;
  String? type;
  String? position;
  String? description;
  int? isDeleted;
  String? createdOn;
  String? updatedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['banner_name'] = bannerName;
    map['banner_image_url'] = bannerImageUrl;
    map['type'] = type;
    map['position'] = position;
    map['description'] = description;
    map['is_deleted'] = isDeleted;
    map['created_on'] = createdOn;
    map['updated_on'] = updatedOn;
    return map;
  }

}