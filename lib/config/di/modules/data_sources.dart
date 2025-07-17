import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/infra/datasources/data_sources.dart';

Future<void> registerDataSources() async {
  injector.registerLazySingleton<AccountsDataSource>(
    () => AccountsDataSourceImpl(
      sqlDatabase: injector.get(),
    ),
  );
  injector.registerLazySingleton<NetworksDataSource>(
    () => NetworksDataSourceImpl(injector.get()),
  );
  injector.registerLazySingleton<NativeBalanceDataSource>(
    () => NativeBalanceDataSourceImpl(
      injector.get(),
    ),
  );
  injector.registerLazySingleton<ContactsDataSource>(
    () => ContactsDataSourceImpl(
      injector.get(),
    ),
  );
  injector.registerLazySingleton<Erc20TokensDataSource>(
    () => Erc20TokensDataSourceImpl(
      injector.get(),
    ),
  );
  injector.registerLazySingleton<Erc20TokenBalanceDataSource>(
    () => Erc20TokenBalanceDataSourceImpl(
      injector.get(),
    ),
  );
}
