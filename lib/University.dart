// To parse this JSON data, do
//
//     final uniDataModel = uniDataModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names, file_names, unnecessary_new, prefer_if_null_operators, prefer_conditional_assignment

import 'dart:convert';

List<UniDataModel> uniDataModelFromJson(String str) => List<UniDataModel>.from(
    json.decode(str).map((x) => UniDataModel.fromJson(x)));

String uniDataModelToJson(List<UniDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UniDataModel {
  UniDataModel({
    this.domains,
    this.alphaTwoCode,
    this.country,
    this.webPages,
    this.name,
    this.stateProvince,
  });

  List<String>? domains;
  AlphaTwoCode? alphaTwoCode;
  String? country;
  List<String>? webPages;
  String? name;
  String? stateProvince;

  factory UniDataModel.fromJson(Map<String, dynamic> json) => UniDataModel(
      domains: List<String>.from(json["domains"].map((x) => x)),
      alphaTwoCode: alphaTwoCodeValues.map![json["alpha_two_code"]],
      country: json["country"],
      webPages: List<String>.from(json["web_pages"].map((x) => x)),
      name: json["name"],
      stateProvince: json["state-province"]);

  Map<String, dynamic> toJson() => {
        "domains": List<dynamic>.from(domains!.map((x) => x)),
        "alpha_two_code": alphaTwoCodeValues.reverse[alphaTwoCode],
        "country": country,
        "web_pages": List<dynamic>.from(webPages!.map((x) => x)),
        "name": name,
        "state-province": stateProvince,
      };
}

enum AlphaTwoCode { PK }

final alphaTwoCodeValues = EnumValues({"PK": AlphaTwoCode.PK});

// enum Country { PAKISTAN }

// final countryValues = EnumValues({"Pakistan": Country.PAKISTAN});

// enum StateProvince { PUNJAB, KHYBER_PAKHTUNKHWA, SINDH, PANJAB, BALOCHISTAN }

// final stateProvinceValues = EnumValues({
//   "Balochistan": StateProvince.BALOCHISTAN,
//   "Khyber Pakhtunkhwa": StateProvince.KHYBER_PAKHTUNKHWA,
//   "Panjab": StateProvince.PANJAB,
//   "Punjab": StateProvince.PUNJAB,
//   "Sindh": StateProvince.SINDH
// });

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
