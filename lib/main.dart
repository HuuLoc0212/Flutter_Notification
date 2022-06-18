import 'dart:convert';

import 'package:day32/models/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> notifications = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/notifications.json');
    final data = await json.decode(response);

    setState(() {
      notifications = data['notifications']
          .map((data) => InstagramNotification.fromJson(data))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Notification",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
        ),
        body: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: notificationItem(notifications[index]),
                secondaryActions: <Widget>[
                  // Container(
                  //     height: 60,
                  //     color: Colors.grey.shade500,
                  //     child: Icon(
                  //       Icons.info_outline,
                  //       color: Colors.white,
                  //     )),
                  // Container(
                  //     height: 60,
                  //     color: Colors.red,
                  //     // decoration: BoxDecoration(
                  //     //     borderRadius: BorderRadius.circular(23)),
                  //     child: Icon(
                  //       Icons.delete_outline_sharp,
                  //       color: Colors.white,
                  //     )),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(1.0, 30),
                      shadowColor: Colors.grey,
                      primary: Colors.red,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(23.0),
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              );
            }));
  }

  notificationItem(InstagramNotification notification) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                notification.hasStory
                    ? Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            shape: BoxShape.circle),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(notification.profilePic)),
                        ),
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(notification.profilePic)),
                      ),
                // Padding(
                //   padding: EdgeInsets.all(4),
                //   child: Text('l'),
                // ),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: notification.name,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: notification.content,
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text: notification.timeAgo,
                      style: TextStyle(color: Colors.grey.shade500),
                    )
                  ])),
                )
              ],
            ),
          ),
          notification.postImage != ''
              ? Container(
                  width: 40,
                  height: 60,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        'assets/avatar.jpg',
                      )),
                  // thay the bang image.network
                )
              : Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 88, 162, 237),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                      child: Text('Follow',
                          style: TextStyle(color: Colors.white)))),
        ],
      ),
    );
  }
}
