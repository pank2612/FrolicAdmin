// To parse this JSON data, do
//
//     final contestsModel = contestsModelFromJson(jsonString);

import 'dart:convert';

List<ContestsModel> contestsModelFromJson(String str) => List<ContestsModel>.from(json.decode(str).map((x) => ContestsModel.fromJson(x)));

String contestsModelToJson(List<ContestsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class ContestsModelList {
  List<ContestsModel> contestsModel;
  ContestsModelList({this.contestsModel});
  factory ContestsModelList.fromJson(Map<String, dynamic> json) =>
      ContestsModelList(
          contestsModel: List<ContestsModel>.from(
              json["contestsModel"].map((e) => ContestsModel.fromJson(e))));
}
class ContestsModel {
  ContestsModel({
    this.id,
    this.matchId,
    this.name,
    this.contestCategory,
    this.entryAmount,
    this.maxEntries,
    this.maxEntriesPerUser,
    this.status,
  });

  int id;
  int matchId;
  String name;
  String contestCategory;
  int entryAmount;
  int maxEntries;
  int maxEntriesPerUser;
  int status;

  factory ContestsModel.fromJson(Map<String, dynamic> json) => ContestsModel(
    id: json["id"],
    matchId: json["matchId"],
    name: json["name"],
    contestCategory: json["contestCategory"],
    entryAmount: json["entryAmount"],
    maxEntries: json["maxEntries"],
    maxEntriesPerUser: json["maxEntriesPerUser"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "matchId": matchId,
    "name": name,
    "contestCategory": contestCategory,
    "entryAmount": entryAmount,
    "maxEntries": maxEntries,
    "maxEntriesPerUser": maxEntriesPerUser,
    "status": status,
  };
}
