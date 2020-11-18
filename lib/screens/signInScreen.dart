import 'package:flutter/material.dart';
import 'package:frolicsports/constants/textField.dart';
import 'package:frolicsports/constants/validator.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Container(
              width: _size.width * 0.40,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.07,
                    left: MediaQuery.of(context).size.width * 0.07,
                    top: MediaQuery.of(context).size.height * 0.250,
                    bottom: MediaQuery.of(context).size.height * 0.10),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Id",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                        softWrap: true,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      textField(
                          obscureText: false,
                          hintText: "Enter email",
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          inputValidate: ValidationKey.email,
                          isIconShow: false),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "We'll never share your email with someone else",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w200),
                        softWrap: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                        softWrap: true,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      textField(
                          obscureText: true,
                          maxline: 1,
                          hintText: "Password",
                          controller: _passwordController,
                          keyboardType: TextInputType.emailAddress,
                          inputValidate: ValidationKey.password,
                          isIconShow: false),
                      SizedBox(
                        height: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              _signIn();
                            },
                            height: 50,
                            // elevation: 10,
                            // padding: EdgeInsets.symmetric(vertical: 10),
                            color: Colors.lightBlue.shade300,
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: _size.width * 0.60,
              color: Colors.blueGrey.shade700,
              child: Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.07,
                    left: MediaQuery.of(context).size.width * 0.07,
                    top: MediaQuery.of(context).size.height * 0.350,
                    bottom: MediaQuery.of(context).size.height * 0.10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "SIGN IN TO GET",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Text(
                      "STARTED",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Text(
                      "Big data latte SpaceTeam unicorn cortado hacker physical",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "computing paradigm.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _signIn() {
    if (formKey.currentState.validate()) {}
  }
}
