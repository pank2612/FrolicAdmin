import 'package:flutter/material.dart';
import 'package:frolicsports/constants/textField.dart';
import 'package:frolicsports/models/contestsModel.dart';
import 'package:frolicsports/models/prizeModel.dart';
import 'package:frolicsports/services/contestsServices.dart';
import 'package:frolicsports/services/prizeServices.dart';

class AddPrize extends StatefulWidget {
  @override
  _AddPrizeState createState() => _AddPrizeState();
}

class _AddPrizeState extends State<AddPrize> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _rankRangeStartController = TextEditingController();
  TextEditingController _rankRangeEndController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _scoreController = TextEditingController();
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

  bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    getContestsData();
  }

  List<ContestsModel> _contestList;
  GetPostContest getContest = GetPostContest();
  getContestsData() async {
    await getContest.getContests().then((contest) {
      _contestList = contest.contestsModel;
      setState(() {
        _loading = false;
      });
    });
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

  String _contestId;
  GetPostPrize getPostPrize = GetPostPrize();
  postPrizeData() {
    PrizeModel prizeModel = PrizeModel(
        rankRangeEnd: int.parse(_rankRangeEndController.text),
        rankRangeStart: int.parse(_rankRangeStartController.text),
        status: int.parse(_statusController.text),
        amount: int.parse(_amountController.text),
        contestId: int.parse(_contestId));
    getPostPrize.postPrize(
      prizeModelObject: prizeModel,
    );
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
                    "ADD PRIZE",
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
                        dropDownContest(
                            categories: _contestList,
                            selectedCategory: _contestId,
                            name: "Contest Name"),
                        textFieldWithText("Entry Amount", _amountController,
                            ValidationKey.entryAmount, TextInputType.number),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textFieldWithText(
                          "Rank Range Start",
                          _rankRangeStartController,
                          ValidationKey.status,
                          TextInputType.text),
                      textFieldWithText(
                          "Rank Range End",
                          _rankRangeEndController,
                          ValidationKey.status,
                          TextInputType.text)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textFieldWithText("Status", _statusController,
                          ValidationKey.status, TextInputType.number),
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
      postPrizeData();
    }
  }
}
