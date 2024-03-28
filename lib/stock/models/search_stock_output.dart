class SearchStockOutput {
  final String price;
  final String date;

  SearchStockOutput(this.price, this.date);

  factory SearchStockOutput.fromMap(Map<String, dynamic> json) {
    return SearchStockOutput(json["price"], json["date"]);
  }
}
