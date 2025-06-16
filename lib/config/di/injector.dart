import 'package:get_it/get_it.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/services/account_generator_service.dart';
import 'package:kriptum/domain/usecases/confirm_and_save_generated_accounts_usecase.dart';
import 'package:kriptum/domain/usecases/generate_accounts_preview_usecase.dart';
import 'package:kriptum/infra/datasources/accounts_data_source.dart';
import 'package:kriptum/infra/datasources/accounts_data_source_impl.dart';
import 'package:kriptum/infra/persistence/user_preferences/shared_preferences/user_preferences_impl.dart';
import 'package:kriptum/infra/persistence/user_preferences/user_preferences.dart';
import 'package:kriptum/infra/repositories/accounts_repository_impl.dart';
import 'package:kriptum/infra/repositories/fake_accounts_repository.dart';
import 'package:kriptum/infra/persistence/database/sql_database.dart';
import 'package:kriptum/infra/persistence/database/sqflite/sqflite_database.dart';
import 'package:kriptum/infra/services/account_generator_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;
Future<void> initInjector() async {
  injector.registerLazySingleton<SqlDatabase>(
    () => SqfliteDatabase(),
  );
  injector.registerLazySingleton<AccountGeneratorService>(
    () => AccountGeneratorServiceImpl(),
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  injector.registerLazySingleton<UserPreferences>(
    () => UserPreferencesImpl(
      sharedPreferences: sharedPreferences,
    ),
  );
  injector.registerLazySingleton<AccountsDataSource>(
    () => AccountsDataSourceImpl(
      sqlDatabase: injector.get(),
    ),
  );
  injector.registerLazySingleton<AccountsRepository>(
    () => AccountsRepositoryImpl(
      accountsDataSource: injector.get(),
      userPreferences: injector.get(),
    ),
  );
  injector.registerLazySingleton<GenerateAccountsPreviewUsecase>(
    () => GenerateAccountsPreviewUsecase(
      accountGenerator: injector.get(),
      accountsRepository: injector.get(),
    ),
  );
  injector.registerLazySingleton<ConfirmAndSaveGeneratedAccountsUsecase>(
    () => ConfirmAndSaveGeneratedAccountsUsecase(
      accountsRepository: injector.get(),
    ),
  );
}
