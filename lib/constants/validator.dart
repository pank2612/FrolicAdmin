class Validators {
  bool emailValidator(String email) {
    const Pattern _pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp _regex = new RegExp(_pattern);

    if (_regex.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  phoneValidator(String phone) {
    if (phone.length > 5) {
      return true;
    } else {
      return false;
    }
  }

  passwordValidator(String password) {
    if (password.length > 6) {
      return true;
    } else {
      return false;
    }
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  houseNoValidator(String phone) {
    return phone.isEmpty || phone.length < 1
        ? "Enter your House number "
        : null;
  }

//  String timeForApi(int seconds) {
//    var secondOfDate = new DateTime.fromMillisecondsSinceEpoch(seconds);
//    var formatter = new DateFormat('yyyy-MM-dd');
//    String formattedString = formatter.format(secondOfDate);
//    return formattedString;
//  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        // r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        r'^[^@]+@[^@]+\.[^@]+').hasMatch(this);
  }

  bool isValidCredits() {
    return RegExp(r'(^(?:[+0]9)?[0-9]+$)').hasMatch(this) && this.length < 3
        ? true
        : false;
  }

  bool isValidName() {
    return RegExp(r'^[a-zA-Z ]+$').hasMatch(this) &&
            this.length > 2 &&
            this.length < 30
        ? true
        : false;
  }

  bool isValidTitle() {
    return this.length > 2 &&
            this.length < 30 &&
            RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(this)
        ? true
        : false;
  }

  bool isShortCode() {
    return RegExp(r'^[A-Z]+$').hasMatch(this) &&
            //this.length > 2 &&
            this.length < 4
        ? true
        : false;
  }

  bool isValidDeadlines() {
    return RegExp(r'(^(?:[+0]9)?[0-9]+$)').hasMatch(this) &&
            this.length > 1 &&
            this.length < 8
        ? true
        : false;
  }

  bool isMaxPoints() {
    return RegExp(r'(^(?:[+0]9)?[0-9]+$)').hasMatch(this) && this.length < 3
        ? true
        : false;
  }

  bool isMinPlayers() {
    return RegExp(r'(^(?:[+0]9)?[0-9]{1}$)').hasMatch(this)
        //&& this.length < 2
        ? true
        : false;
  }

  bool isMaxPlayers() {
    return RegExp(r'(^(?:[+0]9)?[0-9]+$)').hasMatch(this) && this.length < 3
        ? true
        : false;
  }

  bool isValidMobile() {
    return RegExp(r'(^(?:[+0]9)?[0-9]{2}$)').hasMatch(this);
  }

  bool isMaxPlayerSingleTeam() {
    return RegExp(r'(^(?:[+0]9)?[0-9]{1}$)').hasMatch(this);
  }

//  bool isValidTitle() {
//    return this.length > 0 ? true : false;
//  }

  bool isValidDescription() {
    return RegExp(r'^[a-zA-Z ]+$').hasMatch(this) &&
            this.length > 2 &&
            this.length < 250
        ? true
        : false;
  }

//  bool isValidDeadline() {
//    return this.length > 1 ? true : false;
//  }

  bool isValidContestCategory() {
    return RegExp(r'^[a-zA-Z ]+$').hasMatch(this) &&
            this.length > 2 &&
            this.length < 30
        ? true
        : false;
  }

  bool isValidMaxSingleTeam() {
    return this.length > 0 ? true : false;
  }

  bool isValidMaxPoints() {
    return this.length > 0 ? true : false;
  }

  bool isValidMaxPlayers() {
    return this.length > 0 ? true : false;
  }

  bool isValidMinPlayers() {
    return this.length > 0 ? true : false;
  }

  bool isValidPlayers() {
    return this.length > 0 ? true : false;
  }

  bool isValidVenue() {
    return this.length > 2 ? true : false;
  }

  bool isValidNumber() {
    return RegExp(r'(^[0-9]+$)').hasMatch(this) && this.length < 7
        ? true
        : false;
  }

  bool isEntryAmount() {
    return RegExp(r'(^[0-9]+$)').hasMatch(this) && this.length < 7
        ? true
        : false;
  }

  bool isMaxEntries() {
    return RegExp(r'(^[0-9]+$)').hasMatch(this) && this.length < 6
        ? true
        : false;
  }

  bool isMaxEntryPerUSer() {
    return RegExp(r'(^[0-9]+$)').hasMatch(this) && this.length < 4
        ? true
        : false;
  }

  bool isRankRangeStart() {
    return RegExp(r'(^[0-9]+$)').hasMatch(this) && this.length < 6
        ? true
        : false;
  }

  bool isValidDevice() {
    return RegExp(r'(^[0-9]*$)').hasMatch(this);
  }

  bool isValidScore() {
    return this.length > 0 ? true : false;
  }

  bool isValidGateNo() {
    return RegExp(r'(^[0-9]*$)').hasMatch(this);
  }

  bool isValidEntryAmount() {
    return this.length > 0 ? true : false;
  }

  bool isValidStatus() {
    return this.length >= 0 ? true : false;
  }

  bool isValidMaxEntries() {
    return this.length > 0 ? true : false;
  }

  bool isValidMaxEntryPerUser() {
    return this.length > 0 ? true : false;
  }

  bool isValidShortCode() {
    return this.length > 2 ? true : false;
  }

//  bool isValidFamilyNo() {
//    return RegExp(r'(^[0-9]*$)').hasMatch(this);
//  }

  bool isValidOwnerName() {
    return this.length > 2 ? true : false;
  }

  bool isValidDocument() {
    return RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}").hasMatch(this);
  }

  bool isValidAadhaar() {
    return RegExp(r'(^[0-9]{12}$)').hasMatch(this);
  }

  bool isValidGender() {
    return this.length > 0 ? true : false;
  }

  bool isValidOption() {
    return this.length > 1 ? true : false;
  }

  bool isValidConfirmPassword() {
    return this.length > 1 ? true : false;
  }

  bool validDocumentType() {
    return this.length > 1 ? true : false;
  }
}
