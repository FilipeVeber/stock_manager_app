import 'package:stock_manager_app/wallet/models/wallet.dart';

import '../services/wallet_service.dart';

class WalletController {
  WalletService walletService = WalletService();

  Future<Wallet> getWallet() async {
    return walletService.getWallet();
  }

  Future addFunds(double amount) async {
    return walletService.addFunds(amount);
  }

  Future removeFunds(double amount) async {
    return walletService.removeFunds(amount);
  }
}
