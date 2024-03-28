import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_manager_app/stock/controllers/stock_controller.dart';
import 'package:stock_manager_app/stock/models/search_stock_output.dart';

class StockPage extends StatefulWidget {
  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final StockController stockController = StockController();
  final TextEditingController textEditingController = TextEditingController();

  SearchStockOutput? searchedStock;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    labelText: "Ticker to search...",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ElevatedButton(
                  child: const Text("Search"),
                  onPressed: () async {
                    var result = await stockController
                        .searchStock(textEditingController.value.text);
                    setState(() {
                      searchedStock = result;
                    });
                  },
                ),
              )
            ],
          ),
          searchedStock != null ? buildForm() : const Text("No data to show")
        ],
      ),
    );
  }

  Widget buildForm() {
    final TextEditingController textEditingControllerQuantity =
        TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Price: ${searchedStock!.price}"),
        Text("Date: ${searchedStock!.date}"),
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: textEditingControllerQuantity,
            decoration: const InputDecoration(
              labelText: "Quantity to buy",
            ),
            keyboardType: const TextInputType.numberWithOptions(),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^-?\d+')),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
            child: const Text("Buy"),
            onPressed: () {
              stockController.buyStock(
                textEditingController.value.text,
                int.parse(textEditingControllerQuantity.value.text),
              );
            },
          ),
        )
      ],
    );
  }
}
