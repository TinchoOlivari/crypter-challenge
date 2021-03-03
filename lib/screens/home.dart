import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(17, 33, 129, 1),
        centerTitle: true,
        title: Text('Rates',
            style: TextStyle(color: Color.fromRGBO(18, 237, 119, 1))),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Color.fromRGBO(18, 237, 119, 1),
            ),
            onPressed: () {
              print('Fav pressed');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.star,
              color: Color.fromRGBO(18, 237, 119, 1),
            ),
            onPressed: () {
              print('Search pressed');
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            color: Color.fromRGBO(18, 237, 119, 1),
          ),
          onPressed: () {
            print('Settings pressed');
          },
        ),
      ),
    );
  }
}
