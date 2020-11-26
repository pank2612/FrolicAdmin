import 'package:flutter/material.dart';
import 'package:frolicsports/constants/validator.dart';
import 'package:regexpattern/regexpattern.dart';

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
        hintStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      ));
}

String validateInput(String inputValue, ValidationKey key) {
  switch (key) {
    case ValidationKey.email:
      return inputValue.isEmail() ? null : "Enter correct email";
      break;
    case ValidationKey.password:
      return inputValue.isPasswordHard()
          ? null
          : "Must contains at least: 1 uppercase letter, 1 lowecase letter, 1 number, & 1 special character (symbol),Minimum character: 8";
      break;
    case ValidationKey.title:
      return inputValue.isValidTitle()
          ? null
          : " Title must be more than 2 letters";
      break;
    case ValidationKey.Description:
      return inputValue.isValidDescription()
          ? null
          : "Describe must be more than 2 letters";
      break;
    case ValidationKey.name:
      return inputValue.isValidName()
          ? null
          : "Name must be more than 2 letters";
      break;

    case ValidationKey.maxPoints:
      return inputValue.isMaxPoints()
          ? null
          : "Points must be less than 3 digits";
      break;
    case ValidationKey.minPlayers:
      return inputValue.isMinPlayers()
          ? null
          : "Min Players must be less than 2 digits";
      break;
    case ValidationKey.maxPlayers:
      return inputValue.isMaxPlayers()
          ? null
          : "Max Players must be less than 3 digits";
      break;
    case ValidationKey.players:
      return inputValue.isMaxPlayers()
          ? null
          : "Players must be less than 3 digits";
      break;
    case ValidationKey.number:
      return inputValue.isValidMobile() ? null : "Number must be 2 digits";
      break;
    case ValidationKey.score:
      return inputValue.isValidMobile() ? null : "Score must be 2 digits";
      break;
    case ValidationKey.deadlineSeconds:
      return inputValue.isValidDeadlines()
          ? null
          : "Deadlines must be more than 60 seconds";
      break;
    case ValidationKey.contestCategory:
      return inputValue.isValidContestCategory()
          ? null
          : "Contest can't be empty";
      break;
    case ValidationKey.maxSingleTeam:
      return inputValue.isMaxPlayerSingleTeam()
          ? null
          : "Max players from single team must be 9";
      break;
    case ValidationKey.venue:
      return inputValue.isValidName() ? null : "Venue can't be empty";
      break;
    case ValidationKey.entryAmount:
      return inputValue.isEntryAmount() ? null : "Entry Amount can't be Zero";
      break;
    case ValidationKey.status:
      return inputValue.isBinary() ? null : "Status must be 0 or 1";
      break;
    case ValidationKey.maxEntries:
      return inputValue.isMaxEntries() ? null : "Max Entries can't be Zero";
      break;

    case ValidationKey.maxEntryPerUSer:
      return inputValue.isMaxEntryPerUSer()
          ? null
          : "Max Entry Per User can't be Zero";
      break;
    case ValidationKey.credit:
      return inputValue.isValidCredits()
          ? null
          : " Credit must be more than 2 letters";
      break;
    case ValidationKey.shortCode:
      return inputValue.isShortCode()
          ? null
          : " Short Code must be uppercase and less than 4 digits";
      break;
    case ValidationKey.image:
      return inputValue.isImage()
          ? null
          : " Short Code must be more than 1 letters";
      break;
    case ValidationKey.rankRangeStart:
      return inputValue.isRankRangeStart()
          ? null
          : " This field can't be empty";
      break;
  }
}

enum ValidationKey {
  rankRangeStart,
  image,
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
  password,
  username,
  mobileNo,
  name,
}
