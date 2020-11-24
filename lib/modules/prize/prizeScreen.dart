import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frolicsports/models/contestsModel.dart';
import 'package:frolicsports/models/prizeModel.dart';
import 'package:frolicsports/modules/prize/addPrize.dart';
import 'package:frolicsports/screens/homeScreen.dart';
import 'package:frolicsports/services/contestsServices.dart';
import 'package:frolicsports/services/prizeServices.dart';

class PrizeScreen extends StatefulWidget {
  @override
  _PrizeScreenState createState() => _PrizeScreenState();
}

class _PrizeScreenState extends State<PrizeScreen> {
  bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    getPrizeData();
    getContestsData();
  }

  PrizeModelList prizeModelList = PrizeModelList();
  GetPostPrize getPostPrize = GetPostPrize();
  getPrizeData() async {
    prizeModelList = await getPostPrize.getPrize();
    setState(() {
      _loading = false;
    });
  }

  ContestsModelList contestsModelList = ContestsModelList();
  GetPostContest getContest = GetPostContest();
  getContestsData() async {
    contestsModelList = await getContest.getContests();
    getContestList();
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
                                    "PRIZE",
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
                                  normalText("ContestId"),
                                  normalText("RankRangeStart"),
                                  normalText("RankRangeEnd"),
                                  normalText("Amount"),
                                  normalText("Status"),
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
                                        PrizeModel prizeModel = PrizeModel();
                                        prizeModel =
                                            prizeModelList.prizeModel[index];
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
                                                      prizeModel.contestId)),
                                                  normalText(prizeModel
                                                      .rankRangeStart
                                                      .toString()),
                                                  normalText(prizeModel
                                                      .rankRangeEnd
                                                      .toString()),
                                                  normalText(prizeModel.amount
                                                      .toString()),
                                                  normalText(prizeModel.status
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
                                                          Icon(
                                                            Icons.mode_edit,
                                                            color:
                                                                Colors.orange,
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
                                      itemCount: prizeModelList.prizeModel ==
                                              null
                                          ? 0
                                          : prizeModelList.prizeModel.length,
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

  _addButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      child: MaterialButton(
        onPressed: () {
          _showDialogBox();
        },
        height: 50,
        color: Colors.lightBlue.shade300,
        child: Row(
          children: [
            Icon(
              Icons.navigation,
              color: Colors.white,
            ),
            Text(
              "SELECT CONTEST",
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

  List<ContestsModel> _contestList;
  String _contestId;
  getContestList() {
    _contestList = contestsModelList.contestsModel;
  }

  int maxEntriesPerUser;
  int maxEntries;
  int contestEntryAmount;
  ContestsModel contestData() {
    ContestsModel contestsModel = ContestsModel();
    _contestList.forEach((element) {
      if (int.parse(_contestId) == element.id) {
//        maxEntries = element.maxEntries;
//        maxEntriesPerUser = element.maxEntriesPerUser;
//        contestEntryAmount = element.entryAmount;
        contestsModel = element;
      }
    });
    return contestsModel;
  }

  List<PrizeModel> prizeList() {
    List<PrizeModel> listPrize = List<PrizeModel>();
    prizeModelList.prizeModel.forEach((element) {
      if (int.parse(_contestId) == element.contestId) {
        print("contest ${element.amount}");
        listPrize.add(element);
      }
    });
    return listPrize;
  }

  dropDownContest(
      {List<ContestsModel> categories, String selectedCategory, String name}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.30,
            padding: EdgeInsets.only(top: 8),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.96,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade600),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: DropdownButtonHideUnderline(
                child: _loading == true
                    ? Center(child: CircularProgressIndicator())
                    : ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            size: 40,
                            color: Colors.black,
                          ),
                          //dropdownColor: Colors.white,
                          elevation: 5,
                          hint: Text(
                            'SELECT CONTEST',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          items: _contestList.map((contest) {
                            return new DropdownMenuItem(
                                value: contest.id.toString(),
                                child: Text(
                                  contest.name,
                                  style: TextStyle(color: Colors.black),
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            // do other stuff with _category
                            setState(() {
                              selectedCategory = newValue;
                              _contestId = newValue;
                              print("selected value $_contestId");
                            });
                          },
                          value: selectedCategory,
                        ),
                      ),
              ),
            )),
      ],
    );
  }

  _showDialogBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Contest"),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            content: dropDownContest(
                categories: _contestList,
                selectedCategory: _contestId,
                name: "Contest Name"),
            actions: [
              Container(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MaterialButton(
                      child: Text(
                        "Add Prize",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        _contestId == null
                            ? Fluttertoast.showToast(
                                msg: "Please select Contest name",
                                gravity: ToastGravity.CENTER,
                              )
                            : sendData();
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  sendData() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddPrize(
                  contestsModel: contestData(),
                  prizeModel: prizeList(),
                )));
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

  String getName(int Id) {
    String contestName = "";
    contestsModelList.contestsModel.forEach((contest) {
      if (contest.id == Id) {
        //matchName = match.name;
        contestName = contest.name;
      }
    });
    return contestName;
  }
}
