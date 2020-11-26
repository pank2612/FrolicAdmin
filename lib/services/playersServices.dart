import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/models/playersModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/modules/tournament/add_tournament.dart';
import 'package:http/http.dart' as http;

class GetPostPlayers {
  Future<PlayersModelList> getPlayers() async {
    try {
      var response = await http.get("${HTTP_URL}players");
      //  print(response.body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("JsonData is $jsonData}");
        final PlayersModelList playersModel =
            PlayersModelList.fromJson({"playersModel": jsonData});
        //print("Data is${tounamentModel.tournamentModel[1].name}");
        return playersModel;
      }
      throw "Something went wrong ${response.statusCode}";
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }

  postPlayers({PlayersModel playersModelObject, Function function}) async {
    var encodedData = jsonEncode(playersModelObject.toJson());
    print("encoded Data $encodedData");
    try {
      var response = await http.post("${HTTP_URL}players",
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

  editPlayers({PlayersModel playersModelObject}) async {
    var encodedData = jsonEncode(playersModelObject.toJson());
    print("encoded Data $encodedData");
    try {
      var response = await http.put(
          "${HTTP_URL}players/${playersModelObject.id}",
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
