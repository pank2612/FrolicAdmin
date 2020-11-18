import 'package:flutter/material.dart';

class ScoreScreen extends StatefulWidget {
  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.height * 0.10,
            bottom: MediaQuery.of(context).size.height * 0.20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Card(
                  elevation: 5,
                  //color: Colors.grey,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.20),
                              child: Text("Search:",
                                  style: TextStyle(
                                    fontSize: 17,
                                  )),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Row(
                              children: [
                                Text(
                                  "SCORES",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.lightBlue),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.112,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: TextField(
                                      // controller: controller,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.white,
                                        filled: true,
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            margin: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.115),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.08,
                            color: Colors.grey.shade300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                numbers("#"),
                                normalText("Match"),
                                normalText("Player"),
                                normalText("WT"),
                                normalText("0s"),
                                normalText("BF"),
                                normalText("Dismissal"),
                                normalText("Rs"),
                                normalText("Sr"),
                                normalText("Ob"),
                                normalText("Ec"),
                                normalText("4s"),
                                normalText("6s"),
                                normalText("Ro"),
                                normalText("Ct"),
                                normalText("Action"),
                              ],
                            ),
                          ),
                          Text("No data available in table"),
//                          Expanded(
//                            child: ListView.builder(
//                              itemBuilder: (context, index) {
//                                return Column(
//                                  children: [
//                                    Container(
//                                      padding: EdgeInsets.symmetric(
//                                          horizontal: 12, vertical: 2),
//                                      width: MediaQuery.of(context).size.width,
//                                      height:
//                                          MediaQuery.of(context).size.height *
//                                              0.1,
//                                      child: Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.spaceBetween,
//                                        children: [
//                                          numbers("${index + 1}"),
//                                          normalText("AB-CD"),
//                                          normalText("Jumbo"),
//                                          normalText("25"),
//                                          normalText("20000"),
//                                          normalText("10"),
//                                          Container(
//                                              width: MediaQuery.of(context)
//                                                      .size
//                                                      .width *
//                                                  0.08,
//                                              child: Row(
//                                                children: [
//                                                  Icon(
//                                                    Icons.close,
//                                                    color: Colors.red.shade700,
//                                                  ),
//                                                  Icon(
//                                                    Icons.mode_edit,
//                                                    color: Colors.orange,
//                                                  )
//                                                ],
//                                              )),
//                                        ],
//                                      ),
//                                    ),
//                                    Divider(
//                                      thickness: 1,
//                                    )
//                                  ],
//                                );
//                              },
//                              itemCount: 3,
//                            ),
//                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Showing 0 to 0 of 0 entries"),
                                Row(
                                  children: [
                                    MaterialButton(
                                      onPressed: () {},
                                      color: Colors.lightBlue,
                                      child: Text(
                                        "Previous",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
//                                    MaterialButton(
//                                      onPressed: () {},
//                                      color: Colors.lightBlue,
//                                      child: Text(
//                                        "1",
//                                        style: TextStyle(color: Colors.white),
//                                      ),
                                    //                                   ),
                                    MaterialButton(
                                      color: Colors.lightBlue,
                                      onPressed: () {},
                                      child: Text(
                                        "Next",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RaisedButton(
                              color: Colors.lightBlue,
                              child: Text(
                                "COPY",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RaisedButton(
                              color: Colors.lightBlue,
                              child: Text(
                                "EXCEL",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget normalText(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.05,
      child: Text(
        name,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        //maxLines: 2,
      ),
    );
  }

  Widget numbers(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.02,
      child: Text(
        name,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
