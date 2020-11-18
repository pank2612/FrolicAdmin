// To parse this JSON data, do
//
//     final prizeModel = prizeModelFromJson(jsonString);

import 'dart:convert';

List<PrizeModel> prizeModelFromJson(String str) =>
    List<PrizeModel>.from(json.decode(str).map((x) => PrizeModel.fromJson(x)));

String prizeModelToJson(List<PrizeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PrizeModelList {
  List<PrizeModel> prizeModel;
  PrizeModelList({this.prizeModel});
  factory PrizeModelList.fromJson(Map<String, dynamic> json) => PrizeModelList(
      prizeModel: List<PrizeModel>.from(
          json["prizeModel"].map((e) => PrizeModel.fromJson(e))));
}

class PrizeModel {
  PrizeModel({
    this.id,
    this.contestId,
    this.rankRangeStart,
    this.rankRangeEnd,
    this.amount,
    this.status,
  });

  int id;
  int contestId;
  int rankRangeStart;
  int rankRangeEnd;
  int amount;
  int status;

  factory PrizeModel.fromJson(Map<String, dynamic> json) => PrizeModel(
        id: json["id"],
        contestId: json["contestId"],
        rankRangeStart: json["rankRangeStart"],
        rankRangeEnd: json["rankRangeEnd"],
        amount: json["amount"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contestId": contestId,
        "rankRangeStart": rankRangeStart,
        "rankRangeEnd": rankRangeEnd,
        "amount": amount,
        "status": status,
      };
}
