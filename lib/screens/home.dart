import 'dart:convert';
import 'package:crypter_challenge/classes/Asset.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Asset> assets;
  bool isFetching = true;
  bool errorDetected = false;

  Future<http.Response> fetchAlbum() async {
    final response = await http.get('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false');

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      assets = List<Asset>.from(l.map((model)=> Asset.fromJson(model)));
      setState(() {
        isFetching = true;
      });
    } else {
      print('Error fetching API');
      setState(() {
        isFetching = true;
        errorDetected = true;
      });
    }

  }

  @override
  void initState() {
    fetchAlbum();
    super.initState();
  }


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
