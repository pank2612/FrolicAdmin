import 'dart:convert';
import 'dart:io';

import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/modules/tournament/add_tournament.dart';
import 'package:http/http.dart' as http;

class GetPostTournaments {
  Future<TournamentModelList> getTournaments() async {
    try {
      var response = await http.get("${HTTP_URL}tournaments");
      //  print(response.body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("JsonData is $jsonData}");
        final TournamentModelList tounamentModel =
            TournamentModelList.fromJson({"tournamentModel": jsonData});
        //print("Data is${tounamentModel.tournamentModel[1].name}");
        return tounamentModel;
      }
      throw "Something went wrong ${response.statusCode}";
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }

  postTournaments(
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
