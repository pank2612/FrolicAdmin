import 'package:flutter/material.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/models/playersModel.dart';
import 'package:frolicsports/models/teamsModel.dart';
import 'package:frolicsports/modules/manage/manage_players/addPlayer.dart';
import 'package:frolicsports/services/playersServices.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:frolicsports/services/teamsServices.dart';

class ManagePlayerScreen extends StatefulWidget {
  @override
  _ManagePlayerScreenState createState() => _ManagePlayerScreenState();
}

class _ManagePlayerScreenState extends State<ManagePlayerScreen> {
  bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    getPlayersData();
    getTeamsData();
    //get();
  }

  PlayersModelList playersModelList = PlayersModelList();
  GetPostPlayers getPlayers = GetPostPlayers();
  getPlayersData() async {
    playersModelList = await getPlayers.getPlayers();
    //getTournamentData();
    setState(() {
      _loading = false;
    });
  }

  TeamsModelList teamsModelList = TeamsModelList();
  GetPostTeams getPostTeams = GetPostTeams();
  getTeamsData() async {
    teamsModelList = await getPostTeams.getTeams();
    //getTournamentData();
    //get();
    setState(() {
      _loading = false;
    });
  }

  String getName(int Id) {
    String teamName = "";
    teamsModelList.teamsModel.forEach((team) {
      if (team.id == Id) {
        //matchName = match.name;
        teamName = team.name;
      }
    });
    return teamName;
  }

  List teamName;
  var id;
  get() {
    print("sdfghj");
    teamsModelList.teamsModel.map((e) {
      print("sdfghjjjjjj");
      id = e.id;
      teamName.add(id);
      if (e.id == id) {
        print("data is ${e.name}");
        print("data is ${e.id}");
      }
    });
    teamName.map((e) {
      print("Data is ${e.toString()}");
    });
//    playersModelList.playersModel.forEach((player) {
//      teamsModelList.teamsModel.forEach((team) {
//        if (player.teamId == team.id) {
//          teamName.add(team.name.toString());
//          print("Data is ${team.name}");
//          print("Data is ${teamName.length}");
//        }
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.07,
            left: MediaQuery.of(context).size.width * 0.07,
            top: MediaQuery.of(context).size.height * 0.07,
            bottom: MediaQuery.of(context).size.height * 0.07),
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
                                  "PLAYERS",
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
                                normalText("Team"),
                                normalText("Name"),
                                normalText("Status"),
                                normalText("Nike Name"),
                                normalText("Skill"),
                                normalText("Credits"),
                                normalText("Points"),
                                normalText("DP"),
                                normalText("Country"),
                                normalText("Action")
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                PlayersModel playersModel = PlayersModel();
                                playersModel =
                                    playersModelList.playersModel[index];
                                //id = playersModel.teamId;
                                //get();
//                                TeamsModel teamsModel = TeamsModel();
//                                teamsModel = teamsModelList.teamsModel[index];
//                                var name;
//                                if (teamsModel.id == playersModel.teamId) {
//                                  print("Data is ${teamsModel.name}");
//                                  print("Data is ${teamsModel.id.bitLength}");
//                                  print("Data is ${playersModel.teamId}");
//                                  name = teamsModel.name;
//                                }
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
                                              // teamName[0].toString()
                                              //name.toString()
                                              getName(playersModel.teamId)),
                                          normalText(
                                              playersModel.name.toString()),
                                          normalText(
                                              playersModel.status.toString()),
                                          normalText(playersModel.shortName
                                              .toString()),
                                          normalText(
                                              playersModel.skillsId.toString()),
                                          normalText(
                                              playersModel.credits.toString()),
                                          normalText(
                                              playersModel.points.toString()),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              child: StreamBuilder(
                                                stream: downloadUrl(
                                                        // "FrolicSports/Tournaments/ronnie.jpg"
                                                        playersModel.name,
                                                        playersModel.picture
                                                            .toString())
                                                    .asStream(),
                                                builder: (context, snapShot) {
//                                                        print(
//                                                            "logo is ${sportsModel.logo.length}");
                                                  if (snapShot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        width: 120,
                                                        height: 120,
                                                        child: CircleAvatar(
                                                            child:
                                                                CircularProgressIndicator()));
                                                  } else if (!snapShot
                                                      .hasData) {
                                                    return Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width: 200,
                                                      height: 200,
                                                      child: CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        child: CircleAvatar(
                                                          child: Image.network(
                                                              "https://upload.wikimedia.org/wikipedia/commons"
                                                              "/thumb/d/d1/Icons8_flat_businessman.svg/768px-Icons8_flat_businessman.svg.png"),
                                                        ),
//                                                              child: Image.network(
//                                                                  snapShot.data
//                                                                      .toString()),
                                                      ),
                                                    );
                                                  } else if (snapShot.hasData) {
                                                    return Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width: 150,
                                                      height: 150,
                                                      child: CircleAvatar(
                                                        radius: 30,
                                                        child: Image.network(
                                                          snapShot.data
                                                              .toString(),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  return null;
                                                },
                                              )),
                                          normalText(
                                              playersModel.country.toString()),
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
                              itemCount: playersModelList.playersModel == null
                                  ? 0
                                  : playersModelList.playersModel.length,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Showing 1 to 4 of 4 entries"),
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

  Future<Uri> downloadUrl(String name, String photoUrl) {
    return fb
        .storage()
        .refFromURL(REF_FROM_URL)
        .child("$STORAGE_FOLDER_TOURNAMENT${name}/$photoUrl")
        .getDownloadURL();
  }

  Widget _addButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      child: MaterialButton(
        // minWidth: MediaQuery.of(context).size.width * 0.10,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPlayer()));
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
              "Add Player",
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
