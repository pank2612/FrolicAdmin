import 'dart:html';

import 'package:flutter/material.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/constants/textField.dart';
import 'package:frolicsports/models/teamsModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/services/teamsServices.dart';
import 'package:frolicsports/services/torunaments.dart';
import 'package:firebase/firebase.dart' as fb;

class AddTeams extends StatefulWidget {
  @override
  _AddTeamsState createState() => _AddTeamsState();
}

class _AddTeamsState extends State<AddTeams> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _shortCodeController = TextEditingController();
  TextEditingController _logoController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _maxPointsController = TextEditingController();
  TextEditingController _playersController = TextEditingController();
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

  File _file;
  uploadImageToFirebaseStorage() {
    final path =
        "$STORAGE_FOLDER_TOURNAMENT${_nameController.text}/${_file.name.toString()}";
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
                            'SELECT TOURNAMENT',
                            style: TextStyle(fontSize: 16, color: Colors.black),
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

  List<TournamentModel> _tournamentList;
  GetPostTournaments getPostTournaments = GetPostTournaments();
  getTournamentData() async {
    //tournamentModelList = await getPostTournaments.getTournaments();
    getPostTournaments.getTournaments().then((tournament) {
      setState(() {
        _tournamentList = tournament.tournamentModel;
        _loading = false;
      });
    });
  }

  bool _loading;
  String _tourName;
  GetPostTeams getPostTeams = GetPostTeams();
  postTeamsData() {
    TeamsModel teamsModel = TeamsModel(
        name: _nameController.text,
        shortName: _shortCodeController.text,
        logo: imageText,
        tournamentId: int.parse(_tourName));
    getPostTeams.postTeams(
        teamsModelObject: teamsModel, function: uploadImageToFirebaseStorage());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    getTournamentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "ADD TEAM",
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
                          name: "SELECT TOURNAMENT",
                          categories: _tournamentList,
                          selectedCategory: _tourName),
                      textFieldWithText("Name", _nameController,
                          ValidationKey.name, TextInputType.text)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textFieldWithText("Short Code", _shortCodeController,
                          ValidationKey.shortCode, TextInputType.text),
                      textFieldWithImage(
                        "LOGO",
                      )
                    ],
                  ),
                  RaisedButton(
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
    );
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      postTeamsData();
    }
  }
}