import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/models/sportsModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/modules/tournament/add_tournament.dart';
import 'package:frolicsports/screens/homeScreen.dart';
import 'package:frolicsports/services/getSports.dart';
import 'package:frolicsports/services/torunaments.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase/firebase.dart' as fb;

class TournamentScreen extends StatefulWidget {
  @override
  _TournamentScreenState createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    getSportData();
    getTournamentData();
  }

  SportsModelList sportsModelList = SportsModelList();
  GetSports getSports = GetSports();
  getSportData() async {
    sportsModelList = await getSports.getSports1();
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.push(
          context, MaterialPageRoute(builder: (context) => new HomeScreen())),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.001,
              left: MediaQuery.of(context).size.width * 0.001,
              top: MediaQuery.of(context).size.height * 0.02,
              bottom: MediaQuery.of(context).size.height * 0.02),
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
                                    "TOURNAMENT",
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
                                  normalText("Sport"),
                                  normalText("Name"),
                                  normalText("Description"),
                                  normalText("Start"),
                                  normalText("End"),
                                  normalText("LOGO"),
                                  normalText("Max Point"),
                                  normalText("Max Player"),
                                  normalText("Max Players In Single Team"),
                                  normalText("Deadlines"),
                                  normalText("Country"),
                                  normalText("Action")
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
                                        TournamentModel tournamentModel =
                                            tournamentModelList
                                                .tournamentModel[index];
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
                                                  numbers("${index + 1}"),
                                                  normalText(getName(
                                                      tournamentModel
                                                          .sportsId)),
                                                  normalText(tournamentModel
                                                      .name
                                                      .toString()),
                                                  normalText(tournamentModel
                                                          .description
                                                          .toString() ??
                                                      " "),
                                                  normalText(tournamentModel
                                                          .startDate
                                                          .toString() ??
                                                      " "),
                                                  normalText(tournamentModel
                                                          .endDate
                                                          .toString() ??
                                                      " "),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.08,
                                                      child: StreamBuilder(
                                                        stream: downloadUrl(
                                                                // "FrolicSports/Tournaments/ronnie.jpg"
                                                                tournamentModel
                                                                    .name,
                                                                tournamentModel
                                                                    .logo
                                                                    .toString())
                                                            .asStream(),
                                                        builder: (context,
                                                            snapShot) {
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
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 30,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                child: Image.network(
                                                                    "https://upload.wikimedia.org/wikipedia/commons"
                                                                    "/thumb/d/d1/Icons8_flat_businessman.svg/768"
                                                                    "px-Icons8_flat_businessman.svg.png"),
//                                                              child: Image.network(
//                                                                  snapShot.data
//                                                                      .toString()),
                                                              ),
                                                            );
                                                          } else if (snapShot
                                                              .hasData) {
                                                            return Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              width: 20,
                                                              height: 160,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                radius: 30,
                                                                child: Image
                                                                    .network(
                                                                  snapShot.data
                                                                      .toString(),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          return null;
                                                        },
                                                      )),
                                                  normalText(tournamentModel
                                                          .maxPoints
                                                          .toString() ??
                                                      " "),
                                                  normalText(tournamentModel
                                                          .maxPlayers
                                                          .toString() ??
                                                      " "),
                                                  normalText(tournamentModel
                                                          .maxSingleTeam
                                                          .toString() ??
                                                      " "),
                                                  normalText(tournamentModel
                                                          .deadlineSeconds
                                                          .toString() ??
                                                      " "),
                                                  normalText(tournamentModel
                                                          .country
                                                          .toString() ??
                                                      " "),
                                                  USER_TYPE == "admin"
                                                      ? Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.08,
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .red
                                                                    .shade700,
                                                              ),
                                                              IconButton(
                                                                onPressed: () {
                                                                  tourIndex =
                                                                      index + 1;
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => AddTournament(
                                                                                edit: "edit",
                                                                                tournamentModel: editData(),
                                                                              )));
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .mode_edit,
                                                                  color: Colors
                                                                      .orange,
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
                                      itemCount:
                                          //  2
                                          tournamentModelList.tournamentModel ==
                                                  null
                                              ? 0
                                              : tournamentModelList
                                                  .tournamentModel.length,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              SizedBox(
                                width: 10,
                              ),
                              RaisedButton(
                                color: Colors.lightBlue,
                                child: Text(
                                  "EXCEL",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  copyExcel();
                                },
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

  copyExcel() {
    print("Excel");
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['tournamentScreen'];
    CellStyle cellStyle = CellStyle(
        backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));

    cellStyle.underline = Underline.Single; // or Underline.Double

    var cell = sheetObject.cell(CellIndex.indexByString("A1"));
    cell.value = 8; // dynamic values support provided;
    cell.cellStyle = cellStyle;

    // printing cell-type
    print("CellType: " + cell.cellType.toString());
    excel.copy("tournamentScreen", "toSheet");
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
      width: MediaQuery.of(context).size.width * 0.01,
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
                  builder: (context) => AddTournament(
                        edit: "add",
                        tournamentModel: editData(),
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
              "Add Tournament",
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

  int tourIndex;
  TournamentModel editData() {
    TournamentModel tournamentModel = TournamentModel();
    tournamentModelList.tournamentModel.forEach((element) {
      if (tourIndex == element.id) {
        tournamentModel = element;
        print("data is ${element.name}");
      }
    });
    return tournamentModel;
  }

  String getName(int Id) {
    String sportsName = "";
    sportsModelList.sportsModel.forEach((sports) {
      if (sports.id == Id) {
        sportsName = sports.name;
      }
    });
    return sportsName;
  }

  Future<Uri> downloadUrl(String name, String photoUrl) {
    return fb
        .storage()
        .refFromURL(REF_FROM_URL)
        .child("$STORAGE_FOLDER_TOURNAMENT${name}/$photoUrl")
        .getDownloadURL();
  }
}
