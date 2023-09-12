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
    required this.id,
    required this.eventId,
    required this.studentId,
    required this.addonEventId,
    required this.orderId,
    required this.paymentStatus,
    required this.totalPrice,
    required this.addonEventStatus,
    required this.addonVolunteerUpdates,
    required this.addonVolunteerUpdateTime,
    required this.eventTimePeriod,
    required this.bookingMode,
    required this.createdAt,
    required this.updatedAt,
    required this.eventName,
    // required this.startDate,
    //required this.endDate,
    required this.price,
    required this.location,
    required this.description,
    required this.image,
    required this.volunteerId,
    required this.activityName,
    required this.ruleRegulation,
    required this.checkbox,
    this.enabled = true,
    this.userChecked = false,
  });

  final int? id;
  final int? eventId;
  final String? studentId;
  final String? addonEventId;
  final int? orderId;
  final String? paymentStatus;
  final String? totalPrice;
  String? addonEventStatus;
  final String? addonVolunteerUpdates;
  final DateTime? addonVolunteerUpdateTime;
  final String? eventTimePeriod;
  final int? bookingMode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? eventName;
  // final DateTime? startDate;
  //final DateTime? endDate;
  final int? price;
  final String? location;
  final String? description;
  final String? image;
  final int? volunteerId;
  final String? activityName;
  final String? ruleRegulation;
  final int? checkbox;
  bool? enabled;
  bool? userChecked;

  factory AddonEvent.fromJson(Map<String, dynamic> json) {
    return AddonEvent(
      id: json["id"],
      eventId: json["event_id"],
      studentId: json["student_id"],
      addonEventId: json["addon_event_id"],
      orderId: json["order_id"],
      paymentStatus: json["payment_status"],
      totalPrice: json["total_price"],
      addonEventStatus: json["addon_event_status"],
      addonVolunteerUpdates: json["addon_volunteer_updates"],
      addonVolunteerUpdateTime:
        DateTime.tryParse(json["addon_volunteer_update_time"] ?? ""),
      eventTimePeriod: json["event_time_period"],
      bookingMode: json["booking_mode"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      eventName: json["event_name"],
      //startDate: DateTime.tryParse(json["start_date"] ?? ""),
      //endDate: DateTime.tryParse(json["end_date"] ?? ""),
      price: json["price"],
      location: json["location"],
      description: json["description"],
      image: json["image"],
      volunteerId: json["volunteer_id"],
      activityName: json["activity_name"],
      ruleRegulation: json["rule_regulation"],
      checkbox: json["checkbox"],
      // enabled: true,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
        "student_id": studentId,
        "addon_event_id": addonEventId,
        "order_id": orderId,
        "payment_status": paymentStatus,
        "total_price": totalPrice,
        "addon_event_status": addonEventStatus,
        "addon_volunteer_updates": addonVolunteerUpdates,
        "addon_volunteer_update_time":
            addonVolunteerUpdateTime?.toIso8601String(),
        "event_time_period": eventTimePeriod,
        "booking_mode": bookingMode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "event_name": eventName,
        //"start_date": "${startDate!.year.toString().padLeft(4'0')}-${startDate!.month.toString().padLeft(2'0')}-${startDate!.day.toString().padLeft(2'0')}",
        //"end_date": "${endDate!.year.toString().padLeft(4'0')}-${endDate!.month.toString().padLeft(2'0')}-${endDate!.day.toString().padLeft(2'0')}",
        "price": price,
        "location": location,
        "description": description,
        "image": image,
        "volunteer_id": volunteerId,
        "activity_name": activityName,
        "rule_regulation": ruleRegulation,
        "checkbox": checkbox,
        "enabled": enabled,
        "userChecked": userChecked,
      };
}
