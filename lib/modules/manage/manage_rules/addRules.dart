import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frolicsports/constants/textField.dart';
import 'package:frolicsports/models/rulesModel.dart';
import 'package:frolicsports/models/tournamentModel.dart';
import 'package:frolicsports/modules/manage/manage_rules/manageRules.dart';
import 'package:frolicsports/services/rulesServices.dart';
import 'package:frolicsports/services/torunaments.dart';

class AddRules extends StatefulWidget {
  String edit;
  RulesModel rulesModel;
  AddRules({this.edit, this.rulesModel});
  @override
  _AddRulesState createState() => _AddRulesState();
}

class _AddRulesState extends State<AddRules> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _shortCodeController = TextEditingController();
  TextEditingController _pointsController = TextEditingController();
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
  GetPostRules getPostRules = GetPostRules();
  postRulesData() {
    RulesModel rulesModel = RulesModel(
        name: _nameController.text,
        shortName: _shortCodeController.text,
        tournamentId: int.parse(_tourName),
        points: double.parse(_pointsController.text));
    getPostRules.postRules(
      rulesModelObject: rulesModel,
    );
  }

  getRuleData() async {
    await getPostRules.getRule().then((rule) {
      rule.rulesModel.forEach((element) {
        ruleName.add(element.name);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    if (widget.rulesModel.name != "" && widget.rulesModel.name != null) {
      _nameController = TextEditingController(text: widget.rulesModel.name);
      _shortCodeController =
          TextEditingController(text: widget.rulesModel.shortName);
      _pointsController =
          TextEditingController(text: "${widget.rulesModel.points.toString()}");
    }
    getTournamentData();
    getRuleData();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => Navigator.push(context,
          MaterialPageRoute(builder: (context) => new ManageRulesScreen())),
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
                      "ADD RULES",
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
                            selectedCategory: _tourName,
                            categories: _tournamentList),
                        textFieldWithText(
                            "Name",
                            _nameController,
                            ValidationKey.name,
                            TextInputType.text,
                            widget.edit == "edit" ? widget.rulesModel.name : "")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithText(
                            "Short Code",
                            _shortCodeController,
                            ValidationKey.shortCode,
                            TextInputType.text,
                            widget.edit == "edit"
                                ? widget.rulesModel.shortName
                                : ""),
                        textFieldWithText(
                            "Points",
                            _pointsController,
                            ValidationKey.maxPoints,
                            TextInputType.number,
                            widget.edit == "edit"
                                ? widget.rulesModel.points.toString()
                                : "")
                      ],
                    ),
                    widget.edit == "edit"
                        ? RaisedButton(
                            color: Colors.lightBlue,
                            child: Text("EDIT"),
                            onPressed: () {
                              _editRules();
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

  List ruleName = [];
  _submit() {
    if (_tourName == null) {
      showDialog("Please select Tournament");
      return;
    }
    if (_formKey.currentState.validate()) {
      ruleName.contains(_nameController.text)
          ? Fluttertoast.showToast(
              msg: "This title already created",
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2)
          : valid();
    }
  }

  void showDialog(String name) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(name),
    ));
  }

  _editRules() {
    if (_tourName == null) {
      showDialog("Please select Tournament");
      return;
    }
    if (_formKey.currentState.validate()) {
      RulesModel rulesModel = RulesModel(
          id: widget.rulesModel.id,
          name: _nameController.text == null
              ? widget.rulesModel.name
              : _nameController.text,
          shortName: _shortCodeController.text == null
              ? widget.rulesModel.shortName
              : _shortCodeController.text,
          tournamentId: int.parse(_tourName) == null
              ? widget.rulesModel.tournamentId
              : int.parse(_tourName),
          points: int.parse(_pointsController.text) == null
              ? widget.rulesModel.points
              : int.parse(_pointsController.text));
      getPostRules.editRules(rulesModelObject: rulesModel);
    }
  }

  valid() {
    postRulesData();
    Fluttertoast.showToast(
      msg: "Added Successfully",
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
    );
  }
}
