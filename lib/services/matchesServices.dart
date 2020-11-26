import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/models/matchesModel.dart';
import 'package:frolicsports/models/playersModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/modules/tournament/add_tournament.dart';
import 'package:http/http.dart' as http;

class GetPostMatches {
  Future<MatchesModelList> getMatches() async {
    try {
      var response = await http.get("${HTTP_URL}matches");
      //  print(response.body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("JsonData is $jsonData}");
        final MatchesModelList matchesModelList =
            MatchesModelList.fromJson({"matchesModel": jsonData});
        //print("Data is${tounamentModel.tournamentModel[1].name}");
        return matchesModelList;
      }
      throw "Something went wrong ${response.statusCode}";
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }

  postMatches({MatchesModel matchesModelObject}) async {
    var encodedData = jsonEncode(matchesModelObject.toJson());
    print("encoded Data $encodedData");
    try {
      var response = await http.post("${HTTP_URL}matches",
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: encodedData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        //function();
        print("Data Added");
        var jsonData = jsonDecode(response.body);
        print("JsonData is : $jsonData");
      }
      // throw "Something went wrong ${response.statusCode.toString()}";
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }

  editMatches({MatchesModel matchesModelObject}) async {
    var encodedData = jsonEncode(matchesModelObject.toJson());
    print("encoded Data $encodedData");
    try {
      var response = await http.put(
          "${HTTP_URL}matches/${matchesModelObject.id}",
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: encodedData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Edit Successfully", gravity: ToastGravity.CENTER);
        //function();
        print("Data Added");
        var jsonData = jsonDecode(response.body);
        print("JsonData is : $jsonData");
      }
      // throw "Something went wrong ${response.statusCode.toString()}";
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }
}
