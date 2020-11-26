import 'package:flutter/material.dart';
import 'package:frolicsports/constants/textField.dart';
import 'package:frolicsports/models/skillsModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/modules/manage/manage_skills/manageSkills.dart';
import 'package:frolicsports/services/skillsServices.dart';
import 'package:frolicsports/services/torunaments.dart';

class AddSkills extends StatefulWidget {
  String edit;
  SkillsModel skillsModel;
  AddSkills({this.edit, this.skillsModel});
  @override
  _AddSkillsState createState() => _AddSkillsState();
}

class _AddSkillsState extends State<AddSkills> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _maxController = TextEditingController();
  TextEditingController _minController = TextEditingController();
  TextEditingController _ShortCodeController = TextEditingController();

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

  String _tourName;
  bool _loading;
  GetPostSkills getPostSkills = GetPostSkills();
  postSkillsData() {
    SkillsModel skillsModel = SkillsModel(
        name: _nameController.text,
        tournamentId: int.parse(_tourName),
        shortName: _ShortCodeController.text,
        max: int.parse(_maxController.text),
        min: int.parse(_minController.text));
    getPostSkills.postSkills(
      skillsModelObject: skillsModel,
    );
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
    return new WillPopScope(
      onWillPop: () async => Navigator.push(context,
          MaterialPageRoute(builder: (context) => new ManageSkillsScreen())),
      child: Scaffold(
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
                      "ADD SKILLS",
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
                            selectedCategory: _tourName,
                            categories: _tournamentList,
                            name: "SELECT TOURNAMENT"),
                        textFieldWithText(
                            "Name",
                            _nameController,
                            ValidationKey.name,
                            TextInputType.text,
                            widget.edit == "edit"
                                ? widget.skillsModel.name
                                : "")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithText(
                            "Short Code",
                            _ShortCodeController,
                            ValidationKey.shortCode,
                            TextInputType.text,
                            widget.edit == "edit"
                                ? widget.skillsModel.shortName
                                : ""),
                        textFieldWithText(
                            "Max",
                            _maxController,
                            ValidationKey.maxPlayers,
                            TextInputType.number,
                            widget.edit == "edit"
                                ? widget.skillsModel.max.toString()
                                : "")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithText(
                            "Min",
                            _minController,
                            ValidationKey.minPlayers,
                            TextInputType.number,
                            widget.edit == "edit"
                                ? widget.skillsModel.min.toString()
                                : ""),
                      ],
                    ),
                    widget.edit == "edit"
                        ? RaisedButton(
                            color: Colors.lightBlue,
                            child: Text("EDIT"),
                            onPressed: () {
                              _editSkill();
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

  _editSkill() {
    if (_formKey.currentState.validate()) {
      SkillsModel skillsModel = SkillsModel(
          name: _nameController.text == null
              ? widget.skillsModel.name
              : _nameController.text,
          tournamentId: int.parse(_tourName) == null
              ? widget.skillsModel.tournamentId
              : int.parse(_tourName),
          shortName: _ShortCodeController.text == null
              ? widget.skillsModel.shortName
              : _ShortCodeController.text,
          max: int.parse(_maxController.text) == null
              ? widget.skillsModel.max
              : int.parse(_maxController.text),
          min: int.parse(_minController.text) == null
              ? widget.skillsModel.min
              : int.parse(_minController.text),
          id: widget.skillsModel.id);
      getPostSkills.editSkills(skillsModelObject: skillsModel);
    }
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      postSkillsData();
    }
  }
}
