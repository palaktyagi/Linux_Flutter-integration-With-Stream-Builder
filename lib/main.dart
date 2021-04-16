import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Linux_SB/streampage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyApp(),
    ),
  );
}

String cmd;
var r;
var url;
var response;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String cmd;
  var r;
  void myweb(i) async {
    url = "http://192.168.137.52/cgi-bin/ankit.py?x=$i";
    response = await http.get(url);
    setState(() {
      r = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      title: new Text(
        'RHEL 8 आपका स्वागत करती है',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
      ),
      seconds: 6,
      navigateAfterSeconds: AfterSplash(),
      image: new Image.network(
          "https://www.redhat.com/cms/managed-files/img-rhel-8-hero-mobile.png"),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 160.0,
      loaderColor: Colors.blue.shade900,
    );
  }
}

class AfterSplash extends StatefulWidget {
  AfterSplash({Key key}) : super(key: key);

  @override
  _AfterSplashState createState() => _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
  String cmd;
  var r;
  void myweb(i) async {
    url = "http://192.168.137.52/cgi-bin/ankit.py?x=$i";
    response = await http.get(url);
    setState(() {
      r = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    var a = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://cdn.wallpapersafari.com/70/15/RjnYPw.png")),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 100),
                  Center(
                    child: Text(
                      "Linux Service With Stream Builder",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      cmd = value;
                    },
                    textAlign: TextAlign.left,
                    autocorrect: false,
                    autofocus: false,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.comment),
                      hintText: 'अपना linux कमांड डालें',
                    ),
                  ),
                  FlatButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onPressed: () {
                      a.collection("user").add(
                        {cmd: r},
                      );
                      print(r);
                      myweb(cmd);
                    },
                    child: Text("RUN"),
                    textColor: Colors.white,
                  ),
                  FlatButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => nextpage()));
                    },
                    child: Text("Stream"),
                    textColor: Colors.white,
                  ),
                  Text(
                    r ?? "Output will display here",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.white,
                        color: Colors.black),
                  ),
                ])
          ],
        ),
      ),
    );
  }
}
