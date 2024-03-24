import 'package:stock_manager_app/models/wallet.dart';

import '../services/wallet_service.dart';

class WalletController {
  WalletService walletService = WalletService();

  Future<Wallet> getWallet() async {
    return walletService.getWallet();
  }
}
