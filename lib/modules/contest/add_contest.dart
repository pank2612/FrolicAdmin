import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frolicsports/constants/textField.dart';
import 'package:frolicsports/models/contestsModel.dart';
import 'package:frolicsports/models/matchesModel.dart';
import 'package:frolicsports/models/teamsModel.dart';
import 'package:frolicsports/modules/contest/contestScreen.dart';
import 'package:frolicsports/services/contestsServices.dart';
import 'package:frolicsports/services/matchesServices.dart';
import 'package:frolicsports/services/teamsServices.dart';

class AddContest extends StatefulWidget {
  @override
  _AddContestState createState() => _AddContestState();
}

class _AddContestState extends State<AddContest> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _entryAmountController = TextEditingController();
  TextEditingController _maxEntriesController = TextEditingController();
  TextEditingController _maxEntryPerUserController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _contestCategoryController = TextEditingController();
  Widget textFieldWithText(String name, TextEditingController controller,
      [ValidationKey inputValidate, TextInputType keyboardType]) {
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
        SizedBox(
          height: 6,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          child: textField(
              isIconShow: false,
              // hintText: name,
              controller: controller,
              keyboardType: keyboardType,
              inputValidate: inputValidate,
              maxline: 1,
              obscureText: false),
        )
      ],
    );
  }

  dropDownMatch(
      {List<MatchesModel> categories, String selectedCategory, String name}) {
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
            width: MediaQuery.of(context).size.width * 0.45,
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
                            'SELECT MATCH',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          items: _matchList.map((match) {
                            return new DropdownMenuItem(
                                value: match.id.toString(),
                                child: Text(
                                  getName(match.id),
                                  style: TextStyle(color: Colors.black),
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            // do other stuff with _category
                            setState(() {
                              selectedCategory = newValue;
                              _matchId = newValue;
                              print("selected value $_matchId");
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

  String _matchId;
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
    _matchList.forEach((match) {
      print("ID1 is  ${match.id}");
      print("ID2 is  $Id");
      if (match.id == Id) {
        print("I3 is  ${match.id}");
        print("ID4 is  $Id");
        //matchName = match.name;
        teamsModelList.teamsModel.forEach((team) {
          print("team1Name $team1Name");
          if (team.id == match.team1Id) {
            team1Name = team.shortName;
          }
          if (team.id == match.team2Id) {
            team2Name = team.shortName;
          }
          print("team2Name $team2Name");
        });
        matchName = team1Name + " v/s " + team2Name;
        print("matchName $matchName");
      }
    });
    return matchName;
  }

  GetPostContest getPostContest = GetPostContest();
  postContestsData() {
    ContestsModel contestsModel = ContestsModel(
        name: _titleController.text,
        contestCategory: _contestCategoryController.text,
        entryAmount: int.parse(_entryAmountController.text),
        maxEntries: int.parse(_maxEntriesController.text),
        maxEntriesPerUser: int.parse(_maxEntryPerUserController.text),
        matchId: int.parse(_matchId),
        status: isEnabled);
    getPostContest.postContests(
      contestModelObject: contestsModel,
    );
  }

  bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    getMatchesData();
    getContestData();
    getTeamsData();
  }

  List<ContestsModel> _contestList;
  List<String> contestName = [];
  getContestData() async {
    await getPostContest.getContests().then((contest) {
      contest.contestsModel.forEach((contest) {
        contestName.add(contest.name);
      });

      setState(() {
        _loading = false;
      });
    });
  }

  List<MatchesModel> _matchList;
  GetPostMatches getPostMatches = GetPostMatches();
  getMatchesData() async {
    await getPostMatches.getMatches().then((match) {
      _matchList = match.matchesModel;
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => Navigator.push(context,
          MaterialPageRoute(builder: (context) => new ContestScreen())),
      child: Scaffold(
        key: _scaffoldKey,
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ADD CONTEST",
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 20,
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //dropDown(),
                        dropDownMatch(
                            name: "Select Match",
                            selectedCategory: _matchId,
                            categories: _matchList),
                        textFieldWithText("TITLE", _titleController,
                            ValidationKey.title, TextInputType.text)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithText(
                            "Entry Amount",
                            _entryAmountController,
                            ValidationKey.entryAmount,
                            TextInputType.number),
                        textFieldWithText("Max Entries", _maxEntriesController,
                            ValidationKey.maxEntries, TextInputType.number)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithText(
                            "Max Entry Per User",
                            _maxEntryPerUserController,
                            ValidationKey.maxEntryPerUSer,
                            TextInputType.number),
                        textFieldWithText(
                            "Contest Category",
                            _contestCategoryController,
                            ValidationKey.name,
                            TextInputType.text)
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '$textValue',
                          style: TextStyle(fontSize: 20),
                        ),
                        Switch(
                          onChanged: toggleSwitch,
                          value: isSwitched,
                          activeColor: Colors.blue,
                          activeTrackColor: Colors.blue,
                          inactiveThumbColor: Colors.redAccent,
                          inactiveTrackColor: Colors.redAccent,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        RaisedButton(
                          onPressed: () {
                            _submit();
                          },
                          color: Colors.lightBlue,
                          child: Text("Submit"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isSwitched = false;
  int isEnabled = 0;
  var textValue = 'Status';
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isEnabled = 1;
        isSwitched = true;
        textValue = 'Status is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isEnabled = 0;
        isSwitched = false;
        textValue = 'Status is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  void showDialog(String name) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(name),
    ));
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      if (_maxEntryPerUserController.hashCode *
              _maxEntriesController.hashCode ==
          _entryAmountController.hashCode) {
        contestName.contains(_titleController.text)
            ? showDialog("This title already created")
            : valid();
      } else {
        showDialog("EntryAmount can't be less than multiple"
            " of max entry per user and total entry");
        print("asdfghjk");
      }
    }
  }

  valid() {
    postContestsData();
    showDialog("Added Successfully");
  }
}
