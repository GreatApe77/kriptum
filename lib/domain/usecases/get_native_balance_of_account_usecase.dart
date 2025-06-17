import 'package:kriptum/domain/models/account_balance.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/repositories/native_balance_repository.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';

class GetNativeBalanceOfAccountUsecase {
  final AccountsRepository _accountsRepository;
  final NativeBalanceRepository _nativeBalanceRepository;
  final NetworksRepository _networksRepository;
  GetNativeBalanceOfAccountUsecase(
    this._accountsRepository,
    this._nativeBalanceRepository,
    this._networksRepository,
  );
  Future<AccountBalance> execute() async {
    final account = await _accountsRepository.getCurrentAccount();
    final network = await _networksRepository.getCurrentNetwork();
    return await _nativeBalanceRepository.getNativeBalanceOfAccount(
      accountAddress: account!.address,
      network: network,
    );
  }
}
