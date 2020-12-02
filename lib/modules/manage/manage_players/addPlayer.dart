import 'dart:html';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/constants/textField.dart';
import 'package:frolicsports/models/playersModel.dart';
import 'package:frolicsports/models/skillsModel.dart';
import 'package:frolicsports/models/teamsModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/services/playersServices.dart';
import 'package:frolicsports/services/skillsServices.dart';
import 'package:frolicsports/services/teamsServices.dart';
import 'package:frolicsports/services/torunaments.dart';
import 'package:firebase/firebase.dart' as fb;

import 'managePlayer.dart';

class AddPlayer extends StatefulWidget {
  String edit;
  PlayersModel playersModel;
  AddPlayer({this.edit, this.playersModel});
  @override
  _AddPlayerState createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _creditController = TextEditingController();
  TextEditingController _pointsController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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

  dropDownSkills(
      {List<SkillsModel> categories, String selectedCategory, String name}) {
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
                            'SELECT SKILL',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          items: _skillsList.map((skills) {
                            return new DropdownMenuItem(
                                value: skills.id.toString(),
                                child: Text(
                                  skills.name,
                                  style: TextStyle(color: Colors.black),
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            // do other stuff with _category
                            setState(() {
                              selectedCategory = newValue;
                              _skill = newValue;
                              //print("selected value $_category");
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

  dropDownCountries(
      {List<String> categories, String selectedCategory, String name}) {
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
                          items: countryList.map((country) {
                            return new DropdownMenuItem(
                                value: country.toString(),
                                child: Text(
                                  country.toString(),
                                  style: TextStyle(color: Colors.black),
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            // do other stuff with _category
                            setState(() {
                              selectedCategory = newValue;
                              _country = newValue;
                              print("selected value $selectedCategory");
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

  dropDownTeams(
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
                              _team = newValue;
                              //print("selected value $_category");
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

  String _skill;
  String _country;
  String _team;
  bool _loading;
  List<String> countryList = [
    "India",
    "Pakistan",
    "Australia",
    "England",
    "WestIndies",
    "South Affrica",
    "Bangladesh"
  ];
  GetPostPlayers getPostPlayers = GetPostPlayers();
  postPlayersData() async {
    PlayersModel playersModel = PlayersModel();
    await getPostPlayers.postPlayers(
      playersModelObject: playersModel,
    );
    setState(() {
      _loading = false;
    });
  }

  getPlayersData() async {
    await getPostPlayers.getPlayers().then((player) {
      player.playersModel.forEach((element) {
        playerName.add(element.name);
        setState(() {
          _loading = false;
        });
      });
    });
  }

  // TournamentModelList tournamentModelList = TournamentModelList();
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

  List<SkillsModel> _skillsList;
  //SkillsModelList skillsModelList = SkillsModelList();
  GetPostSkills getSkills = GetPostSkills();
  getSkillsData() async {
    await getSkills.getSkills().then((skills) {
      setState(() {
        _skillsList = skills.skillsModel;
        _loading = false;
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

  postPlayerData() async {
    PlayersModel playersModel = PlayersModel(
        name: _nameController.text,
        country: _country,
        teamId: int.parse(_team),
        skillsId: int.parse(_skill),
        credits: int.parse(_creditController.text),
        picture: imageText,
        points: int.parse(_pointsController.text),
        shortName: _nickNameController.text,
        isPlaying: isEnabled,
        status: isStatus);
    await getPostPlayers.postPlayers(
        function: uploadImageToFirebaseStorage(),
        playersModelObject: playersModel);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    if (widget.playersModel.name != "" && widget.playersModel.name != null) {
      _nameController = TextEditingController(text: widget.playersModel.name);
      _nickNameController =
          TextEditingController(text: widget.playersModel.shortName);
      _pointsController =
          TextEditingController(text: "${widget.playersModel.points}");
      _creditController =
          TextEditingController(text: widget.playersModel.credits.toString());
    }
    getTeamsData();
    getTournamentData();
    getSkillsData();
    getPlayersData();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => Navigator.push(context,
          MaterialPageRoute(builder: (context) => new ManagePlayerScreen())),
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
                      "ADD PLAYER",
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
                        dropDownTeams(
                            selectedCategory: _team,
                            name: "Select Team",
                            categories: _teamList),
                        textFieldWithText(
                            "Name",
                            _nameController,
                            ValidationKey.name,
                            TextInputType.text,
                            widget.edit == "edit"
                                ? widget.playersModel.name.toString()
                                : "")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithText(
                            "Nick Name",
                            _nickNameController,
                            ValidationKey.name,
                            TextInputType.text,
                            widget.edit == "edit"
                                ? widget.playersModel.shortName.toString()
                                : ""),
                        dropDownSkills(
                            categories: _skillsList,
                            name: "Select Skill",
                            selectedCategory: _skill)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithText(
                            "Credit",
                            _creditController,
                            ValidationKey.credit,
                            TextInputType.text,
                            widget.edit == "edit"
                                ? widget.playersModel.credits.toString()
                                : ""),
                        textFieldWithImage(
                            "Upload Image",
                            widget.edit == "edit"
                                ? widget.playersModel.picture
                                : "No choose file")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithText(
                            "Points",
                            _pointsController,
                            ValidationKey.maxPoints,
                            TextInputType.text,
                            widget.edit == "edit"
                                ? widget.playersModel.points.toString()
                                : ""),
                        dropDownCountries(
                            selectedCategory: _country,
                            categories: countryList,
                            name: "Select Country")
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
                        Text(
                          '$textvalue',
                          style: TextStyle(fontSize: 20),
                        ),
                        Switch(
                          onChanged: toggleSwitchStatus,
                          value: isSwitch,
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
                                  _editPlayer();
                                },
                                color: Colors.lightBlue,
                                child: Text("EDIT"),
                              )
                            : RaisedButton(
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

  _editPlayer() {
    if (_team == null) {
      showDialog("Please select Team");
      return;
    }
    if (_skill == null) {
      showDialog("Please select Skills");
      return;
    }
    if (imageText == null && widget.playersModel.picture == null) {
      showDialog("Please select Image");
      return;
    }
    if (_country == null) {
      showDialog("Please select Country");
      return;
    }
    if (_formKey.currentState.validate()) {
      PlayersModel playersModel = PlayersModel(
          name: _nameController.text == null
              ? widget.playersModel.name
              : _nameController.text,
          country: _country,
          teamId: int.parse(_team) == null
              ? widget.playersModel.teamId
              : int.parse(_team),
          skillsId: int.parse(_skill) == null
              ? widget.playersModel.skillsId
              : int.parse(_skill),
          credits: int.parse(_creditController.text) == null
              ? widget.playersModel.credits
              : int.parse(_creditController.text),
          picture: imageText == null ? widget.playersModel.picture : imageText,
          points: int.parse(_pointsController.text) == null
              ? widget.playersModel.points
              : int.parse(_pointsController.text),
          shortName: _nickNameController.text == null
              ? widget.playersModel.shortName
              : _nickNameController.text,
          isPlaying:
              isEnabled == null ? widget.playersModel.isPlaying : isEnabled,
          status: isStatus == null ? widget.playersModel.status : isStatus,
          id: widget.playersModel.id);
      getPostPlayers.editPlayers(playersModelObject: playersModel);
      uploadImageToFirebaseStorage();
    }
  }

  bool isSwitched = true;
  int isEnabled = 1;
  var textValue = 'Not Playing';
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isEnabled = 1;
        isSwitched = true;
        textValue = 'Playing';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isEnabled = 0;
        isSwitched = false;
        textValue = 'Not Playing';
      });
      print('Switch Button is OFF');
    }
  }

  bool isSwitch = true;
  int isStatus = 1;
  var textvalue = 'Status';
  void toggleSwitchStatus(bool value) {
    if (isSwitched == false) {
      setState(() {
        isStatus = 1;
        isSwitch = true;
        textvalue = 'Status is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isStatus = 0;
        isSwitch = false;
        textvalue = 'Status is OFF';
      });
      print('Switch Button is OFF');
    }
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

  void showDialog(String name) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(name),
    ));
  }

  String imageText;
  uploadImageToStorage() {
    uploadImage(onSelected: (file) {
      // print("data issss ${file.name.toString()}");
      // final path = "FrolicSports/${file.name.toString()}";
      _file = file;

      imageText = file.name.toString();
    });
  }

  List playerName = [];
  _submit() {
    if (_team == null) {
      showDialog("Please select Team");
      return;
    }
    if (_skill == null) {
      showDialog("Please select Skills");
      return;
    }
    if (imageText == null) {
      showDialog("Please select Image");
      return;
    }
    if (_country == null) {
      showDialog("Please select Country");
      return;
    }
    if (_formKey.currentState.validate()) {
      playerName.contains(_nameController.text)
          ? Fluttertoast.showToast(
              msg: "This title already created",
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2)
          : valid();
    }
  }

  valid() {
    postPlayerData();
    Fluttertoast.showToast(
      msg: "Added Successfully",
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
    );
  }
}
