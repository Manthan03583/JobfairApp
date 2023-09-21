import 'dart:convert';
// class CheckList {
//   CheckList({
//     required this.addonEvents,
//   });

//   final List<AddonEvent> addonEvents;

//   factory CheckList.fromJson(Map<String, dynamic> json) {
//     return CheckList(
//       addonEvents: json["addon_events"] == null
//           ? []
//           : List<AddonEvent>.from(
//               json["addon_events"]!.map((x) => AddonEvent.fromJson(x))),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "addon_events": addonEvents.map((x) => x.toJson()).toList(),
//       };
// }

// AddonEvent addonEventFromJson(String str) =>
//     AddonEvent.fromJson(json.decode(str));
// String addonEventToJson(AddonEvent data) => json.encode(data.toJson());

List<AddonEvent> addonEventFromJson(String str) =>
    List<AddonEvent>.from(json.decode(str).map((x) => AddonEvent.fromJson(x)));

String addonEventToJson(List<AddonEvent> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddonEvent {
  AddonEvent({
    required this.companyId,
    required this.paymentId,
    required this.bookingId,
    required this.companyName,
    required this.comapanyImage,
    required this.comapanyDescription,
    required this.jobVacancy,
    required this.companyLocation,
    required this.startDate,
    required this.endDate,
    required this.id,
    required this.studentId,
    required this.paymentStatus,
    required this.addonEventStatus,
    required this.addonVolunteerUpdates,
    required this.addonVolunteerUpdateTime,
    required this.bookingMode,
    required this.createdAt,
    required this.updatedAt,
    // required this.startDate,
    //required this.endDate,
    required this.price,
    required this.checkbox,
    this.enabled = true,
    this.userChecked = false,
  });

  final int? id;
  final String companyId;
  final String? studentId;
  // final String? addonEventId;
  final String paymentId;
  final String? paymentStatus;
  final String? price;
  final String bookingId;
  final String bookingMode;
  String? addonEventStatus;
  final String? addonVolunteerUpdates;
  final String? addonVolunteerUpdateTime;
  // final String? eventTimePeriod;
  final String? createdAt;
  final String? updatedAt;
  final String? companyName;
  final String? comapanyImage;
  final String? comapanyDescription;
  final String jobVacancy;
  final String? companyLocation;
  // final String volunteerId;
  // final String? activityName;
  // final String? ruleRegulation;
  final int? checkbox;
  bool? enabled;
  bool? userChecked;
  final String? startDate;
  final String? endDate;

  factory AddonEvent.fromJson(Map<String, dynamic> json) {
    return AddonEvent(
      id: json["id"],
      // eventId: json["event_id"],
      studentId: json["student_id"],
      // addonEventId: json["addon_event_id"],
      // orderId: json["order_id"],
      paymentStatus: json["payment_status"],
      // totalPrice: json["total_price"],
      addonEventStatus: json["addon_event_status"],
      addonVolunteerUpdates: json["addon_volunteer_updates"],
      addonVolunteerUpdateTime:
          json["addon_volunteer_update_time"] ?? "",
      // eventTimePeriod: json["event_time_period"],
      bookingMode: json["booking_mode"],
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      // eventName: json["event_name"],
      //startDate: DateTime.tryParse(json["start_date"] ?? ""),
      //endDate: DateTime.tryParse(json["end_date"] ?? ""),
      price: json["price"],
      // location: json["location"],
      // description: json["description"],
      // image: json["image"],
      // volunteerId: json["volunteer_id"],
      // activityName: json["activity_name"],
      // ruleRegulation: json["rule_regulation"],
      // enabled: true,
      checkbox: json["checkbox"],
      bookingId: json["booking_id"],
      companyId: json["company_id"],
      jobVacancy: json["job_vacancy"],
      paymentId: json["payment_id"],
      comapanyDescription: json["company_desc"],
      comapanyImage: json["company_image"],
      companyLocation: json["company_location"],
      companyName: json["company_name"],
      endDate: json["end_date"],
      startDate: json["start_date"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        // "event_id": eventId,
        "student_id": studentId,
        "comapany_id":companyId,
        "payment_id":paymentId,
        // "addon_event_id": addonEventId,
        // "order_id": orderId,
        "payment_status": paymentStatus,
        // "total_price": totalPrice,
        "addon_event_status": addonEventStatus,
        "addon_volunteer_updates": addonVolunteerUpdates,
        "addon_volunteer_update_time":
            addonVolunteerUpdateTime,
        // "event_time_period": eventTimePeriod,

        "booking_id": bookingId,
        "booking_mode": bookingMode,
        "created_at": createdAt,
        "updated_at": updatedAt,
        // "event_name": eventName,
        // "start_date": "${startDate!.year.toString().padLeft(4,'0')}-${startDate!.month.toString().padLeft(2,'0')}-${startDate!.day.toString().padLeft(2,'0')}",
        "start_date": startDate,
        // "end_date": "${endDate!.year.toString().padLeft(4,'0')}-${endDate!.month.toString().padLeft(2,'0')}-${endDate!.day.toString().padLeft(2,'0')}",
        "end_date": endDate,
        "price": price,
        // "location": location,
        // "description": description,
        // "image": image,
        // "volunteer_id": volunteerId,
        // "activity_name": activityName,
        // "rule_regulation": ruleRegulation,
        "company_name":companyName,
        "company_image":comapanyImage,
        "company_desc":comapanyDescription,
        "job_vacancy":jobVacancy,
        "checkbox": checkbox,
        "enabled": enabled,
        "userChecked": userChecked,
      };
}
