import 'dart:convert';
import 'dart:io';

import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/models/playersModel.dart';
import 'package:frolicsports/models/teamsModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/modules/tournament/add_tournament.dart';
import 'package:http/http.dart' as http;

class GetPostTeams {
  Future<TeamsModelList> getTeams() async {
    try {
      var response = await http.get("${HTTP_URL}teams");
      //  print(response.body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("JsonData is $jsonData}");
        final TeamsModelList teamsModelList =
            TeamsModelList.fromJson({"teamsModel": jsonData});
        //print("Data is${tounamentModel.tournamentModel[1].name}");
        return teamsModelList;
      }
      throw "Something went wrong ${response.statusCode}";
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }

  postTeams({TeamsModel teamsModelObject, Function function}) async {
    var encodedData = jsonEncode(teamsModelObject.toJson());
    print("encoded Data $encodedData");
    try {
      var response = await http.post("${HTTP_URL}teams",
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
