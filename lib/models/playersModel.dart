// To parse this JSON data, do
//
//     final playersModel = playersModelFromJson(jsonString);

import 'dart:convert';

List<PlayersModel> playersModelFromJson(String str) => List<PlayersModel>.from(
    json.decode(str).map((x) => PlayersModel.fromJson(x)));

String playersModelToJson(List<PlayersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlayersModelList {
  List<PlayersModel> playersModel;
  PlayersModelList({this.playersModel});
  factory PlayersModelList.fromJson(Map<String, dynamic> json) =>
      PlayersModelList(
          playersModel: List<PlayersModel>.from(
              json["playersModel"].map((e) => PlayersModel.fromJson(e))));
}

class PlayersModel {
  PlayersModel({
    this.id,
    this.teamId,
    this.name,
    this.picture,
    this.shortName,
    this.skillsId,
    this.credits,
    this.points,
    this.status,
    this.country,
    this.isPlaying,
  });

  int id;
  int teamId;
  String name;
  String picture;
  String shortName;
  int skillsId;
  int credits;
  int points;
  int status;
  String country;
  int isPlaying;

  factory PlayersModel.fromJson(Map<String, dynamic> json) => PlayersModel(
        id: json["id"],
        teamId: json["teamId"],
        name: json["name"],
        picture: json["picture"],
        shortName: json["shortName"],
        skillsId: json["skillsId"],
        credits: json["credits"],
        points: json["points"],
        status: json["status"],
        country: json["country"],
        isPlaying: json["isPlaying"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teamId": teamId,
        "name": name,
        "picture": picture,
        "shortName": shortName,
        "skillsId": skillsId,
        "credits": credits,
        "points": points,
        "status": status,
        "country": country,
        "isPlaying": isPlaying,
      };
}
