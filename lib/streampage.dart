import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class nextpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var a = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Icon(Icons.notifications_active),
        ],
      ),
      body: ListView(children: [
        Column(
          children: [
            StreamBuilder<QuerySnapshot>(

                // ignore: missing_return
                builder: (context, snapshot) {
                  var com = snapshot.data.docs;
                  //print(com);
                  //print(d.data());
                  List<Widget> y = [];
                  for (var d in com) {
                    //print(d.data());
                    var comtext = d.data();
                    var comsender = d.data();
                    var comWidget = Text("$comtext is in $comsender");
                    y.add(comWidget);
                  }

                  print(y);

                  return SingleChildScrollView(
                    child: Container(
                      height: 8000,
                      width: 420,
                      color: Colors.red.shade900,
                      margin: EdgeInsets.symmetric(),
                      child: Column(
                        children: y,
                      ),
                    ),
                  );
                },
                stream: a.collection("user").snapshots())
          ],
        ),
      ]),
    );
  }
}
