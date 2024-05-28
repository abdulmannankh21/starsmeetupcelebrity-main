class AppointmentModel {
  String? serviceDuration;
  String? appointmentId;
  String? serviceName;
  String? servicePrice;
  String? celebrityName;
  String? celebrityId;
  String? celebrityImage;
  String? userId;
  String? userName;
  String? creationTimestamp;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? selectedDate;
  String? promoCode;
  String? timeSlotId;
  double? supportYourStarCharges;
  String? paymentMethod;
  String? status;

  AppointmentModel({
    this.serviceDuration,
    this.appointmentId,
    this.serviceName,
    this.servicePrice,
    this.celebrityImage,
    this.timeSlotId,
    this.celebrityName,
    this.celebrityId,
    this.userId,
    this.userName,
    this.creationTimestamp,
    this.startTime,
    this.endTime,
    this.selectedDate,
    this.promoCode,
    this.supportYourStarCharges,
    this.paymentMethod,
    this.status,
  });

  factory AppointmentModel.fromJson(
      Map<String, dynamic> json, String documentId) {
    return AppointmentModel(
      serviceDuration: json['serviceTitle'],
      appointmentId: documentId,
      serviceName: json['serviceName'],
      servicePrice: json['servicePrice'],
      celebrityName: json['celebrityName'],
      celebrityId: json['celebrityId'],
      celebrityImage: json['celebrityImage'],
      timeSlotId: json['timeSlotId'],
      userId: json['userId'],
      userName: json['userName'],
      creationTimestamp:
          json['creationTimestamp'] != null ? json['creationTimestamp'] : null,
      startTime:
          json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      selectedDate: json['selectedDate'] != null
          ? DateTime.parse(json['selectedDate'])
          : null,
      promoCode: json['promoCode'],
      supportYourStarCharges: json['supportYourStarCharges']?.toDouble(),
      paymentMethod: json['paymentMethod'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceTitle': serviceDuration,
      'serviceName': serviceName,
      'servicePrice': servicePrice,
      'celebrityName': celebrityName,
      'celebrityId': celebrityId,
      'timeSlotId': timeSlotId,
      'celebrityImage': celebrityImage,
      'userId': userId,
      'userName': userName,
      'creationTimestamp': creationTimestamp,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'selectedDate': selectedDate?.toIso8601String(),
      'promoCode': promoCode,
      'supportYourStarCharges': supportYourStarCharges,
      'paymentMethod': paymentMethod,
      'status': status,
    };
  }
}
