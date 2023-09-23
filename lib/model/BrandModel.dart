class BrandModel {
  BrandModel({
      this.brand,
      this.isSelected});

  BrandModel.fromJson(dynamic json) {
    brand = json['brand'];
  }
  String? brand;
  bool? isSelected = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['brand'] = brand;
    return map;
  }

}