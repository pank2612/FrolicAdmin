// To parse this JSON data, do
//
//     final sportsModel = sportsModelFromJson(jsonString);
class SportsModelList {
  List<SportsModel> sportsModel;
  SportsModelList({this.sportsModel});
  factory SportsModelList.fromJson(Map<String, dynamic> json) =>
      SportsModelList(
          sportsModel: List<SportsModel>.from(
              json["sportsModel"].map((e) => SportsModel.fromJson(e))));
}

class SportsModel {
  SportsModel({this.id, this.name, this.shortCode, this.logo});
  String shortCode;
  String logo;
  int id;
  String name;

  factory SportsModel.fromJson(dynamic json) => SportsModel(
      id: json["id"],
      name: json["name"],
      logo: json["logo"],
      shortCode: json["shortCode"]);

  Map<String, dynamic> toJson() =>
      {"name": name, "shortCode": shortCode, "logo": logo};
}
