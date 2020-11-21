import 'package:flutter/material.dart';
import 'package:frolicsports/models/rulesModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/modules/manage/manage_rules/addRules.dart';
import 'package:frolicsports/screens/homeScreen.dart';
import 'package:frolicsports/services/rulesServices.dart';
import 'package:frolicsports/services/torunaments.dart';

class ManageRulesScreen extends StatefulWidget {
  @override
  _ManageRulesScreenState createState() => _ManageRulesScreenState();
}

class _ManageRulesScreenState extends State<ManageRulesScreen> {
  bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    getRulesData();
    getTournamentData();
  }

  RulesModelList rulesModelList = RulesModelList();
  GetPostRules getPostRules = GetPostRules();
  getRulesData() async {
    rulesModelList = await getPostRules.getRule();
    //getTournamentData();
    setState(() {
      _loading = false;
    });
  }

  TournamentModelList tournamentModelList = TournamentModelList();
  GetPostTournaments getPostTournaments = GetPostTournaments();
  getTournamentData() async {
    tournamentModelList = await getPostTournaments.getTournaments();
//    setState(() {
//      _loading = false;
//    });
  }

  String getName(int Id) {
    String tourName = "";
    tournamentModelList.tournamentModel.forEach((tour) {
      if (tour.id == Id) {
        tourName = tour.name;
      }
    });
    return tourName;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => Navigator.push(
          context, MaterialPageRoute(builder: (context) => new HomeScreen())),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.05,
              left: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.10,
              bottom: MediaQuery.of(context).size.height * 0.20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _addButton(),
              Expanded(
                child: Card(
                    elevation: 5,
                    //color: Colors.grey,
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * 0.20),
                                child: Text("Search:",
                                    style: TextStyle(
                                      fontSize: 17,
                                    )),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "RULES",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.lightBlue),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.112,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.35,
                                    height:
                                        MediaQuery.of(context).size.height * 0.05,
                                    child: TextField(
                                        // controller: controller,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.white,
                                          filled: true,
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 2),
                              margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.115),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.08,
                              color: Colors.grey.shade300,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  numbers("#"),
                                  normalText("Tournament"),
                                  normalText("Name"),
                                  normalText("Shortname"),
                                  normalText("Points"),
                                  normalText("Action"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  RulesModel rulesModel = RulesModel();
                                  rulesModel = rulesModelList.rulesModel[index];
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 2),
                                        width: MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            numbers("${index + 1}"),
                                            normalText(
                                                getName(rulesModel.tournamentId)),
                                            normalText(
                                                rulesModel.name.toString()),
                                            normalText(
                                                rulesModel.shortName.toString()),
                                            normalText(
                                                rulesModel.points.toString()),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.close,
                                                      color: Colors.red.shade700,
                                                    ),
                                                    Icon(
                                                      Icons.mode_edit,
                                                      color: Colors.orange,
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      )
                                    ],
                                  );
                                },
                                itemCount: rulesModelList.rulesModel == null
                                    ? 0
                                    : rulesModelList.rulesModel.length,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Showing 0 to 0 of 0 entries"),
                                  Row(
                                    children: [
                                      MaterialButton(
                                        onPressed: () {},
                                        color: Colors.lightBlue,
                                        child: Text(
                                          "Previous",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () {},
                                        color: Colors.lightBlue,
                                        child: Text(
                                          "1",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      MaterialButton(
                                        color: Colors.lightBlue,
                                        onPressed: () {},
                                        child: Text(
                                          "Next",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RaisedButton(
                                color: Colors.lightBlue,
                                child: Text(
                                  "COPY",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {},
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              RaisedButton(
                                color: Colors.lightBlue,
                                child: Text(
                                  "EXCEL",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {},
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget normalText(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.08,
      child: Text(
        name,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        //maxLines: 2,
      ),
    );
  }

  Widget numbers(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.02,
      child: Text(
        name,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _addButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      child: MaterialButton(
        // minWidth: MediaQuery.of(context).size.width * 0.10,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddRules()));
        },
        height: 50,
        // elevation: 10,
        // padding: EdgeInsets.symmetric(vertical: 10),
        color: Colors.lightBlue.shade300,
        child: Row(
          children: [
            Icon(
              Icons.navigation,
              color: Colors.white,
            ),
            Text(
              "Add Rules",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
