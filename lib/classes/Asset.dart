class Asset {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double current_price;
  final double price_change_percentage_24h;
  final double circulating_supply;
  final int market_cap;
  final double total_volume;

  Asset(
      {this.id,
      this.symbol,
      this.name,
      this.image,
      this.current_price,
      this.price_change_percentage_24h,
      this.circulating_supply,
      this.market_cap,
      this.total_volume});

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
        id: json['id'],
        symbol: json['symbol'],
        name: json['name'],
        image: json['image'],
        current_price: json['current_price'].toDouble(),
        price_change_percentage_24h: json['price_change_percentage_24h'],
        circulating_supply: json['circulating_supply'],
        market_cap: json['market_cap'],
        total_volume: json['total_volume'].toDouble()
    );
  }

}
