import 'package:flutter/material.dart';
import 'package:frolicsports/constants/validator.dart';

Widget textField(
    {String labletext,
    String hintText,
    ValidationKey inputValidate,
    TextEditingController controller,
    bool isIconShow,
    IconButton image,
    int maxline,
    TextInputType keyboardType,
    bool obscureText}) {
  return TextFormField(
      keyboardType: keyboardType,
      maxLines: maxline,
      obscureText: obscureText,
      controller: controller,
      validator: (input) => validateInput(input, inputValidate),
      style: TextStyle(
        fontSize: 15.0,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        suffixIcon: isIconShow ? image : null,
        labelText: labletext,
        hintText: hintText,
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      ));
}

String validateInput(String inputValue, ValidationKey key) {
  switch (key) {
    case ValidationKey.email:
      return inputValue.isValidEmail() ? null : "Enter correct email";
      break;
    case ValidationKey.password:
      // ignore: unnecessary_statements
      return inputValue.isValidPassword()
          ? null
          : "Enter password must be more than 7 letters";
      break;
    case ValidationKey.title:
      return inputValue.isValidTitle()
          ? null
          : " Title must be more than 3 letters";
      break;
    case ValidationKey.Description:
      return inputValue.isValidDescription()
          ? null
          : "Describe must be more than 5 words";
      break;
    case ValidationKey.name:
      return inputValue.isValidName()
          ? null
          : "Name must be more than 2 letters";
      break;

    case ValidationKey.maxPoints:
      return inputValue.isValidMaxPoints() ? null : "Points can't be Zero";
      break;
    case ValidationKey.minPlayers:
      return inputValue.isValidMaxPlayers() ? null : "Min Players must be 4";
      break;
    case ValidationKey.maxPlayers:
      return inputValue.isValidMaxPlayers() ? null : "Max Players must be 7";
      break;
    case ValidationKey.players:
      return inputValue.isValidPlayers() ? null : "Players can't be Zero";
      break;
    case ValidationKey.number:
      return inputValue.isValidNumber() ? null : "Number can't be Zero";
      break;
    case ValidationKey.score:
      return inputValue.isValidScore() ? null : "Score can't be Zero";
      break;
    case ValidationKey.deadlineSeconds:
      return inputValue.isValidDeadline()
          ? null
          : "Deadlines must be 60 seconds";
      break;
    case ValidationKey.contestCategory:
      return inputValue.isValidContestCategory()
          ? null
          : "Contest must be 60 seconds";
      break;
    case ValidationKey.maxSingleTeam:
      return inputValue.isValidMaxSingleTeam()
          ? null
          : "Min players from single team must be 1";
      break;
    case ValidationKey.venue:
      return inputValue.isValidPlayers()
          ? null
          : "Venue must be more than 5 words";
      break;
    case ValidationKey.entryAmount:
      return inputValue.isValidEntryAmount()
          ? null
          : "Entry Amount can't be Zero";
      break;
    case ValidationKey.status:
      return inputValue.isValidStatus() ? null : "Status can't be empty";
      break;
    case ValidationKey.maxEntries:
      return inputValue.isValidMaxEntries()
          ? null
          : "Max Entries can't be Zero";
      break;
    case ValidationKey.maxEntryPerUSer:
      return inputValue.isValidMaxEntryPerUser()
          ? null
          : "Max Entry Per User can't be Zero";
      break;
    case ValidationKey.credit:
      return inputValue.isValidCredit()
          ? null
          : " Credit must be more than 3 letters";
      break;
    case ValidationKey.shortCode:
      return inputValue.isValidShortCode()
          ? null
          : " Short Code must be more than 2 letters";
      break;
  }
}

enum ValidationKey {
  email,
  title,
  Description,
  maxPoints,
  players,
  venue,
  number,
  score,
  entryAmount,
  maxEntries,
  maxEntryPerUSer,
  maxPlayers,
  minPlayers,
  credit,
  contestCategory,
  shortCode,
  deadlineSeconds,
  maxSingleTeam,
  status,
  time,
  device,
  gateNo,
  entrance,
  ownerName,
  towerNumber,
  familyMember,
  documentType,
  adharCard,
  panCard,
  gender,
  password,
  username,
  mobileNo,
  otherMobileNo,
  name,
  companyName,
  society,
  flatNo,
  controller,
  option,
  confirmPassword,
  validDocumentType
}
