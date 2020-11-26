import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/models/sportsModel.dart';
import 'package:http/http.dart' as http;

class GetSports {
  Future<SportsModelList> getSports1() async {
    //String url = "http://localhost/sports";
    try {
      var response = await http.get("${HTTP_URL}sports");
      // print(response.body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        // print("JsonData is $jsonData}");
        final SportsModelList sportsModel =
            SportsModelList.fromJson({"sportsModel": jsonData});
        //SportsModel sportsModel = SportsModel.fromJson(jsonData);
        return sportsModel;
      }
      throw "Something went wrong ${response.statusCode}";
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }

  postSports({SportsModel sportsModelObject}) async {
    var encodedData = jsonEncode(sportsModelObject.toJson());
    print("encoded Data $encodedData");
    try {
      var response = await http.post("${HTTP_URL}sports",
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: encodedData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Data Added");

        var jsonData = jsonDecode(response.body);
        print("JsonData is : $jsonData");
      }
      // throw "Something went wrong ${response.statusCode.toString()}";
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }

  editSports({SportsModel sportsModelObject}) async {
    var encodedData = jsonEncode(sportsModelObject.toJson());
    print("encoded Data $encodedData");
    try {
      var response = await http.put("${HTTP_URL}sports/${sportsModelObject.id}",
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: encodedData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Data Added");
        Fluttertoast.showToast(
          msg: "Edit Successfully",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
        );
        var jsonData = jsonDecode(response.body);
        print("JsonData is : $jsonData");
      }
      // throw "Something went wrong ${response.statusCode.toString()}";
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }

  Future<List<SportsModel>> getSports() async {
    String url = "http://localhost/sports";
    try {
      var response = await http.get(url);
//      print(response.body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        //   print("JsonData is $jsonData}");
        //final List<SportsModel> sportsModel =
        //  SportsModel.fromJson(jsonData) as List<SportsModel>;
        List<SportsModel> sportsModelList = List<SportsModel>();

        for (var sport in jsonData) {
          // print(sport['name']);
          SportsModel sportsModel = SportsModel.fromJson(sport);
          // print(sportsModel.name);
          sportsModelList.add(sportsModel);
        }
        return sportsModelList;
      }
      throw "Something went wrong ${response.statusCode}";
    } catch (e) {
      print("Error is ${e.toString()}");
    }
  }
}
