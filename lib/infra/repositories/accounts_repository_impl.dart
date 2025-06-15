import 'dart:async';

import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/infra/datasources/accounts_data_source.dart';
import 'package:kriptum/infra/persistence/user_preferences/user_preferences.dart';
import 'package:kriptum/shared/contracts/disposable.dart';

class AccountsRepositoryImpl implements AccountsRepository, Disposable {
  final AccountsDataSource _accountsDataSource;
  final UserPreferences _userPreferences;
  final _currentAccountStream = StreamController<Account>.broadcast();
  AccountsRepositoryImpl({
    required AccountsDataSource accountsDataSource,
    required UserPreferences userPreferences,
  })  : _accountsDataSource = accountsDataSource,
        _userPreferences = userPreferences {
    _initializeCurrentAccountStream();
  }

  @override
  Stream<Account> currentAccountStream() {
    // TODO: implement currentAccountStream
    throw UnimplementedError();
  }

  @override
  Future<List<Account>> getAccounts() async {
    return await _accountsDataSource.getAllAccounts();
  }

  @override
  Future<void> saveAccounts(List<Account> accounts) async {
    await _accountsDataSource.insertAccounts(accounts);
  }

  Future<void> _initializeCurrentAccountStream() async {
    final accountId = await _userPreferences.getSelectedAccountId();
    final account = await _accountsDataSource.getAccountById(accountId);
    if (account != null) {
      _currentAccountStream.add(account);
    }
  }

  @override
  Future<void> dispose()async {
    _currentAccountStream.close();
  }
}
