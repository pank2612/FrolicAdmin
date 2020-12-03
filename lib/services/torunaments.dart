import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
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
      // throw "Something went wrong ${response.statusCode}";
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
        Fluttertoast.showToast(
          msg: "Added Successfully",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
        );
        print("Data Added");
        var jsonData = jsonDecode(response.body);
        print("JsonData is : $jsonData");
      }
      // throw "Something went wrong ${response.statusCode.toString()}";
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }

  editTournaments({
    TournamentModel tournamentModelObject,
  }) async {
    print("edit tour");
    print("id is ${tournamentModelObject.id}");
    var encodedData = jsonEncode(tournamentModelObject.toJson());
    print("edit tour2");
    print("encoded Data $encodedData");
    try {
      var response = await http.put(
          "${HTTP_URL}tournaments/${tournamentModelObject.id}",
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: encodedData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Edit Successfully", gravity: ToastGravity.CENTER);
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
