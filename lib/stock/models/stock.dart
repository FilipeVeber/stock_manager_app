class Stock {
  final String symbol;
  final int quantity;
  final double averagePrice;

  Stock(this.symbol, this.quantity, this.averagePrice);

  factory Stock.fromMap(Map<String, dynamic> json) {
    return Stock(json["symbol"], json["quantity"], json["averagePrice"]);
  }
}
