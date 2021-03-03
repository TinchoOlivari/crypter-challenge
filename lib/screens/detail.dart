import 'package:flutter/material.dart';
import 'package:crypter_challenge/classes/Asset.dart';

class DetailScreen extends StatefulWidget {
  final Asset asset;

  DetailScreen({Key key, @required this.asset}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(235, 131, 33, 1),
        centerTitle: true,
        title: Text(widget.asset.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Market capital',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  r'$' + widget.asset.market_cap.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Circulating',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                      widget.asset.circulating_supply.toString() +
                          ' ' +
                          widget.asset.symbol,
                      style: TextStyle(fontSize: 18, color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
