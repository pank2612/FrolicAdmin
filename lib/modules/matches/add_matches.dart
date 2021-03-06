import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frolicsports/constants/textField.dart';
import 'package:frolicsports/models/matchesModel.dart';
import 'package:frolicsports/models/teamsModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/modules/matches/matchScreen.dart';
import 'package:frolicsports/services/matchesServices.dart';
import 'package:frolicsports/services/teamsServices.dart';
import 'package:frolicsports/services/torunaments.dart';
import 'package:intl/intl.dart';

class AddMatches extends StatefulWidget {
  String edit;
  MatchesModel matchesModel;
  AddMatches({this.edit, this.matchesModel});
  @override
  _AddMatchesState createState() => _AddMatchesState();
}

class _AddMatchesState extends State<AddMatches> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _venueController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _scoreController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  Widget textFieldWithText(String name, TextEditingController controller,
      [ValidationKey inputValidate,
      TextInputType keyboardType,
      String hintText]) {
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
              hintText: hintText,
              controller: controller,
              keyboardType: keyboardType,
              inputValidate: inputValidate,
              maxline: 1,
              obscureText: false),
        )
      ],
    );
  }

  dropDownTournament(
      {List<TournamentModel> categories,
      String selectedCategory,
      String name}) {
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
            child: _loading == true
                ? Center(child: CircularProgressIndicator())
                : Container(
                    width: MediaQuery.of(context).size.width * 0.96,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.grey.shade600),
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
                                  'SELECT TOURNAMENT',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                items: _tournamentList.map((tour) {
                                  return new DropdownMenuItem(
                                      value: tour.id.toString(),
                                      child: Text(
                                        tour.name,
                                        style: TextStyle(color: Colors.black),
                                      ));
                                }).toList(),
                                onChanged: (newValue) {
                                  // do other stuff with _category
                                  setState(() {
                                    selectedCategory = newValue;
                                    _tourName = newValue;
                                    print("selected value $_tourName");
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

  String _tourName;
  dropDownTeams1(
      {List<TeamsModel> categories, String selectedCategory, String name}) {
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
            child: _loading == true
                ? Center(child: CircularProgressIndicator())
                : Container(
                    width: MediaQuery.of(context).size.width * 0.96,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.grey.shade600),
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
                                  'SELECT TEAMS',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                items: _teamList.map((team) {
                                  return new DropdownMenuItem(
                                      value: team.id.toString(),
                                      child: Text(
                                        team.name,
                                        style: TextStyle(color: Colors.black),
                                      ));
                                }).toList(),
                                onChanged: (newValue) {
                                  // do other stuff with _category
                                  setState(() {
                                    selectedCategory = newValue;
                                    _team1 = newValue;
                                    print("selected value $_team1");
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

  dropDownTeams2(
      {List<TeamsModel> categories, String selectedCategory, String name}) {
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
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: _loading == true
                      ? Center(child: CircularProgressIndicator())
                      : DropdownButton<String>(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            size: 40,
                            color: Colors.black,
                          ),
                          //dropdownColor: Colors.white,
                          elevation: 5,
                          hint: Text(
                            'SELECT TEAM',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          items: _teamList.map((team) {
                            return new DropdownMenuItem(
                                value: team.id.toString(),
                                child: Text(
                                  team.name,
                                  style: TextStyle(color: Colors.black),
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            // do other stuff with _category
                            setState(() {
                              selectedCategory = newValue;
                              _team2 = newValue;
                              print("selected value $_team2");
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

  String _team1;
  String _team2;
  bool _loading;
  GetPostMatches getPostMatches = GetPostMatches();
  postMatchesData() {
    MatchesModel matchesModel = MatchesModel();
    getPostMatches.postMatches(
      matchesModelObject: matchesModel,
    );
  }

  List<TournamentModel> _tournamentList;
  GetPostTournaments getPostTournaments = GetPostTournaments();
  getTournamentData() async {
    //tournamentModelList = await getPostTournaments.getTournaments();
    getPostTournaments.getTournaments().then((tournament) {
      setState(() {
        _tournamentList = tournament.tournamentModel;
        setState(() {
          _loading = false;
        });
      });
    });
  }

  List<TeamsModel> _teamList;
  // TeamsModelList teamsModelList = TeamsModelList();
  GetPostTeams getPostTeams = GetPostTeams();
  getTeamsData() async {
    await getPostTeams.getTeams().then((teams) {
      setState(() {
        _teamList = teams.teamsModel;
        _loading = false;
      });
    });
  }

  postMatchData() async {
    MatchesModel matchesModel = MatchesModel(
        startDate: startDateAndTime,
        description: _descriptionController.text,
        score: _scoreController.text,
        number: int.parse(_numberController.text),
        tournamentId: int.parse(_tourName),
        team1Id: int.parse(_team1),
        team2Id: int.parse(_team2),
        venue: _venueController.text);
    await getPostMatches.postMatches(matchesModelObject: matchesModel);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    if (widget.matchesModel.description != "" &&
        widget.matchesModel.description != null) {
      _numberController =
          TextEditingController(text: widget.matchesModel.number.toString());
      _descriptionController =
          TextEditingController(text: widget.matchesModel.description);
      _venueController =
          TextEditingController(text: "${widget.matchesModel.venue}");
      _scoreController =
          TextEditingController(text: widget.matchesModel.score.toString());
      _startDateController =
          TextEditingController(text: widget.matchesModel.startDate.toString());
    }
    getTournamentData();
    getTeamsData();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => Navigator.push(
          context, MaterialPageRoute(builder: (context) => new MatchScreen())),
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
                      "ADD MATCH",
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
                        dropDownTournament(
                            categories: _tournamentList,
                            selectedCategory: _tourName,
                            name: "SELECT TOURNAMENT"),
//                        textFieldWithText(
//                          "TITLE",
//                          _titleController,
//                          ValidationKey.title,
//                          TextInputType.text,
//                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithText(
                            "Description",
                            _descriptionController,
                            ValidationKey.Description,
                            TextInputType.text,
                            widget.edit == "edit"
                                ? widget.matchesModel.description.toString()
                                : ""),
                        textFieldWithText(
                            "Venue",
                            _venueController,
                            ValidationKey.venue,
                            TextInputType.text,
                            widget.edit == "edit"
                                ? widget.matchesModel.venue.toString()
                                : "")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithDateTime(
                            "Start Date", startDateAndTimeField()),
                        //textFieldWithText("End Date", _endDateController)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dropDownTeams1(
                            categories: _teamList,
                            selectedCategory: _team1,
                            name: "TEAM1"),
                        dropDownTeams2(
                            categories: _teamList,
                            selectedCategory: _team2,
                            name: "TEAM2")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithText(
                            "Number",
                            _numberController,
                            ValidationKey.number,
                            TextInputType.number,
                            widget.edit == "edit"
                                ? widget.matchesModel.number.toString()
                                : ""),
                        textFieldWithText(
                            "Score",
                            _scoreController,
                            ValidationKey.score,
                            TextInputType.number,
                            widget.edit == "edit"
                                ? widget.matchesModel.score.toString()
                                : "")
                      ],
                    ),
                    widget.edit == "edit"
                        ? RaisedButton(
                            color: Colors.lightBlue,
                            child: Text("EDIT"),
                            onPressed: () {
                              _editMatch();
                            },
                          )
                        : RaisedButton(
                            color: Colors.lightBlue,
                            child: Text("Submit"),
                            onPressed: () {
                              _submit();
                            },
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

  void showDialog(String name) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(name),
    ));
  }

  var startDateAndTime;
  Widget startDateAndTimeField() {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    return Container(
      child: DateTimeField(
        controller: _startDateController,
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()));
            final dateTime = DateTimeField.combine(date, time);
            startDateAndTime = dateTime;
            print('dateTime${dateTime}');
            return dateTime;
          } else {
            return currentValue;
          }
        },
      ),
    );
  }

  Widget textFieldWithDateTime(String name, Widget function) {
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
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade600),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: function,
        )
      ],
    );
  }

  _editMatch() {
    if (_tourName == null) {
      showDialog("Please select Tournament");
      return;
    }
//    if (_startDateController.text == null && startDateAndTime == null) {
//      showDialog("Please select Start Date");
//      return;
//    }
//    if (endDateAndTime == null) {
//      showDialog("Please select End Date");
//      return;
//    }
    if (_team1 == null) {
      showDialog("Please select Team1");
      return;
    }
    if (_team2 == null) {
      showDialog("Please select Team2");
      return;
    }

    if (_formKey.currentState.validate()) {
      MatchesModel matchesModel = MatchesModel(
          startDate: startDateAndTime == null
              ? widget.matchesModel.startDate
              : startDateAndTime,
          description: _descriptionController.text == null
              ? widget.matchesModel.description
              : _descriptionController.text,
          score: _scoreController.text == null
              ? widget.matchesModel.score
              : _scoreController.text,
          number: int.parse(_numberController.text) == null
              ? widget.matchesModel.number
              : int.parse(_numberController.text),
          tournamentId: int.parse(_tourName) == null
              ? widget.matchesModel.tournamentId
              : int.parse(_tourName),
          team1Id: int.parse(_team1) == null
              ? widget.matchesModel.team1Id
              : int.parse(_team1),
          team2Id: int.parse(_team2) == null
              ? widget.matchesModel.team2Id
              : int.parse(_team2),
          venue: _venueController.text == null
              ? widget.matchesModel.venue
              : _venueController.text,
          id: widget.matchesModel.id);
      getPostMatches.editMatches(matchesModelObject: matchesModel);
    }
  }

  List matchName = [];
  _submit() {
    if (_tourName == null) {
      showDialog("Please select Tournament");
      return;
    }
    if (startDateAndTime == null) {
      showDialog("Please select Start Date");
      return;
    }
    if (_team1 == null) {
      showDialog("Please select Team1");
      return;
    }
    if (_team2 == null) {
      showDialog("Please select Team2");
      return;
    }

    if (_formKey.currentState.validate()) {
//      _tournamentList.forEach((element) {
//        matchName.add(element.name);
//      });
//      matchName.contains(_titleController.text)
//          ? Fluttertoast.showToast(
//              msg: "This title already created",
//              gravity: ToastGravity.CENTER_LEFT,
//              timeInSecForIosWeb: 2)
//          :
      valid();
    }
  }

  valid() {
    postMatchData();
    Fluttertoast.showToast(
      msg: "Added Successfully",
      gravity: ToastGravity.CENTER_LEFT,
      timeInSecForIosWeb: 2,
    );
  }
}
