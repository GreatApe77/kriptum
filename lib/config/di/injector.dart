import 'package:get_it/get_it.dart';
import 'package:kriptum/domain/accounts_repository.dart';
import 'package:kriptum/infra/fake_accounts_repository.dart';

final injector = GetIt.instance;
Future<void> initInjector() async {
  injector..registerLazySingleton<AccountsRepository>(
    () => FakeAccountsRepository(),
  );
}
