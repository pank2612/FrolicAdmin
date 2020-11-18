import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:frolicsports/constants/date_And_time.dart';
import 'package:frolicsports/models/sportsModel.dart';
import 'package:frolicsports/modules/contest/contestScreen.dart';
import 'package:frolicsports/modules/latest.dart';
import 'package:frolicsports/modules/manage/manageSpecialRules/manageSpecialRules.dart';
import 'package:frolicsports/modules/manage/manage_Sports/manageSports.dart';
import 'package:frolicsports/modules/manage/manage_players/managePlayer.dart';
import 'package:frolicsports/modules/manage/manage_rules/manageRules.dart';
import 'package:frolicsports/modules/manage/manage_skills/manageSkills.dart';
import 'package:frolicsports/modules/manage/manage_team/manageTeam.dart';
import 'package:frolicsports/modules/matches/matchScreen.dart';
import 'package:frolicsports/modules/prize/prizeScreen.dart';
import 'package:frolicsports/modules/scores/ScoreScreen.dart';
import 'package:frolicsports/modules/tournament/add_tournament.dart';
import 'package:frolicsports/modules/tournament/tournamentScreen.dart';
import 'package:frolicsports/services/getSports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/services/torunaments.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _listTile(String name, [IconData icon, Widget function]) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => function));
      },
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: Container(
        color: Colors.blueGrey.shade800,
        child: ListView(
//          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 18,
            ),
            _listTile("GENERAL"),
            _listTile("IPL2020", Icons.email, Latest()),
            ExpansionTile(
              title: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                title: Text(
                  "Manage",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
              children: [
                _listTile("Manage players", null, ManagePlayerScreen()),
                _listTile("Manage teams", null, ManageTeamScreen()),
                _listTile("Manage sports", null, ManageSportsScreen()),
                _listTile("Manage skills", null, ManageSkillsScreen()),
                _listTile("Manage rules", null, ManageRulesScreen()),
                _listTile("Special rules", null, ManageSpecialRulesScreen())
              ],
            ),
            _listTile("Tournaments", Icons.email, TournamentScreen()),
            _listTile("Matches", Icons.email, MatchScreen()),
            _listTile("Scores", Icons.email, ScoreScreen()),
            _listTile("Contest", Icons.email, ContestScreen()),
            _listTile("Prize", Icons.email, PrizeScreen()),
            _listTile("Sign Out", Icons.email),
          ],
        ),
      ),
    );
  }

  Image image;
  Future<Uri> downloadUrl() {
    return fb
        .storage()
        .refFromURL('gs://frolicsports-39c94.appspot.com')
        .child("FrolicSports/ronnie.jpg")
        .getDownloadURL();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    GetPostTournaments get = GetPostTournaments();
//    get.getTournaments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(),
      appBar: AppBar(),
      body: Column(
        children: [
//          BasicDateTimeField(),
//          BasicDateTimeField(),
//          BasicDateField(),
//          BasicTimeField(),
//          Container(
//            width: 200,
//            height: 200,
//            child: FutureBuilder(
//              future: downloadUrl(),
//              builder: (context, snapShot) {
//                if (snapShot.connectionState == ConnectionState.waiting) {
//                  return Container(
//                      alignment: Alignment.centerLeft,
//                      width: 120,
//                      height: 120,
//                      child: CircleAvatar(child: CircularProgressIndicator()));
//                } else if (!snapShot.hasData) {
//                  return Container(
//                    alignment: Alignment.centerLeft,
//                    width: 120,
//                    height: 120,
//                    child: CircleAvatar(
//                      backgroundColor: Colors.red,
//                      child: Image.network(snapShot.data.toString()),
//                    ),
//                  );
//                } else if (snapShot.hasData) {
//                  return Container(
//                    alignment: Alignment.centerLeft,
//                    width: 120,
//                    height: 120,
//                    child: CircleAvatar(
//                      child: Image.network(snapShot.data.toString()),
//                    ),
//                  );
//                }
//                return null;
//              },
//            ),
//            //       child: Center(child: image != null ? image : Text('No data...')),
////        child: StreamBuilder(
////          stream: Firestore.instance.collection("users").snapshots(),
////          builder: (context, snapShot) {
////            if (snapShot.hasError) {
////              return Text("error");
////            } else if (snapShot.data == null) {
////              return Text("No Data");
////            } else {
////              return ListView.builder(
////                itemCount: 2,
////                itemBuilder: (context, index) {
////                  return Text(
////                      snapShot.data.documents[index]["name"].toString());
////                },
////              );
////            }
////          },
////        ),
//          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.open_in_browser),
        onPressed: () async {
          final _image = await FlutterWebImagePicker.getImage;
          setState(() {
            image = _image;
          });
        },
      ),
    );
  }
}
