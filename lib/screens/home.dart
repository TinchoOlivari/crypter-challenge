import 'dart:convert';
import 'package:crypter_challenge/classes/Asset.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Asset>> assets;
  bool isFetching = true;
  bool errorDetected = false;

  List crpytoSymbols = [
    'BTC',
    'ETH',
    'XRP',
    'USDT',
    'BCH',
    'BSV',
    'LTC',
    'EOS',
    'BNB',
    'XTZ',
    'OKB',
    'XMR',
    'MIOTA'
  ];

  Future<List<Asset>> fetchAlbum() async {
    final response = await http.get(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false');

    if (response.statusCode == 200) {
      setState(() {
        isFetching = true;
      });
      Iterable l = json.decode(response.body);
      List<Asset> crpyoAssets;
      List<Asset> selectedCrpyoAssets = [];

      crpyoAssets = List<Asset>.from(l.map((el) => Asset.fromJson(el)));
      crpyoAssets.forEach((element) {
        if (crpytoSymbols.contains(element.symbol.toUpperCase())) {
          selectedCrpyoAssets.add(element);
        }
      });

      return selectedCrpyoAssets;
    } else {
      setState(() {
        isFetching = true;
        errorDetected = true;
      });
      throw Exception('Error fetching API');
    }
  }

  Widget arrowUpOrDown(Asset data) {
    if (data.price_change_percentage_24h >= 0) {
      return Icon(Icons.arrow_drop_up, color: Colors.green);
    } else if (data.price_change_percentage_24h < 0){
      return Icon(Icons.arrow_drop_down, color: Colors.red);
    }
    return Container();
  }

  @override
  void initState() {
    assets = fetchAlbum();
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
        body: FutureBuilder<List<Asset>>(
          future: assets,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              width: 60,
                              image: snapshot.data[index].image,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                snapshot.data[index].name,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'USD',
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  Text(
                                    r'$' +
                                        snapshot.data[index].current_price
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '24hs',
                                  style: TextStyle(color: Colors.black45),
                                ),
                                Row(
                                  children: [
                                    arrowUpOrDown(snapshot.data[index]),
                                    Text(
                                      snapshot.data[index]
                                          .price_change_percentage_24h
                                          .toStringAsFixed(2) +
                                          r'%',
                                      style: TextStyle(
                                          color: snapshot.data[index]
                                              .price_change_percentage_24h >
                                              0
                                              ? Colors.green
                                              : Colors.red,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            }
            return Center(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(17, 33, 129, 1)),


                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text('Loading data from Coingecko'),
                )
              ],
            ));
          },
        ),
    );
  }
}
