import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_manager_app/wallet/models/wallet.dart';

abstract class IWalletService {
  Future<Wallet> getWallet();

  Future addFunds(double amount);

  Future removeFunds(double amount);
}

class WalletService implements IWalletService {
  @override
  Future<Wallet> getWallet() async {
    var wallet;

    final response =
        await http.get(Uri.parse('https://web-api.fly.dev/api/wallet'));

    if (response.statusCode == 200) {
      wallet =
          Wallet.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }

    return wallet;
  }

  @override
  Future addFunds(double amount) async {
    await http.put(
      Uri.parse('https://web-api.fly.dev/api/wallet/add-funds'),
      body: amount.toString(),
      headers: <String, String>{"Content-Type": "application/json"},
    );
  }

  @override
  Future removeFunds(double amount) async {
    await http.put(
      Uri.parse('https://web-api.fly.dev/api/wallet/remove-funds'),
      body: amount.toString(),
      headers: <String, String>{"Content-Type": "application/json"},
    );
  }
}
