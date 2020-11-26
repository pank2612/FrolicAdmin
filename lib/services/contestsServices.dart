import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/models/contestsModel.dart';
import 'package:frolicsports/models/matchesModel.dart';
import 'package:frolicsports/models/playersModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/modules/tournament/add_tournament.dart';
import 'package:http/http.dart' as http;

class GetPostContest {
  Future<ContestsModelList> getContests() async {
    try {
      var response = await http.get("${HTTP_URL}contests");
      //  print(response.body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("JsonData is $jsonData}");
        final ContestsModelList contestsModelList =
            ContestsModelList.fromJson({"contestsModel": jsonData});
        //print("Data is${tounamentModel.tournamentModel[1].name}");
        return contestsModelList;
      }
      throw "Something went wrong ${response.statusCode}";
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }

  postContests({ContestsModel contestModelObject}) async {
    var encodedData = jsonEncode(contestModelObject.toJson());
    print("encoded Data $encodedData");
    try {
      var response = await http.post("${HTTP_URL}contests",
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

  editContests({ContestsModel contestModelObject}) async {
    var encodedData = jsonEncode(contestModelObject.toJson());
    print("encoded Data $encodedData");
    try {
      var response = await http.put(
          "${HTTP_URL}contests/${contestModelObject.id}",
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
