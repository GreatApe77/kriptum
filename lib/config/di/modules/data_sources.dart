import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/infra/datasources/accounts_data_source.dart';
import 'package:kriptum/infra/datasources/accounts_data_source_impl.dart';
import 'package:kriptum/infra/datasources/contacts_data_source.dart';
import 'package:kriptum/infra/datasources/contacts_data_source_impl.dart';
import 'package:kriptum/infra/datasources/erc20_token_balance_data_source.dart';
import 'package:kriptum/infra/datasources/erc20_token_balance_data_source_impl.dart';
import 'package:kriptum/infra/datasources/erc20_tokens_data_source.dart';
import 'package:kriptum/infra/datasources/native_balance_data_source.dart';
import 'package:kriptum/infra/datasources/native_balance_data_source_impl.dart';
import 'package:kriptum/infra/datasources/networks_data_source.dart';
import 'package:kriptum/infra/datasources/networks_data_source_impl.dart';
import 'package:kriptum/infra/datasources/erc20_tokens_data_source_impl.dart';
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
