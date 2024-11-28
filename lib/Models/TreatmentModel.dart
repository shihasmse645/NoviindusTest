// To parse this JSON data, do
//
//     final treatmentModel = treatmentModelFromJson(jsonString);

import 'dart:convert';

TreatmentModel treatmentModelFromJson(String str) =>
    TreatmentModel.fromJson(json.decode(str));

String treatmentModelToJson(TreatmentModel data) => json.encode(data.toJson());

class TreatmentModel {
  bool? status;
  String? message;
  List<Treatment>? treatments;

  TreatmentModel({
    this.status,
    this.message,
    this.treatments,
  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) => TreatmentModel(
        status: json["status"],
        message: json["message"],
        treatments: json["treatments"] == null
            ? []
            : List<Treatment>.from(
                json["treatments"]!.map((x) => Treatment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "treatments": treatments == null
            ? []
            : List<dynamic>.from(treatments!.map((x) => x.toJson())),
      };
}

class Treatment {
  int? id;
  List<Branchs>? branches;
  String? name;
  String? duration;
  String? price;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  Treatment({
    this.id,
    this.branches,
    this.name,
    this.duration,
    this.price,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        id: json["id"],
        branches: json["branches"] == null
            ? []
            : List<Branchs>.from(
                json["branches"]!.map((x) => Branchs.fromJson(x))),
        name: json["name"],
        duration: json["duration"],
        price: json["price"],
        isActive: json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branches": branches == null
            ? []
            : List<dynamic>.from(branches!.map((x) => x.toJson())),
        "name": name,
        "duration": duration,
        "price": price,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Branchs {
  int? id;
  String? name;
  int? patientsCount;
  String? location;
  String? phone;
  String? mail;
  String? address;
  String? gst;
  bool? isActive;

  Branchs({
    this.id,
    this.name,
    this.patientsCount,
    this.location,
    this.phone,
    this.mail,
    this.address,
    this.gst,
    this.isActive,
  });

  factory Branchs.fromJson(Map<String, dynamic> json) => Branchs(
        id: json["id"],
        name: json["name"],
        patientsCount: json["patients_count"],
        location: json["location"],
        phone: json["phone"],
        mail: json["mail"],
        address: json["address"],
        gst: json["gst"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "patients_count": patientsCount,
        "location": location,
        "phone": phone,
        "mail": mail,
        "address": address,
        "gst": gst,
        "is_active": isActive,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
