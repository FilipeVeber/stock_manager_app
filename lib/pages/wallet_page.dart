import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_manager_app/controllers/stock_controller.dart';
import 'package:stock_manager_app/controllers/wallet_controller.dart';
import 'package:stock_manager_app/models/wallet.dart';

class WalletPage extends StatefulWidget {
  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  WalletController walletController = WalletController();

  StockController stockController = StockController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: walletController.getWallet(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            return snapshot.hasData
                ? buildDataLayout(snapshot.data!)
                : const Center(child: Text("No data was found"));
          default:
            return const Center(
                child: Text("Error. Default clause reached. Try again!"));
        }
      },
    );
  }

  Widget buildDataLayout(Wallet wallet) {
    final TextEditingController textEditingController = TextEditingController();
    final TextEditingController textEditingControllerQuantity =
        TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Balance: ${wallet.balance}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: textEditingController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Enter Amount',
                    prefixText: '\$',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                child: const Text("Add funds"),
                onPressed: () async {
                  await walletController
                      .addFunds(double.parse(textEditingController.value.text));

                  setState(() {});
                },
              ),
              ElevatedButton(
                child: const Text("Remove funds"),
                onPressed: () async {
                  await walletController.removeFunds(
                      double.parse(textEditingController.value.text));

                  setState(() {});
                },
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: wallet.stocks.length,
            itemBuilder: (_, int index) {
              var stock = wallet.stocks[index];
              return Card(
                child: ListTile(
                  title: Row(
                    children: [
                      Text(stock.symbol),
                      const Text(" - "),
                      Text("Quantity: ${stock.quantity}"),
                      const Text(" - "),
                      Expanded(child: Text("Avg price: ${stock.averagePrice}")),
                      ElevatedButton(
                        child: const Text("Sell"),
                        onPressed: () async {
                          await stockController.sellStock(
                              stock.symbol,
                              int.parse(
                                  textEditingControllerQuantity.value.text));

                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          controller: textEditingControllerQuantity,
                          decoration: const InputDecoration(
                            labelText: "Quantity",
                          ),
                          keyboardType: const TextInputType.numberWithOptions(),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^-?\d+')),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        child: const Text("Buy"),
                        onPressed: () async {
                          await stockController.buyStock(
                              stock.symbol,
                              int.parse(
                                  textEditingControllerQuantity.value.text));

                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
