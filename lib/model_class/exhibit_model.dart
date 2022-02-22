// To parse this JSON data, do
//
//     final exhibitModel = exhibitModelFromJson(jsonString);

import 'dart:convert';

class ExhibitModel {
  ExhibitModel({
    required this.zoneId,
    required this.zoneName,
    required this.zoneImage,
    required this.zones,
  });

  String zoneId;
  String zoneName;
  String zoneImage;
  List<Zone> zones;

  factory ExhibitModel.fromRawJson(String str) => ExhibitModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExhibitModel.fromJson(Map<String, dynamic> json) => ExhibitModel(
    zoneId: json["zone_id"],
    zoneName: json["zone_name"],
    zoneImage: json["zone_image"],
    zones: List<Zone>.from(json["zones"].map((x) => Zone.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "zone_id": zoneId,
    "zone_name": zoneName,
    "zone_image": zoneImage,
    "zones": List<dynamic>.from(zones.map((x) => x.toJson())),
  };
}

class Zone {
  Zone({
    required this.exhibitId,
    required this.audio,
    required this.ip,
    required this.exhibitImage,
  });

  String exhibitId;
  String audio;
  String ip;
  String exhibitImage;

  factory Zone.fromRawJson(String str) => Zone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
    exhibitId: json["exhibit_id"],
    audio: json["audio"],
    ip: json["ip"],
    exhibitImage: json["exhibit_image"],
  );

  Map<String, dynamic> toJson() => {
    "exhibit_id": exhibitId,
    "audio": audio,
    "ip": ip,
    "exhibit_image": exhibitImage,
  };
}
