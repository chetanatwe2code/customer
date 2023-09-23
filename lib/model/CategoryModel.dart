/// category : "Herbs"

class CategoryModel {
  CategoryModel({
    this.category,
    this.id,this.image,this.parentId,this.categoryType});

  CategoryModel.fromJson(dynamic json) {
    try{
      id = json['id'];
      parentId = json['parent_id'];
      image = json['image'];
      category = json['category_name'];
      categoryType = json['category_type'];
    }catch (e){
      //
    }
  }

  int? id;
  int? parentId;
  String? image;
  String? category;
  String? categoryType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['parent_id'] = parentId;
    map['image'] = image;
    map['category_name'] = category;
    map['category_type'] = categoryType;
    return map;
  }

}