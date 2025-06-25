import 'package:kriptum/domain/repositories/accounts_repository.dart';
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

  @override
  Future<void> saveAccounts(List<Account> accounts) {
    // TODO: implement saveAccounts
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllAccounts() {
    // TODO: implement deleteAllAccounts
    throw UnimplementedError();
  }

  @override
  Future<Account?> getCurrentAccount() {
    // TODO: implement getCurrentAccount
    throw UnimplementedError();
  }

  @override
  Future<void> changeCurrentAccount(Account? account)async {
    // TODO: implement changeCurrentAccount
    throw UnimplementedError();
  }

  @override
  Future<void> updateAccount(Account account) {
    // TODO: implement updateAccount
    throw UnimplementedError();
  }

  @override
  Stream<List<Account>> watchAccounts() {
    // TODO: implement watchAccounts
    throw UnimplementedError();
  }
  
  @override
  Future<int> getCurrentIndex() {
    // TODO: implement getCurrentIndex
    throw UnimplementedError();
  }
}
