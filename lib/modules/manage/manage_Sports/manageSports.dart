import 'package:flutter/material.dart';
import 'package:frolicsports/constants/config.dart';
import 'package:frolicsports/models/sportsModel.dart';
import 'package:frolicsports/modules/manage/manage_Sports/addSports.dart';
import 'package:frolicsports/services/getSports.dart';
import 'package:firebase/firebase.dart' as fb;

class ManageSportsScreen extends StatefulWidget {
  @override
  _ManageSportsScreenState createState() => _ManageSportsScreenState();
}

class _ManageSportsScreenState extends State<ManageSportsScreen> {
  bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    getSportData();
  }

  SportsModelList sportsModelList = SportsModelList();
  GetSports getSports = GetSports();
  getSportData() async {
    sportsModelList = await getSports.getSports1();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.height * 0.10,
            bottom: MediaQuery.of(context).size.height * 0.10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _addButton(),
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
                                  "SPORTS",
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
                                normalText("Name"),
                                normalText("Short Name"),
                                normalText("Picture"),
                                normalText("Action"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: _loading == true
                                ? Center(child: CircularProgressIndicator())
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                      SportsModel sportsModel =
                                          sportsModelList.sportsModel[index];
                                      return Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 2),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                numbers("${index + 1}"),
                                                normalText(sportsModel.name
                                                    .toString()),
                                                normalText(sportsModel.shortCode
                                                    .toString()),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                    child: StreamBuilder(
                                                      stream: downloadUrl(
                                                              sportsModel.logo
                                                                  .toString())
                                                          .asStream(),
                                                      builder:
                                                          (context, snapShot) {
//                                                        print(
//                                                            "logo is ${sportsModel.logo.length}");
                                                        if (snapShot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              width: 120,
                                                              height: 120,
                                                              child: CircleAvatar(
                                                                  child:
                                                                      CircularProgressIndicator()));
                                                        } else if (!snapShot
                                                            .hasData) {
                                                          return Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            width: 200,
                                                            height: 200,
                                                            child: CircleAvatar(
                                                              radius: 30,
                                                              backgroundColor:
                                                                  Colors.red,
//                                                              child: Image.network(
//                                                                  snapShot.data
//                                                                      .toString()),
                                                            ),
                                                          );
                                                        } else if (snapShot
                                                            .hasData) {
                                                          return Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            width: 150,
                                                            height: 150,
                                                            child: CircleAvatar(
                                                              radius: 30,
                                                              child:
                                                                  Image.network(
                                                                snapShot.data
                                                                    .toString(),
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        return null;
                                                      },
                                                    )),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.close,
                                                          color: Colors
                                                              .red.shade700,
                                                        ),
                                                        Icon(
                                                          Icons.mode_edit,
                                                          color: Colors.orange,
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
                                    itemCount: sportsModelList.sportsModel ==
                                            null
                                        ? 0
                                        : sportsModelList.sportsModel.length,
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
      width: MediaQuery.of(context).size.width * 0.08,
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

  Widget _addButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      child: MaterialButton(
        // minWidth: MediaQuery.of(context).size.width * 0.10,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSports()));
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
              "Add Sports",
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

  Future<Uri> downloadUrl(String photoUrl) {
    return fb
        .storage()
        .refFromURL(REF_FROM_URL)
        .child("${STORAGE_FOLDER_SPORT + photoUrl}")
        .getDownloadURL();
  }
}
