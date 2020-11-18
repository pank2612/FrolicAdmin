// To parse this JSON data, do
//
//     final rulesModel = rulesModelFromJson(jsonString);

import 'dart:convert';

List<RulesModel> rulesModelFromJson(String str) =>
    List<RulesModel>.from(json.decode(str).map((x) => RulesModel.fromJson(x)));

String rulesModelToJson(List<RulesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RulesModelList {
  List<RulesModel> rulesModel;
  RulesModelList({this.rulesModel});
  factory RulesModelList.fromJson(Map<String, dynamic> json) => RulesModelList(
      rulesModel: List<RulesModel>.from(
          json['rulesModel'].map((e) => RulesModel.fromJson(e))));
}

class RulesModel {
  RulesModel({
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
  int points;

  factory RulesModel.fromJson(Map<String, dynamic> json) => RulesModel(
        id: json["id"],
        tournamentId: json["tournamentId"],
        name: json["name"],
        shortName: json["shortName"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tournamentId": tournamentId,
        "name": name,
        "shortName": shortName,
        "points": points,
      };
}
