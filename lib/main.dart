import 'package:flutter/material.dart';
import 'package:stock_manager_app/drawer_menu.dart';
import 'package:stock_manager_app/stock_page.dart';

import 'pages/wallet_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PageView(
        controller: _pageController,
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text("Wallet"),
            ),
            body: WalletPage(),
            drawer: DrawerMenu(_pageController),
          ),
          Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text("Stocks"),
            ),
            body: StockPage(),
            drawer: DrawerMenu(_pageController),
          )
        ],
      ),
    );
  }
}
