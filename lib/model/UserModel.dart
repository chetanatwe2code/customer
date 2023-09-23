/// id : 20
/// first_name : ""
/// last_name : ""
/// email : "chetan.barod.we2code@gmail.com"
/// password : "12345678"
/// phone_no : ""
/// pincode : ""
/// city : ""
/// address : ""
/// alternate_address : ""
/// created_on : "2023-04-20T08:30:11.000Z"
/// updated_on : "2023-04-20T08:30:11.000Z"
/// is_deleted : "0"

class UserModel {
  UserModel({
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
      this.image,
      this.createdOn,
      this.updatedOn, 
      this.isDeleted,});

  UserModel.fromJson(dynamic json) {
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
    image = json['image'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    isDeleted = json['is_deleted'];
  }
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNo;
  String? pincode;
  String? city;
  String? address;
  String? alternateAddress;
  String? image;
  String? createdOn;
  String? updatedOn;
  String? isDeleted;

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
    return map;
  }

}