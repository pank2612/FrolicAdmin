// To parse this JSON data, do
//
//     final specialRulesModel = specialRulesModelFromJson(jsonString);

import 'dart:convert';

List<SpecialRulesModel> specialRulesModelFromJson(String str) =>
    List<SpecialRulesModel>.from(
        json.decode(str).map((x) => SpecialRulesModel.fromJson(x)));

String specialRulesModelToJson(List<SpecialRulesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpecialRulesModelList {
  List<SpecialRulesModel> specialRulesModel;
  SpecialRulesModelList({this.specialRulesModel});
  factory SpecialRulesModelList.fromJson(Map<String, dynamic> json) =>
      SpecialRulesModelList(
          specialRulesModel: List<SpecialRulesModel>.from(
              json['specialRulesModel']
                  .map((e) => SpecialRulesModel.fromJson(e))));
}

class SpecialRulesModel {
  SpecialRulesModel({
    this.id,
    this.tournamentId,
    this.name,
    this.shortName,
    this.points,
  });

  int id;
  int tournamentId;
  String name;
  String shortName;
  double points;

  factory SpecialRulesModel.fromJson(Map<String, dynamic> json) =>
      SpecialRulesModel(
        id: json["id"],
        tournamentId: json["tournamentId"],
        name: json["name"],
        shortName: json["shortName"],
        points: json["points"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tournamentId": tournamentId,
        "name": name,
        "shortName": shortName,
        "points": points,
      };
}
