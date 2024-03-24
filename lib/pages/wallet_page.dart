import 'package:flutter/material.dart';
import 'package:stock_manager_app/controllers/wallet_controller.dart';
import 'package:stock_manager_app/models/wallet.dart';

class WalletPage extends StatelessWidget {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Balance ${wallet.balance}",
            style: const TextStyle(fontSize: 20),
          ),
        )),
        Flexible(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: wallet.stocks.length,
            itemBuilder: (_, int index) {
              var stock = wallet.stocks[index];
              // return ListTile(title: Text(stock.symbol));

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
