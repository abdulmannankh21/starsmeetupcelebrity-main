class NotificationModel {
  String? serviceName;
  String? celebrityName;
  String? userId;
  String? celebrityId;
  String? userName;

  DateTime? creationTimestamp;

  String? status;
  NotificationModel(
      {this.serviceName,
      this.celebrityName,
      this.userId,
      this.celebrityId,
      this.userName,
      this.creationTimestamp,
      this.status});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      serviceName: json['serviceName'],
      celebrityName: json['celebrityName'],
      userId: json['userId'],
      celebrityId: json['celebrityId'],
      userName: json['userName'],
      creationTimestamp: json['creationTimestamp'] != null
          ? DateTime.parse(json['creationTimestamp'])
          : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceName': serviceName,
      'celebrityName': celebrityName,
      'userId': userId,
      'celebrityId': celebrityId,
      'userName': userName,
      'creationTimestamp': creationTimestamp?.toIso8601String(),
      "status": status
    };
  }
}
