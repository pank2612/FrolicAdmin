import 'package:flutter/material.dart';
import 'package:frolicsports/models/contestsModel.dart';
import 'package:frolicsports/models/matchesModel.dart';
import 'package:frolicsports/models/teamsModel.dart';
import 'package:frolicsports/modules/contest/add_contest.dart';
import 'package:frolicsports/screens/homeScreen.dart';
import 'package:frolicsports/services/contestsServices.dart';
import 'package:frolicsports/services/matchesServices.dart';
import 'package:frolicsports/services/teamsServices.dart';

class ContestScreen extends StatefulWidget {
  @override
  _ContestScreenState createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {
  bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    getContestsData();
    getMatchesData();
    getTeamsData();
  }

  ContestsModelList contestsModelList = ContestsModelList();
  GetPostContest getContest = GetPostContest();
  getContestsData() async {
    contestsModelList = await getContest.getContests();
    setState(() {
      _loading = false;
    });
  }

  TeamsModelList teamsModelList = TeamsModelList();
  GetPostTeams getPostTeams = GetPostTeams();
  getTeamsData() async {
    teamsModelList = await getPostTeams.getTeams();
    setState(() {
      _loading = false;
    });
  }

  String getName(int Id) {
    String matchName = "";
    String team1Name = '';
    String team2Name = '';
    matchesModelList.matchesModel.forEach((match) {
      if (match.id == Id) {
        //matchName = match.name;
        teamsModelList.teamsModel.forEach((team) {
          if (team.id == match.team1Id) {
            team1Name = team.shortName;
          }
          if (team.id == match.team2Id) {
            team2Name = team.shortName;
          }
        });
        matchName = team1Name + " v/s " + team2Name;
      }
    });
    return matchName;
  }

  MatchesModelList matchesModelList = MatchesModelList();
  GetPostMatches getPostMatches = GetPostMatches();
  getMatchesData() async {
    matchesModelList = await getPostMatches.getMatches();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => Navigator.push(
          context, MaterialPageRoute(builder: (context) => new HomeScreen())),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.07,
              left: MediaQuery.of(context).size.width * 0.07,
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
                                    left: MediaQuery.of(context).size.width *
                                        0.20),
                                child: Text("Search:",
                                    style: TextStyle(
                                      fontSize: 17,
                                    )),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "CONTEST",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.lightBlue),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.112,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
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
                                  top: MediaQuery.of(context).size.height *
                                      0.115),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.08,
                              color: Colors.grey.shade300,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  numbers("#"),
                                  normalText("Match"),
                                  normalText("Name"),
                                  normalText("Entry Amount"),
                                  normalText("Max Entries"),
                                  normalText("Max Entries/Users"),
                                  normalText("Contest Category"),
                                  normalText("Action"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: _loading == true
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      itemBuilder: (context, index) {
                                        ContestsModel contestModel =
                                            ContestsModel();
                                        contestModel = contestsModelList
                                            .contestsModel[index];
                                        return Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 2),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  numbers(contestModel.id
                                                      .toString()),
                                                  normalText(getName(
                                                      contestModel.matchId)),
                                                  normalText(contestModel.name
                                                      .toString()),
                                                  normalText(contestModel
                                                      .entryAmount
                                                      .toString()),
                                                  normalText(contestModel
                                                      .maxEntries
                                                      .toString()),
                                                  normalText(contestModel
                                                      .maxEntriesPerUser
                                                      .toString()),
                                                  normalText(contestModel
                                                      .contestCategory
                                                      .toString()),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.08,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.close,
                                                            color: Colors
                                                                .red.shade700,
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              contestIndex =
                                                                  index + 1;
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          AddContest(
                                                                            edit:
                                                                                "edit",
                                                                            contestsModel:
                                                                                editData(),
                                                                          )));
                                                            },
                                                            icon: Icon(
                                                              Icons.mode_edit,
                                                              color:
                                                                  Colors.orange,
                                                            ),
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
                                      itemCount:
                                          contestsModelList.contestsModel ==
                                                  null
                                              ? 0
                                              : contestsModelList
                                                  .contestsModel.length,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Showing 1 to 3 of 3 entries"),
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

  int contestIndex;
  ContestsModel editData() {
    ContestsModel contestsModel = ContestsModel();
    contestsModelList.contestsModel.forEach((element) {
      if (contestIndex == element.id) {
        contestsModel = element;
        print("data is ${element.name}");
      }
    });
    return contestsModel;
  }

  _addButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      child: MaterialButton(
        // minWidth: MediaQuery.of(context).size.width * 0.10,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddContest(
                        edit: "add",
                        contestsModel: editData(),
                      )));
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
              "Add Contest",
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

  Widget normalText(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.0755,
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
}
