import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/constants/date_And_time.dart';
import 'package:frolicsports/constants/textField.dart';
import 'package:frolicsports/models/sportsModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/services/getSports.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:frolicsports/services/torunaments.dart';
import 'package:intl/intl.dart';

class AddTournament extends StatefulWidget {
  @override
  _AddTournamentState createState() => _AddTournamentState();
}

class _AddTournamentState extends State<AddTournament> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _logoController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
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

  Widget textFieldWithImage(String name) {
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
                    ? Text("No file chosen")
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

  String _category;

  String _selectCountry;

  dropDown({List<String> categories, String selectedCategory, String name}) {
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
          child: DropdownButtonFormField(
            items: categories.map((String category) {
              return new DropdownMenuItem(
                  value: category, child: Text(category));
            }).toList(),
            onChanged: (newValue) {
              // do other stuff with _category
              setState(() => selectedCategory = newValue);
            },
            value: selectedCategory,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              filled: true,
              fillColor: Colors.grey[200],
              hintText: selectedCategory,
            ),
          ),
        ),
      ],
    );
  }

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
            child: _loading == true
                ? Center(child: CircularProgressIndicator())
                : Container(
                    width: MediaQuery.of(context).size.width * 0.96,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.grey.shade600),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
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
            child: _loading == true
                ? Center(child: CircularProgressIndicator())
                : Container(
                    width: MediaQuery.of(context).size.width * 0.96,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.grey.shade600),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
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
                                  tournament.country,
                                  style: TextStyle(color: Colors.black),
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            // do other stuff with _category
                            setState(() {
                              selectedCategory = newValue;
                              _selectCountry = newValue;
                              print("selected country $_selectCountry");
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
        //   "$REF_FROM_URL$STORAGE_FOLDER_TOURNAMENT${_titleController.text}/Players/${_file.name.toString()}",
//        +
//            'frolicsports/' +
//            'tournaments/' +
//            'IPL2021/' +
//            'players/',
        teamFolderName: "tournament/ronnie.png",
        // "$REF_FROM_URL$STORAGE_FOLDER_TOURNAMENT${_titleController.text}/Teams/${_file.name.toString()}",
//        "http:jhgsdhjgsdf" +
//            'frolicsports/' +
//            'tournaments/' +
//            'IPL2021/' +
//            'teams/',
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
    GetSports getSports = GetSports();
    getSports.getSports1().then((sports) {
      // print("Sports ${sports[0].name}");
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
    return Scaffold(
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
                      textFieldWithText("TITLE", _titleController,
                          ValidationKey.title, TextInputType.text)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textFieldWithText("Description", _descriptionController,
                          ValidationKey.Description, TextInputType.text),
                      textFieldWithImage("LOGO")
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
                      textFieldWithText("Max Points", _maxPointsController,
                          ValidationKey.maxPoints, TextInputType.number),
                      textFieldWithText("Players", _playersController,
                          ValidationKey.players, TextInputType.number)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textFieldWithText(
                          "Max Player From Single Team",
                          _maxSingleTeamController,
                          ValidationKey.maxSingleTeam,
                          TextInputType.number),
                      textFieldWithText(
                          "DeadLine In Seconds",
                          _deadlineSecondsController,
                          ValidationKey.deadlineSeconds,
                          TextInputType.number)
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
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      RaisedButton(
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

  File _file;
  uploadImageToFirebaseStorage() {
    final path =
        "$STORAGE_FOLDER_TOURNAMENT${_titleController.text}/${_file.name.toString()}";
    //_file = file;
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
      // print("data issss ${file.name.toString()}");
      // final path = "FrolicSports/${file.name.toString()}";
      _file = file;
//      fb
//          .storage()
//          .refFromURL("gs://frolicsports-39c94.appspot.com")
//          .child(path)
//          .put(file);
      imageText = file.name.toString();

      // print("data is ${imageText.toString()}");
    });
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      postTournamentData();
    }
  }
}
