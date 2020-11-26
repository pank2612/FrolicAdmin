import 'package:flutter/material.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/models/teamsModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/modules/manage/manage_team/addTeams.dart';
import 'package:frolicsports/screens/homeScreen.dart';
import 'package:frolicsports/services/teamsServices.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:frolicsports/services/torunaments.dart';

class ManageTeamScreen extends StatefulWidget {
  @override
  _ManageTeamScreenState createState() => _ManageTeamScreenState();
}

class _ManageTeamScreenState extends State<ManageTeamScreen> {
  bool _loading;
  TeamsModelList teamsModelList = TeamsModelList();
  GetPostTeams getTeam = GetPostTeams();
  getTeamsData() async {
    teamsModelList = await getTeam.getTeams();
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    getTeamsData();
    getTournamentData();
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
                                    "TEAMS",
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
                                  normalText("Tournament"),
                                  normalText("Name"),
                                  normalText("Short Code"),
                                  normalText("LOGO"),
                                  normalText("Action"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  TeamsModel teamsModel = TeamsModel();
                                  teamsModel = teamsModelList.teamsModel[index];
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 2),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            numbers(teamsModel.id.toString()),
                                            normalText(getName(
                                                teamsModel.tournamentId)),
                                            normalText(
                                                teamsModel.name.toString()),
                                            normalText(teamsModel.shortName
                                                .toString()),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08,
                                                child: StreamBuilder(
                                                  stream: downloadUrl(
                                                          // "FrolicSports/Tournaments/ronnie.jpg"
                                                          teamsModel.name,
                                                          teamsModel.logo
                                                              .toString())
                                                      .asStream(),
                                                  builder: (context, snapShot) {
//                                                        print(
//                                                            "logo is ${sportsModel.logo.length}");
                                                    if (snapShot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          width: 120,
                                                          height: 120,
                                                          // color: Colors.transparent,
                                                          child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              child:
                                                                  CircularProgressIndicator()));
                                                    } else if (!snapShot
                                                        .hasData) {
                                                      return Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        width: 200,
                                                        height: 200,
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          child: CircleAvatar(
                                                            child: Image.network(
                                                                "https://upload.wikimedia.org/wikipedia/commons"
                                                                "/thumb/d/d1/Icons8_flat_businessman.svg/768"
                                                                "px-Icons8_flat_businessman.svg.png"),
                                                          ),
//                                                              child: Image.network(
//                                                                  snapShot.data
//                                                                      .toString()),
                                                        ),
                                                      );
                                                    } else if (snapShot
                                                        .hasData) {
                                                      return Container(
                                                        width: 20,
                                                        height: 60,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: CircleAvatar(
                                                          radius: 35,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          child: Image.network(
                                                            snapShot.data
                                                                .toString(),
                                                            fit: BoxFit.fill,
//                                                          height: 100,
//                                                          width: 100,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    return null;
                                                  },
                                                )),
                                            USER_TYPE == "admin"
                                                ? Container(
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
                                                            teamIndex =
                                                                index + 1;
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AddTeams(
                                                                              teamsModel: editData(),
                                                                              edit: "edit",
                                                                            )));
                                                          },
                                                          icon: Icon(
                                                            Icons.mode_edit,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                        )
                                                      ],
                                                    ))
                                                : Text(""),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      )
                                    ],
                                  );
                                },
                                itemCount: teamsModelList.teamsModel == null
                                    ? 0
                                    : teamsModelList.teamsModel.length,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

  int teamIndex;
  TeamsModel editData() {
    TeamsModel teamsModel = TeamsModel();
    teamsModelList.teamsModel.forEach((element) {
      if (teamIndex == element.id) {
        teamsModel = element;
        print("data is ${element.name}");
      }
    });
    return teamsModel;
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
              context,
              MaterialPageRoute(
                  builder: (context) => AddTeams(
                        edit: "add",
                        teamsModel: editData(),
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
              "Add Team",
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

  Future<Uri> downloadUrl(String name, String photoUrl) {
    return fb
        .storage()
        .refFromURL(REF_FROM_URL)
        .child("$STORAGE_FOLDER_TOURNAMENT${name}/$photoUrl")
        .getDownloadURL();
  }
}
