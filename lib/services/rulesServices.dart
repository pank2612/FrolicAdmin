import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/models/playersModel.dart';
import 'package:frolicsports/models/rulesModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/modules/tournament/add_tournament.dart';
import 'package:http/http.dart' as http;

class GetPostRules {
  Future<RulesModelList> getRule() async {
    try {
      var response = await http.get("${HTTP_URL}rules");
      //  print(response.body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("JsonData is $jsonData}");
        final RulesModelList rulesModelList =
            RulesModelList.fromJson({"rulesModel": jsonData});
        //print("Data is${tounamentModel.tournamentModel[1].name}");
        return rulesModelList;
      }
      throw "Something went wrong ${response.statusCode}";
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }

  postRules({RulesModel rulesModelObject, Function function}) async {
    var encodedData = jsonEncode(rulesModelObject.toJson());
    print("encoded Data $encodedData");
    try {
      var response = await http.post("${HTTP_URL}rules",
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

  editRules({RulesModel rulesModelObject}) async {
    var encodedData = jsonEncode(rulesModelObject.toJson());
    print("encoded Data $encodedData");
    try {
      var response = await http.put("${HTTP_URL}rules/${rulesModelObject.id}",
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
