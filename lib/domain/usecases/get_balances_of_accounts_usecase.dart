import 'package:kriptum/domain/models/ether_amount.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/repositories/native_balance_repository.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';

class GetBalancesOfAccountsUsecase {
  final AccountsRepository _accountsRepository;
  final NativeBalanceRepository _nativeBalanceRepository;
  final NetworksRepository _networksRepository;
  GetBalancesOfAccountsUsecase(
    this._accountsRepository,
    this._nativeBalanceRepository,
    this._networksRepository,
  );

  Future<Map<String, EtherAmount>> execute() async {
    final accounts = await _accountsRepository.getAccounts();
    final currentNetwork = await _networksRepository.getCurrentNetwork();
    final Map<String, EtherAmount> balanceOf = {};
    final List<Future<EtherAmount>> requests = [];
    for (final account in accounts) {
      requests.add(
        _nativeBalanceRepository.getNativeBalanceOfAccount(
          accountAddress: account.address,
          network: currentNetwork,
        ),
      );
    }
    final result = await Future.wait(requests);

    for (int i = 0; i < accounts.length; i++) {
      //accountWithBalance.add(AccountWithBalance(account: accounts[i], balance: result[i]));
      balanceOf[accounts[i].address] = result[i];
    }

    return balanceOf;
  }
}
