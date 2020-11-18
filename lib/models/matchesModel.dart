// To parse this JSON data, do
//
//     final matchesModel = matchesModelFromJson(jsonString);

import 'dart:convert';

List<MatchesModel> matchesModelFromJson(String str) => List<MatchesModel>.from(
    json.decode(str).map((x) => MatchesModel.fromJson(x)));

String matchesModelToJson(List<MatchesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MatchesModelList {
  List<MatchesModel> matchesModel;
  MatchesModelList({this.matchesModel});
  factory MatchesModelList.fromJson(Map<String, dynamic> json) =>
      MatchesModelList(
          matchesModel: List<MatchesModel>.from(
              json["matchesModel"].map((e) => MatchesModel.fromJson(e))));
}

class MatchesModel {
  MatchesModel({
    this.id,
    this.tournamentId,
    this.number,
    this.startDate,
    this.startTime,
    this.venue,
    this.description,
    this.score,
    this.team1Id,
    this.team2Id,
  });

  int id;
  int tournamentId;
  int number;
  DateTime startDate;
  String startTime;
  String venue;
  String description;
  String score;
  int team1Id;
  int team2Id;

  factory MatchesModel.fromJson(Map<String, dynamic> json) => MatchesModel(
        id: json["id"],
        tournamentId: json["tournamentId"],
        number: json["number"],
        startDate: DateTime.parse(json["startDate"]),
        startTime: json["startTime"],
        venue: json["venue"],
        description: json["description"],
        score: json["score"],
        team1Id: json["team1Id"],
        team2Id: json["team2Id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tournamentId": tournamentId,
        "number": number,
        "startDate": startDate.toIso8601String(),
        "startTime": startTime,
        "venue": venue,
        "description": description,
        "score": score,
        "team1Id": team1Id,
        "team2Id": team2Id,
      };
}
