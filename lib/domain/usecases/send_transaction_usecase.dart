import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';
import 'package:kriptum/domain/repositories/password_repository.dart';
import 'package:kriptum/domain/services/transaction_service.dart';

class SendTransactionUsecase {
  final AccountsRepository _accountsRepository;
  final PasswordRepository _passwordRepository;
  final NetworksRepository _networksRepository;
  final TransactionService _transactionService;
  SendTransactionUsecase(
    this._accountsRepository,
    this._passwordRepository,
    this._networksRepository,
    this._transactionService,
  );

  Future<TransactionOutput> execute(SendTransactionUsecaseParams params) async {
    final account = await _accountsRepository.getCurrentAccount();
    if (account == null) {
      throw DomainException('Account is null');
    }
    final currentNetwork = await _networksRepository.getCurrentNetwork();
    final encryptionPassword = _passwordRepository.getPassword();
    final txHash = await _transactionService.sendTransaction(
      encryptedJsonAccount: account.encryptedJsonWallet,
      password: encryptionPassword,
      to: params.to,
      amountInWei: params.amount,
      rpcUrl: currentNetwork.rpcUrl,
    );
    String? transactionUrl;
    if (currentNetwork.blockExplorerUrl != null) {
      //====TEMPORARY SOLUTION====
      String txPath = 'tx';
      if(currentNetwork.id==4002){
        txPath='transactions';
      }
      //==========================
      transactionUrl = '${currentNetwork.blockExplorerUrl}/$txPath/$txHash';
    }
    final txOutput = TransactionOutput(
      transactionHash: txHash,
      transactionUrlInBlockExplorer: transactionUrl,
    );
    return txOutput;
  }
}

class SendTransactionUsecaseParams {
  final String to;
  final BigInt amount;

  SendTransactionUsecaseParams({
    required this.to,
    required this.amount,
  });
}

class TransactionOutput {
  final String transactionHash;
  final String? transactionUrlInBlockExplorer;

  TransactionOutput({
    required this.transactionHash,
    this.transactionUrlInBlockExplorer,
  });
}
