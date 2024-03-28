import 'package:stock_manager_app/stock/models/stock.dart';

class Wallet {
  final double balance;
  final List<Stock> stocks;

  Wallet(this.balance, this.stocks);

  factory Wallet.fromJson(Map<String, dynamic> json) {
    var x = List<Stock>.from(json["stocks"].map((map) => Stock.fromMap(map)));

    return Wallet(
        json["balance"],
        json["stocks"] == null
            ? List<Stock>.empty()
            : List<Stock>.from(
                json["stocks"].map((map) => Stock.fromMap(map))));
  }
}
