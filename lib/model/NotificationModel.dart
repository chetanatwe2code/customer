/// id : 87
/// actor_id : "19"
/// actor_type : "user"
/// message : "successfully placed order,order_no="
/// status : "unread"
/// created_on : "2023-04-26T11:29:50.000Z"
/// updated_on : "2023-04-26T11:29:50.000Z"
///  "notification_type": "order",
//     "notification_type_id": 804437

class NotificationModel {
  NotificationModel({
      this.id, 
      this.actorId, 
      this.actorType, 
      this.message, 
      this.status, 
      this.notificationType,
      this.notificationTypeId,
      this.createdOn,
      this.updatedOn,});

  NotificationModel.fromJson(dynamic json) {
    id = json['id'];
    actorId = json['actor_id'];
    actorType = json['actor_type'];
    message = json['message'];
    notificationType = json['notification_type'];
    notificationTypeId = int.tryParse(json['notification_type_id'].toString());
    status = json['status'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
  }
  int? id;
  String? actorId;
  String? actorType;
  String? message;
  String? status;
  String? notificationType;
  int? notificationTypeId;
  String? createdOn;
  String? updatedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['actor_id'] = actorId;
    map['actor_type'] = actorType;
    map['message'] = message;
    map['status'] = status;
    map['notification_type'] = notificationType;
    map['notification_type_id'] = notificationTypeId;
    map['created_on'] = createdOn;
    map['updated_on'] = updatedOn;
    return map;
  }

}