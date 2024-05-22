import 'package:uuid/uuid.dart';

class AppointmentModel {
  String? appointmentId;
  String? serviceDuration;
  String? serviceName;
  String? servicePrice;
  String? celebrityName;
  String? celebrityId;
  String? celebrityImage;
  String? userId;
  String? userName;
  DateTime? creationTimestamp;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? selectedDate;
  String? promoCode;
  double? supportYourStarCharges;
  String? paymentMethod;

  AppointmentModel({
    this.appointmentId,
    this.serviceDuration,
    this.serviceName,
    this.servicePrice,
    this.celebrityImage,
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
  }) {
    // Generate a unique appointmentId if not provided
    appointmentId ??= Uuid().v4();
  }

  factory AppointmentModel.fromJson(
      Map<String, dynamic> json, String documentId) {
    return AppointmentModel(
      appointmentId: documentId, // Assign document ID as appointment ID
      serviceDuration: json['serviceTitle'],
      serviceName: json['serviceName'],
      servicePrice: json['servicePrice'],
      celebrityName: json['celebrityName'],
      celebrityId: json['celebrityId'],
      celebrityImage: json['celebrityImage'],
      userId: json['userId'],
      userName: json['userName'],
      creationTimestamp: json['creationTimestamp'] != null
          ? DateTime.parse(json['creationTimestamp'])
          : null,
      startTime:
          json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      selectedDate: json['selectedDate'] != null
          ? DateTime.parse(json['selectedDate'])
          : null,
      promoCode: json['promoCode'],
      supportYourStarCharges: json['supportYourStarCharges']?.toDouble(),
      paymentMethod: json['paymentMethod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentId': appointmentId,
      'serviceTitle': serviceDuration,
      'serviceName': serviceName,
      'servicePrice': servicePrice,
      'celebrityName': celebrityName,
      'celebrityId': celebrityId,
      'celebrityImage': celebrityImage,
      'userId': userId,
      'userName': userName,
      'creationTimestamp': creationTimestamp?.toIso8601String(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'selectedDate': selectedDate?.toIso8601String(),
      'promoCode': promoCode,
      'supportYourStarCharges': supportYourStarCharges,
      'paymentMethod': paymentMethod,
    };
  }
}
