import 'package:flutter/material.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/constants/textField.dart';
import 'package:frolicsports/models/contestsModel.dart';
import 'package:frolicsports/models/prizeModel.dart';
import 'package:frolicsports/modules/prize/prizeScreen.dart';
import 'package:frolicsports/services/contestsServices.dart';
import 'package:frolicsports/services/prizeServices.dart';

class AddPrize extends StatefulWidget {
  List<PrizeModel> prizeModel;
  ContestsModel contestsModel;
  String edit;
  PrizeModel prizeModelObject;
  AddPrize(
      {this.prizeModel, this.contestsModel, this.edit, this.prizeModelObject});
  @override
  _AddPrizeState createState() => _AddPrizeState();
}

class _AddPrizeState extends State<AddPrize> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _rankRangeStartController = TextEditingController();
  TextEditingController _rankRangeEndController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
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

  bool _loading;
  int flag;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flag = 0;
    _loading = true;
  }

  GetPostPrize getPostPrize = GetPostPrize();
  postPrizeData() {
    PrizeModel prizeModel = PrizeModel(
        rankRangeEnd: int.parse(_rankRangeEndController.text),
        rankRangeStart: int.parse(_rankRangeStartController.text),
        status: isEnabled,
        amount: int.parse(_amountController.text),
        contestId: widget.contestsModel.id);
    getPostPrize.postPrize(
      prizeModelObject: prizeModel,
    );
    showSnakBar();
//    showDialog(
//        "Added Successfully :- ${int.parse(_rankRangeStartController.text).toString() + " - " + int.parse(_rankRangeEndController.text).toString() + " : " + int.parse(_amountController.text).toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => Navigator.push(
          context, MaterialPageRoute(builder: (context) => new PrizeScreen())),
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Text(
                      "Contest Name is ${widget.contestsModel.name.toString() == null ? "" : widget.contestsModel.name.toString()}",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textFieldWithText(
                              "Entry Amount",
                              _amountController,
                              ValidationKey.entryAmount,
                              TextInputType.number,
                              widget.edit == "edit"
                                  ? widget.prizeModelObject.amount.toString()
                                  : ""),
                          textFieldWithText(
                              "Rank Range Start",
                              _rankRangeStartController,
                              ValidationKey.rankRangeStart,
                              TextInputType.text,
                              widget.edit == "edit"
                                  ? widget.prizeModelObject.rankRangeStart
                                      .toString()
                                  : ""),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithText(
                            "Rank Range End",
                            _rankRangeEndController,
                            ValidationKey.rankRangeStart,
                            TextInputType.text,
                            widget.edit == "edit"
                                ? widget.prizeModelObject.rankRangeEnd
                                    .toString()
                                : ""),
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
                                  editData();
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

  _submit() async {
    int startRange = int.parse(_rankRangeStartController.text);
    int endRange = int.parse(_rankRangeEndController.text);
    print(startRange.toString());
    print(endRange.toString());
    int prizeAmount = int.parse(_amountController.text);
    if (_formKey.currentState.validate()) {
      if (startRange == 0 || endRange == 0) {
        showDialog("Start and End rank range can't be Zero");
        return;
      }
      if (startRange > endRange) {
        showDialog("Start rank range can't be less than End range");
        return;
      }
      int tempPrizeAmount = (endRange - startRange + 1) * prizeAmount;
      Map<int, int> tempMap = Map<int, int>();
      for (int y = 1; y <= widget.contestsModel.maxEntries; y++) {
        tempMap[y] = 0;
      }

      int submittedAmount = 0;
      for (int i = 0; i < widget.prizeModel.length; i++) {
        submittedAmount += ((widget.prizeModel[i].rankRangeEnd -
                widget.prizeModel[i].rankRangeStart +
                1) *
            widget.prizeModel[i].amount);
        for (int k = widget.prizeModel[i].rankRangeStart;
            k <= widget.prizeModel[i].rankRangeEnd;
            k++) {
          tempMap[k] = widget.prizeModel[i].amount;
        }
      }
      print(submittedAmount);
      print(tempMap);
      for (int k = startRange; k <= endRange; k++) {
        if (tempMap[k] != 0) {
          showDialog("Rank Entry Already Submitted");
          return;
        }
      }
      if (tempPrizeAmount + submittedAmount >
          widget.contestsModel.entryAmount * widget.contestsModel.maxEntries) {
        showDialog("max amount threshold exceeds");
        return;
      }
      postPrizeData();
      PrizeModel _prizeModel = PrizeModel(
          amount: prizeAmount,
          rankRangeEnd: endRange,
          rankRangeStart: startRange,
          contestId: widget.contestsModel.id);
      widget.prizeModel.add(_prizeModel);
    }
  }

  editData() {
    int startRange = int.parse(_rankRangeStartController.text);
    int endRange = int.parse(_rankRangeEndController.text);
    print(startRange.toString());
    print(endRange.toString());
    int prizeAmount = int.parse(_amountController.text);
    if (_formKey.currentState.validate()) {
      widget.prizeModel.forEach((prize) {
        if (widget.prizeModelObject.id == prize.id) {
          showDialog("Same id");
          return;
        }
      });
      if (startRange == 0 || endRange == 0) {
        showDialog("Start and End rank range can't be Zero");
        return;
      }
      if (startRange > endRange) {
        showDialog("Start rank range can't be less than End range");
        return;
      }
      int tempPrizeAmount = (endRange - startRange + 1) * prizeAmount;
      Map<int, int> tempMap = Map<int, int>();
      for (int y = 1; y <= widget.contestsModel.maxEntries; y++) {
        tempMap[y] = 0;
      }

      int submittedAmount = 0;
      for (int i = 0; i < widget.prizeModel.length; i++) {
        submittedAmount += ((widget.prizeModel[i].rankRangeEnd -
                widget.prizeModel[i].rankRangeStart +
                1) *
            widget.prizeModel[i].amount);
        for (int k = widget.prizeModel[i].rankRangeStart;
            k <= widget.prizeModel[i].rankRangeEnd;
            k++) {
          tempMap[k] = widget.prizeModel[i].amount;
        }
      }
      print(submittedAmount);
      print(tempMap);
      for (int k = startRange; k <= endRange; k++) {
        if (tempMap[k] != 0) {
          showDialog("Rank Entry Already Submitted");
          return;
        }
      }
      if (tempPrizeAmount + submittedAmount >
          widget.contestsModel.entryAmount * widget.contestsModel.maxEntries) {
        showDialog("max amount threshold exceeds");
        return;
      }
      editPrizeData();
      PrizeModel _prizeModel = PrizeModel(
          amount: prizeAmount,
          rankRangeEnd: endRange,
          rankRangeStart: startRange,
          contestId: widget.contestsModel.id);
      widget.prizeModel.add(_prizeModel);
    }
  }

  editPrizeData() {
    PrizeModel prizeModel = PrizeModel(
        rankRangeEnd: int.parse(_rankRangeEndController.text) == null
            ? widget.prizeModelObject.rankRangeEnd
            : int.parse(_rankRangeEndController.text),
        rankRangeStart: int.parse(_rankRangeStartController.text) == null
            ? widget.prizeModelObject.rankRangeStart
            : int.parse(_rankRangeStartController.text),
        status: isEnabled == null ? widget.prizeModelObject.status : isEnabled,
        amount: int.parse(_amountController.text) == null
            ? widget.prizeModelObject.amount
            : int.parse(_amountController.text),
        contestId: widget.contestsModel.id == null
            ? widget.prizeModelObject.contestId
            : widget.contestsModel.id,
        id: widget.prizeModelObject.id);
    getPostPrize.postPrize(
      prizeModelObject: prizeModel,
    );
    showSnakBar();
  }

  void showDialog(String name) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(name),
    ));
  }

  void showSnakBar() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Container(
        height: 200,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Start Rank Range",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  "End Rank Range",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Amount",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.prizeModel[index].rankRangeStart.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                    ),
                    Text(
                      widget.prizeModel[index].rankRangeEnd.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                    ),
                    Text(
                      widget.prizeModel[index].amount.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                    ),
                  ],
                );
              },
              itemCount: widget.prizeModel.length,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    ));
  }
}
