import 'package:stock_manager_app/stock/models/search_stock_output.dart';
import 'package:stock_manager_app/stock/services/stock_service.dart';

class StockController {
  StockService stockService = StockService();

  Future<SearchStockOutput> searchStock(String symbol) {
    return stockService.searchStock(symbol);
  }

  Future buyStock(String symbol, int quantity) {
    return stockService.buyStock(symbol, quantity);
  }

  Future sellStock(String symbol, int quantity) {
    return stockService.sellStock(symbol, quantity);
  }
}
