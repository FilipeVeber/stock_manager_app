import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_manager_app/models/search_stock_output.dart';

abstract class IStockService {
  Future<SearchStockOutput> searchStock(String symbol);

  Future buyStock(String symbol, int quantity);

  Future sellStock(String symbol, int quantity);
}

class StockService implements IStockService {
  @override
  Future<SearchStockOutput> searchStock(String symbol) async {
    var stock;

    final response = await http
        .get(Uri.parse('https://web-api.fly.dev/api/stock/quote/$symbol'));

    if (response.statusCode == 200) {
      stock = SearchStockOutput.fromMap(
          jsonDecode(response.body) as Map<String, dynamic>);
    }

    return stock;
  }

  @override
  Future buyStock(String symbol, int quantity) async {
    await http.post(
      Uri.parse('https://web-api.fly.dev/api/stock/buy'),
      body: jsonEncode({"symbol": symbol, "quantity": quantity.toString()}),
      headers: <String, String>{"Content-Type": "application/json"},
    );
  }

  @override
  Future sellStock(String symbol, int quantity) async {
    await http.post(
      Uri.parse('https://web-api.fly.dev/api/stock/sell'),
      body: jsonEncode({"symbol": symbol, "quantity": quantity.toString()}),
      headers: <String, String>{"Content-Type": "application/json"},
    );
  }
}
