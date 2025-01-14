import 'package:flutter/material.dart';
import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/domain/models/account.dart';

class CurrentAccountController extends ChangeNotifier {
  Account? _connectedAccount;
  Account? get connectedAccount => _connectedAccount;
  final AccountRepository _accountRepository;

  CurrentAccountController({
    required AccountRepository accountRepository,
  }) : _accountRepository = accountRepository;

  loadCurrentAccount(int accountIndex) async {
    _connectedAccount = await _accountRepository.getAccount(accountIndex);
    notifyListeners();
  }
}
