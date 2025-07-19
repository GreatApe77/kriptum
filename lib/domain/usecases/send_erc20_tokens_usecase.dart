import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/repositories/repositories.dart';
import 'package:kriptum/domain/services/erc20_token_service.dart';

class SendErc20TokensUsecase {
  final AccountsRepository _accountsRepository;
  final NetworksRepository _networksRepository;

  final Erc20TokenService _erc20TokenService;
  final PasswordRepository _passwordRepository;

  SendErc20TokensUsecase(
    this._accountsRepository,
    this._networksRepository,
    this._passwordRepository,
    this._erc20TokenService,
  );
  Future<String> execute(SendErc20TokensInput input) async {
    final account = await _accountsRepository.getCurrentAccount();
    if (account == null) {
      throw DomainException('Invalid account state');
    }
    final network = await _networksRepository.getCurrentNetwork();
    final decryptionPassword = _passwordRepository.getPassword();
    final transactionHash = await _erc20TokenService.transfer(
      contractAddress: input.erc20TokenAddress,
      amount: input.amount,
      rpcUrl: network.rpcUrl,
      encryptedWallet: account.encryptedJsonWallet,
      decryptionPassword: decryptionPassword,
      toAddress: input.toAddress,
    );
    return transactionHash;
  }
}

class SendErc20TokensInput {
  final String erc20TokenAddress;
  final String toAddress;
  final BigInt amount;

  SendErc20TokensInput({
    required this.erc20TokenAddress,
    required this.toAddress,
    required this.amount,
  });
}
