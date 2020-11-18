// To parse this JSON data, do
//
//     final skillsModel = skillsModelFromJson(jsonString);

import 'dart:convert';

List<SkillsModel> skillsModelFromJson(String str) => List<SkillsModel>.from(json.decode(str).map((x) => SkillsModel.fromJson(x)));

String skillsModelToJson(List<SkillsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class SkillsModelList {
  List<SkillsModel> skillsModel;
  SkillsModelList({this.skillsModel});
  factory SkillsModelList.fromJson(Map<String, dynamic> json) => SkillsModelList(
      skillsModel: List<SkillsModel>.from(
          json['skillsModel'].map((e) => SkillsModel.fromJson(e))));
}
class SkillsModel {
  SkillsModel({
    this.id,
    this.tournamentId,
    this.name,
    this.shortName,
    this.min,
    this.max,
  });

  int id;
  int tournamentId;
  String name;
  String shortName;
  int min;
  int max;

  factory SkillsModel.fromJson(Map<String, dynamic> json) => SkillsModel(
    id: json["id"],
    tournamentId: json["tournamentId"],
    name: json["name"],
    shortName: json["shortName"],
    min: json["min"],
    max: json["max"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tournamentId": tournamentId,
    "name": name,
    "shortName": shortName,
    "min": min,
    "max": max,
  };
}
