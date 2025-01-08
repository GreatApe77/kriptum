// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/domain/models/account.dart';

class AccountsController extends ChangeNotifier {
  AccountRepository _accountRepository;
  
  Account? _connectedAccount;
  Account? get connectedAccount => _connectedAccount;
  //int accountIndex = 0;
  AccountsController({
    required AccountRepository accountRepository,
    
  }):_accountRepository=accountRepository;

  loadCurrentAccount(int accountIndex) async {
    _connectedAccount = await _accountRepository.getAccount(accountIndex);
    notifyListeners();
  }

}
