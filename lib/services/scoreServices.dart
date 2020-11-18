import 'dart:convert';
import 'dart:io';

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

  postScores(
      {TournamentModel tournamentModelObject, Function function}) async {
    var encodedData = jsonEncode(tournamentModelObject.toJson());
    print("encoded Data $encodedData");
    try {
      var response = await http.post("http://localhost/tournaments",
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: encodedData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        function();
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
