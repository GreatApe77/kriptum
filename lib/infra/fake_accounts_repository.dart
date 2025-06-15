import 'package:kriptum/domain/accounts_repository.dart';
import 'package:kriptum/domain/models/account.dart';

class FakeAccountsRepository implements AccountsRepository {
  final sampleAccounts = [
    Account(
      accountIndex: 0,
      address: '0xFakeAddress',
      encryptedJsonWallet: '{"fake": "wallet"}',
      alias: 'Fake Alias',
      isImported: false,
    ),
  ];
  @override
  Stream<Account> currentAccountStream() {
    return Stream.value(sampleAccounts.first);
   
  }

  @override
  Future<List<Account>> getAccounts() {
    return Future.value(sampleAccounts);
    //return Future.value([]);
  }
}
