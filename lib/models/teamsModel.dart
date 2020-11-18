// To parse this JSON data, do
//
//     final teamsModel = teamsModelFromJson(jsonString);

import 'dart:convert';

List<TeamsModel> teamsModelFromJson(String str) =>
    List<TeamsModel>.from(json.decode(str).map((x) => TeamsModel.fromJson(x)));

String teamsModelToJson(List<TeamsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamsModelList {
  List<TeamsModel> teamsModel;
  TeamsModelList({this.teamsModel});
  factory TeamsModelList.fromJson(Map<String, dynamic> json) => TeamsModelList(
      teamsModel: List<TeamsModel>.from(
          json['teamsModel'].map((e) => TeamsModel.fromJson(e))));
}

class TeamsModel {
  TeamsModel({
    this.id,
    this.tournamentId,
    this.name,
    this.shortName,
    this.logo,
  });

  int id;
  int tournamentId;
  String name;
  String shortName;
  String logo;

  factory TeamsModel.fromJson(Map<String, dynamic> json) => TeamsModel(
        id: json["id"],
        tournamentId: json["tournamentId"],
        name: json["name"],
        shortName: json["shortName"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tournamentId": tournamentId,
        "name": name,
        "shortName": shortName,
        "logo": logo,
      };
}
