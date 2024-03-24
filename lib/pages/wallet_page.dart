import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_manager_app/controllers/wallet_controller.dart';
import 'package:stock_manager_app/models/wallet.dart';

class WalletPage extends StatefulWidget {
  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  WalletController walletController = WalletController();

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
            return const Center(child: Text("Error. Default clause"));
        }
      },
    );
  }

  Widget buildDataLayout(Wallet wallet) {
    final TextEditingController textEditingController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Balance ${wallet.balance}",
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
                onPressed: () {
                  walletController
                      .addFunds(double.parse(textEditingController.value.text));
                },
              ),
              ElevatedButton(
                child: const Text("Remove funds"),
                onPressed: () {
                  walletController.removeFunds(
                      double.parse(textEditingController.value.text));
                },
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: wallet.stocks.length,
            itemBuilder: (_, int index) {
              var stock = wallet.stocks[index];
              return Card(
                child: Row(
                  children: [
                    Text(stock.symbol),
                    const SizedBox(width: 8),
                    Text("${stock.quantity}"),
                    const SizedBox(width: 8),
                    Text("${stock.averagePrice}"),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
