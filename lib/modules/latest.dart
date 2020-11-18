import 'package:flutter/material.dart';

class Latest extends StatefulWidget {
  @override
  _LatestState createState() => _LatestState();
}

class _LatestState extends State<Latest> {
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
            // _addButton(),
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
                                      MediaQuery.of(context).size.width * 0.25),
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
                                  "USER MANAGEMENT",
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
                                normalText("Member"),
                                normalText("Email"),
                                normalText("Status"),
                                normalText("Created"),
                                normalText("Action"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 2),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          normalTextWithImage("Vishal Singh"),
                                          normalText("vishal@gmail.com"),
                                          normalText("Approved"),
                                          normalText("11th Nov 2020"),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.red.shade700,
                                                    size: 25,
                                                  ),
                                                  Icon(
                                                    Icons.mode_edit,
                                                    color: Colors.orange,
                                                    size: 25,
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    )
                                  ],
                                );
                              },
                              itemCount: 3,
                            ),
                          ),
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
                                    MaterialButton(
                                      onPressed: () {},
                                      color: Colors.lightBlue,
                                      child: Text(
                                        "1",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
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
      width: MediaQuery.of(context).size.width * 0.1,
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

  Widget normalTextWithImage(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      child: Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
//            width: 120,
//            height: 120,
            child: CircleAvatar(
              child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons"
                  "/thumb/d/d1/Icons8_flat_businessman.svg/768px-Icons8_flat_businessman.svg.png"),
            ),
          ),
          Text(
            name,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            //maxLines: 2,
          ),
        ],
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

  Widget _addButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      child: MaterialButton(
        // minWidth: MediaQuery.of(context).size.width * 0.10,
        onPressed: () {
//          Navigator.push(
//              context, MaterialPageRoute(builder: (context) => AddTeams()));
        },
        height: 50,
        // elevation: 10,
        // padding: EdgeInsets.symmetric(vertical: 10),
        color: Colors.lightBlue.shade300,
        child: Row(
          children: [
            Icon(
              Icons.navigation,
              color: Colors.white,
            ),
            Text(
              "Add Team",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
