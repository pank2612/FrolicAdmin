import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/constants/date_And_time.dart';
import 'package:frolicsports/constants/textField.dart';
import 'package:frolicsports/models/sportsModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/modules/tournament/tournamentScreen.dart';
import 'package:frolicsports/services/getSports.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:frolicsports/services/torunaments.dart';
import 'package:intl/intl.dart';

class AddTournament extends StatefulWidget {
  String edit;
  TournamentModel tournamentModel;
  AddTournament({this.edit, this.tournamentModel});
  @override
  _AddTournamentState createState() => _AddTournamentState();
}

class _AddTournamentState extends State<AddTournament> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _maxPointsController = TextEditingController();
  TextEditingController _playersController = TextEditingController();
  TextEditingController _maxSingleTeamController = TextEditingController();
  TextEditingController _deadlineSecondsController = TextEditingController();
  var startDateAndTime;
  var endDateAndTime;
  Widget startDateAndTimeField() {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    return Container(
      child: DateTimeField(
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

  Widget endDateAndTimeField() {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    return Container(
      child: DateTimeField(
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
            endDateAndTime = dateTime;
            print('dateTime${dateTime}');
            return dateTime;
          } else {
            return currentValue;
          }
        },
      ),
    );
  }

  Widget textFieldWithImage(String name, String choose) {
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
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: OutlineButton(
                  child: Text(
                    "Choose File",
                    style: TextStyle(fontSize: 17),
                  ),
                  borderSide: BorderSide(
                      color: Colors.grey.shade700,
                      width: 3,
                      style: BorderStyle.solid),
                  onPressed: () {
                    uploadImageToStorage();
                  },
                ),
              ),
              Padding(
                child: imageText == null
                    ? Text(choose)
                    : Text(imageText.toString()),
                padding: EdgeInsets.zero,
              )
            ],
          ),
        )
      ],
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

  String _category;

  String _selectCountry;

  dropDownSports(
      {List<SportsModel> categories, String selectedCategory, String name}) {
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
                            'SELECT SPORTS',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          items: _sportsList.map((sports) {
                            return new DropdownMenuItem(
                                value: sports.id.toString(),
                                child: Text(
                                  sports.name,
                                  style: TextStyle(color: Colors.black),
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            // do other stuff with _category
                            setState(() {
                              selectedCategory = newValue;
                              _category = newValue;
                              print("selected value $_category");
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

  dropDownCountry(
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
                            'SELECT COUNTRY',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          items: _tournamentList.map((tournament) {
                            return new DropdownMenuItem(
                                value: tournament.country.toString(),
                                child: Text(
                                  //'',
                                  tournament.country.toString(),
                                  style: TextStyle(color: Colors.black),
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            // do other stuff with _category
                            setState(() {
                              selectedCategory = newValue;
                              _selectCountry = newValue;
                              print("selected country $selectedCategory");
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

  GetPostTournaments getPostTournaments = GetPostTournaments();
  postTournamentData() {
    TournamentModel tournamentModel = TournamentModel(
        description: _descriptionController.text,
        deadlineSeconds: int.parse(_deadlineSecondsController.text),
        enabled: isEnabled,
        name: _titleController.text,
        startDate: startDateAndTime,
        endDate: endDateAndTime,
        maxPlayers: int.parse(_playersController.text),
        logo: imageText,
        maxPoints: int.parse(_maxPointsController.text),
        maxSingleTeam: int.parse(_maxSingleTeamController.text),
        playerFolderName: "tournament/ronnie.png",
        teamFolderName: "tournament/ronnie.png",
        country: _selectCountry,
        sportsId: int.parse(_category));
    getPostTournaments.postTournaments(
        tournamentModelObject: tournamentModel,
        function: uploadImageToFirebaseStorage());
  }

  List<SportsModel> _sportsList;
  List<TournamentModel> _tournamentList;
  bool _loading;
  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();
//    _titleController = TextEditingController(text: widget.tournamentModel.name);
//    _descriptionController =
//        TextEditingController(text: widget.tournamentModel.description);
//    _deadlineSecondsController = TextEditingController(
//        text: "${widget.tournamentModel.deadlineSeconds}");
//    _maxSingleTeamController = TextEditingController(
//        text: widget.tournamentModel.maxSingleTeam.toString());
//    _maxPointsController = TextEditingController(
//        text: widget.tournamentModel.maxPoints.toString());
//    _playersController = TextEditingController(
//        text: widget.tournamentModel.maxPlayers.toString());
    GetSports getSports = GetSports();
    print("TOUR DATA ${widget.tournamentModel.name}");
    getSports.getSports1().then((sports) {
      setState(() {
        _sportsList = sports.sportsModel;
        _loading = false;
      });
    });
    getPostTournaments.getTournaments().then((tournament) {
      setState(() {
        _tournamentList = tournament.tournamentModel;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => Navigator.push(context,
          MaterialPageRoute(builder: (context) => new TournamentScreen())),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: ListView(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ADD TOUNAMENT",
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 20,
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dropDownSports(
                            name: "SELECT SPORTS",
                            selectedCategory: _category,
                            categories: _sportsList),
                        textFieldWithText(
                            "TITLE",
                            _titleController,
                            ValidationKey.title,
                            TextInputType.text,
                            widget.edit == "edit"
                                ? widget.tournamentModel.name
                                : "")
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
                                ? widget.tournamentModel.description
                                : ""),
                        textFieldWithImage(
                            "LOGO",
                            widget.edit == "edit"
                                ? widget.tournamentModel.logo
                                : "No Choose file")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithDateTime(
                            "Start Date", startDateAndTimeField()),
                        textFieldWithDateTime("End Date", endDateAndTimeField())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithText(
                            "Max Points",
                            _maxPointsController,
                            ValidationKey.maxPoints,
                            TextInputType.number,
                            widget.edit == "edit"
                                ? widget.tournamentModel.maxPoints.toString()
                                : ""),
                        textFieldWithText(
                            "Players",
                            _playersController,
                            ValidationKey.players,
                            TextInputType.number,
                            widget.edit == "edit"
                                ? widget.tournamentModel.maxPlayers.toString()
                                : "")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithText(
                            "Max Player From Single Team",
                            _maxSingleTeamController,
                            ValidationKey.maxSingleTeam,
                            TextInputType.number,
                            widget.edit == "edit"
                                ? widget.tournamentModel.maxSingleTeam
                                    .toString()
                                : ""),
                        textFieldWithText(
                            "DeadLine In Seconds",
                            _deadlineSecondsController,
                            ValidationKey.deadlineSeconds,
                            TextInputType.number,
                            widget.edit == "edit"
                                ? widget.tournamentModel.deadlineSeconds
                                    .toString()
                                : "")
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dropDownCountry(
                            name: "SELECT COUNRTY",
                            categories: _tournamentList,
                            selectedCategory: _selectCountry),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
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
                        widget.edit == "edit"
                            ? RaisedButton(
                                onPressed: () {
                                  _editTour();
                                },
                                color: Colors.lightBlue,
                                child: Text("Edit"),
                              )
                            : RaisedButton(
                                onPressed: () {
                                  _submit();
                                },
                                color: Colors.lightBlue,
                                child: Text("Submit"),
                              )
                      ],
                    ),
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
  var textValue = 'Switch is OFF';
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isEnabled = 1;
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isEnabled = 0;
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  _editTour() async {
    if (_formKey.currentState.validate()) {
      TournamentModel tournamentModel = TournamentModel(
          description: _descriptionController.text == null
              ? widget.tournamentModel.deadlineSeconds
              : _descriptionController.text,
          deadlineSeconds: int.parse(_deadlineSecondsController.text) == null
              ? widget.tournamentModel.deadlineSeconds
              : int.parse(_deadlineSecondsController.text),
          enabled: isEnabled,
          name: _titleController.text == null
              ? widget.tournamentModel.name
              : _titleController.text,
          startDate: startDateAndTime,
          endDate: endDateAndTime,
          maxPlayers: int.parse(_playersController.text) == null
              ? widget.tournamentModel.maxPlayers
              : int.parse(_playersController.text),
          logo: imageText == null ? widget.tournamentModel.logo : imageText,
          maxPoints: int.parse(_maxPointsController.text) == null
              ? widget.tournamentModel.maxPoints
              : int.parse(_maxPointsController.text),
          maxSingleTeam: int.parse(_maxSingleTeamController.text) == null
              ? widget.tournamentModel.maxSingleTeam
              : int.parse(_maxSingleTeamController.text),
          playerFolderName: "tournament/ronnie.png",
          teamFolderName: "tournament/ronnie.png",
          country: _selectCountry == null ? "IND" : "IND",
          sportsId: int.parse(_category),
          id: widget.tournamentModel.id);
      await getPostTournaments.editTournaments(
        tournamentModelObject: tournamentModel,
      );
      uploadImageToFirebaseStorage();
    }
  }

  File _file;
  uploadImageToFirebaseStorage() {
    final path =
        "$STORAGE_FOLDER_TOURNAMENT${_titleController.text}/${_file.name.toString()}";
    fb.storage().refFromURL(REF_FROM_URL).child(path).put(_file);
  }

  uploadImage({@override Function(File file) onSelected}) {
    InputElement uploadInput = FileUploadInputElement()..accept = "image/*";
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          onSelected(file);
        });
      });
    });
  }

  String imageText;
  uploadImageToStorage() {
    uploadImage(onSelected: (file) {
      _file = file;
      imageText = file.name.toString();

      // print("data is ${imageText.toString()}");
    });
  }

  List tournamentName = [];
  _submit() {
    if (_formKey.currentState.validate()) {
      _tournamentList.forEach((element) {
        tournamentName.add(element.name);
      });
      tournamentName.contains(_titleController.text)
          ? Fluttertoast.showToast(
              msg: "This title already created",
              gravity: ToastGravity.CENTER_LEFT,
              timeInSecForIosWeb: 2)
          : valid();
    }
  }

  valid() {
    postTournamentData();
    Fluttertoast.showToast(
      msg: "Added Successfully",
      gravity: ToastGravity.CENTER_LEFT,
      timeInSecForIosWeb: 2,
    );
  }
}
