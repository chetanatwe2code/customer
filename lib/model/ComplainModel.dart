/// id : 4
/// order_id : 14
/// user_id : 20
/// first_name : "complain by mayur _2"
/// last_name : "yadu"
/// contect_no : "9827803082"
/// email : "mayur@gmail.com"
/// subject : "wrost product"
/// description : "csssfdsdsdsdsd"
/// asign_date : ""
/// assigned_to : ""
/// resolve_date : ""
/// status_ : "pending"
/// resolve_description : ""
/// is_active : 1
/// created_on : "2023-07-21T22:54:18.000Z"
/// updated_on : "2023-07-21T22:54:18.000Z"
/// for_complain : "order_related"

class ComplainModel {
  ComplainModel({
      this.id, 
      this.orderId, 
      this.userId, 
      this.firstName, 
      this.lastName, 
      this.contectNo, 
      this.email, 
      this.subject, 
      this.description, 
      this.asignDate, 
      this.assignedTo, 
      this.resolveDate, 
      this.status, 
      this.resolveDescription, 
      this.isActive, 
      this.createdOn, 
      this.updatedOn, 
      this.forComplain,});

  ComplainModel.fromJson(dynamic json) {
    id = json['id'];
    orderId = int.tryParse(json['order_id'].toString());
    userId = int.tryParse(json['user_id'].toString());
    firstName = json['first_name'];
    lastName = json['last_name'];
    contectNo = json['contect_no'];
    email = json['email'];
    subject = json['subject'];
    description = json['description'];
    asignDate = json['asign_date'];
    assignedTo = json['assigned_to'];
    resolveDate = json['resolve_date'];
    status = json['status_'];
    resolveDescription = json['resolve_description'];
    isActive = json['is_active'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    forComplain = json['for_complain'];
  }
  int? id;
  int? orderId;
  int? userId;
  String? firstName;
  String? lastName;
  String? contectNo;
  String? email;
  String? subject;
  String? description;
  String? asignDate;
  String? assignedTo;
  String? resolveDate;
  String? status;
  String? resolveDescription;
  int? isActive;
  String? createdOn;
  String? updatedOn;
  String? forComplain;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['user_id'] = userId;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['contect_no'] = contectNo;
    map['email'] = email;
    map['subject'] = subject;
    map['description'] = description;
    map['asign_date'] = asignDate;
    map['assigned_to'] = assignedTo;
    map['resolve_date'] = resolveDate;
    map['status_'] = status;
    map['resolve_description'] = resolveDescription;
    map['is_active'] = isActive;
    map['created_on'] = createdOn;
    map['updated_on'] = updatedOn;
    map['for_complain'] = forComplain;
    return map;
  }

}