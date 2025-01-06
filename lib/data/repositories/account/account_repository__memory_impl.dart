import 'package:kriptum/data/repositories/account/account_repository.dart';
import 'package:kriptum/domain/models/account.dart';

 class AccountRepositoryMemoryImpl implements AccountRepository {
  final List<Account> data = [];
  @override
  Future<void> saveAccount(Account account) async {
    data.add(account);

  }
  
  @override
  Future<Account> getAccount(int index)async {
    return data[index];
  }
  
  
}
