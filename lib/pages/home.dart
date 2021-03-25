import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:websocket_tracker/services/socket/client.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    SocketIOClient client = SocketIOClient("http://localhost:10000/sys");
    client.connect();
    client.onEvent("SYSTEM_STATUS").listen((event) {
      print(JsonEncoder.withIndent('  ').convert(event.data));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
