import 'package:flutter/material.dart';
import 'package:frolicsports/constants/textField.dart';
import 'package:frolicsports/models/contestsModel.dart';
import 'package:frolicsports/models/matchesModel.dart';
import 'package:frolicsports/services/contestsServices.dart';
import 'package:frolicsports/services/matchesServices.dart';

class AddContest extends StatefulWidget {
  @override
  _AddContestState createState() => _AddContestState();
}

class _AddContestState extends State<AddContest> {
  final _formKey = GlobalKey<FormState>();
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
                            'SELECT MATCH',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          items: _matchList.map((match) {
                            return new DropdownMenuItem(
                                value: match.id.toString(),
                                child: Text(
                                  match.venue,
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

  GetPostContest getPostContest = GetPostContest();
  postContestsData() {
    ContestsModel contestsModel = ContestsModel(
        name: _titleController.text,
        contestCategory: _contestCategoryController.text,
        entryAmount: int.parse(_entryAmountController.text),
        maxEntries: int.parse(_maxEntriesController.text),
        maxEntriesPerUser: int.parse(_maxEntryPerUserController.text),
        matchId: int.parse(_matchId),
        status: int.parse(_statusController.text));
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
                      textFieldWithText("Entry Amount", _entryAmountController,
                          ValidationKey.entryAmount, TextInputType.number),
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
                          ValidationKey.score,
                          TextInputType.text)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textFieldWithText("Status", _statusController,
                          ValidationKey.maxEntryPerUSer, TextInputType.number),
                      RaisedButton(
                        color: Colors.lightBlue,
                        child: Text("Submit"),
                        onPressed: () {
                          _submit();
                        },
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

  _submit() {
    if (_formKey.currentState.validate()) {
      postContestsData();
    }
  }
}
