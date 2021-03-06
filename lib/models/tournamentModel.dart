// To parse this JSON data, do
//
//     final tournamentModel = tournamentModelFromJson(jsonString);

import 'dart:convert';

List<TournamentModel> tournamentModelFromJson(String str) =>
    List<TournamentModel>.from(
        json.decode(str).map((x) => TournamentModel.fromJson(x)));

String tournamentModelToJson(List<TournamentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TournamentModelList {
  List<TournamentModel> tournamentModel;
  TournamentModelList({this.tournamentModel});
  factory TournamentModelList.fromJson(Map<String, dynamic> json) {
    return TournamentModelList(
        tournamentModel:
            List<TournamentModel>.from(json["tournamentModel"].map((e) {
      return TournamentModel.fromJson(e);
    })));
  }
}

class TournamentModel {
  TournamentModel({
    this.id,
    this.sportsId,
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.logo,
    this.maxPoints,
    this.maxPlayers,
    this.country,
    this.enabled,
    this.maxSingleTeam,
    this.deadlineSeconds,
    this.teamFolderName,
    this.maxOverPerBowler,
    this.inningsOver,
    this.playerFolderName,
  });

  int id;
  int sportsId;
  String name;
  String description;
  DateTime startDate;
  DateTime endDate;
  int maxOverPerBowler;
  int inningsOver;
  String logo;
  int maxPoints;
  int maxPlayers;
  String country;
  int enabled;
  int maxSingleTeam;
  int deadlineSeconds;
  dynamic teamFolderName;
  dynamic playerFolderName;

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      TournamentModel(
        id: json["id"],
        sportsId: json["sportsId"],
        name: json["name"],
        description: json["description"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        logo: json["logo"],
        maxPoints: json["maxPoints"],
        maxPlayers: json["maxPlayers"],
        country: json["country"],
        inningsOver: json['inningsOver'],
        maxOverPerBowler: json['maxOverPerBowler'],
        enabled: json["enabled"],
        maxSingleTeam: json["maxSingleTeam"],
        deadlineSeconds: json["deadlineSeconds"],
        teamFolderName: json["teamFolderName"],
        playerFolderName: json["playerFolderName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sportsId": sportsId,
        "name": name,
        "description": description,
        "startDate": startDate == null
            ? null
            : startDate.toIso8601String().replaceAll("Z", ""),
        "endDate": endDate == null
            ? null
            : endDate.toIso8601String().replaceAll("Z", ""),
        "logo": logo,
        "maxPoints": maxPoints,
        "maxPlayers": maxPlayers,
        "maxOverPerBowler": maxOverPerBowler,
        "inningsOver": inningsOver,
        "country": country,
        "enabled": enabled,
        "maxSingleTeam": maxSingleTeam,
        "deadlineSeconds": deadlineSeconds,
        "teamFolderName": teamFolderName,
        "playerFolderName": playerFolderName,
      };
}
