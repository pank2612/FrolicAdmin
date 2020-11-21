import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/constants/textField.dart';
import 'package:frolicsports/models/sportsModel.dart';
import 'package:frolicsports/modules/manage/manage_Sports/manageSports.dart';
import 'package:frolicsports/services/getSports.dart';
import 'package:http/http.dart';
import 'package:firebase/firebase.dart' as fb;
import 'dart:html';

class AddSports extends StatefulWidget {
  @override
  _AddSportsState createState() => _AddSportsState();
}

class _AddSportsState extends State<AddSports> {
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

  String imageText;
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

  Future<Uri> downloadUrl() {
    return fb
        .storage()
        .refFromURL('gs://frolicsports-39c94.appspot.com')
        .child("ronnie.jpg")
        .getDownloadURL();
  }

  uploadImage({@override Function(File file) onSelected}) {
    InputElement uplaodInput = FileUploadInputElement()..accept = "image/*";
    uplaodInput.click();
    uplaodInput.onChange.listen((event) {
      final file = uplaodInput.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          onSelected(file);
        });
      });
    });
  }

  File _file;
  uploadImageToFirebaseStorage() {
    final path = "${STORAGE_FOLDER_SPORT + _file.name.toString()}";
    //_file = file;
    fb.storage().refFromURL(REF_FROM_URL).child(path).put(_file);
  }

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

  GetSports getSports = GetSports();
  postSportsData() {
    SportsModel sportsModel = SportsModel(
        name: _nameController.text,
        shortCode: _shortCodeController.text,
        logo: imageText.toString());
    getSports.postSports(sportsModelObject: sportsModel);
    uploadImageToFirebaseStorage();
  }

  getSportsData() {
    getSports.getSports().then((sport) {
      sport.forEach((element) {
        sportName.add(element.name);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSportsData();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => Navigator.push(
          context, MaterialPageRoute(builder: (context) => new ManageSportsScreen())),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.02,
              left: MediaQuery.of(context).size.width * 0.02,
              top: MediaQuery.of(context).size.height * 0.20,
              bottom: MediaQuery.of(context).size.height * 0.20),
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
                      "ADD SPORTS",
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
                        textFieldWithText("Name", _nameController,
                            ValidationKey.name, TextInputType.text),
                        textFieldWithText("Short Code", _shortCodeController,
                            ValidationKey.shortCode, TextInputType.text),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textFieldWithImage("LOGO"),
//                      textFieldWithText("Short Code", _shortCodeController,
//                          ValidationKey.shortCode, TextInputType.text),
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
      ),
    );
  }

  List sportName = [];
  _submit() {
    if (_formKey.currentState.validate()) {
      sportName.contains(_nameController.text)
          ? Fluttertoast.showToast(
              msg: "This title already created",
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2)
          : valid();
    }
  }

  valid() {
    postSportsData();
    Fluttertoast.showToast(
      msg: "Added Successfully",
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
    );
  }
}
