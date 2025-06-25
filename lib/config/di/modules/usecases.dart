import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/domain/usecases/add_contact_usecase.dart';
import 'package:kriptum/domain/usecases/add_hd_wallet_account_usecase.dart';
import 'package:kriptum/domain/usecases/confirm_and_save_generated_accounts_usecase.dart';
import 'package:kriptum/domain/usecases/generate_accounts_preview_usecase.dart';
import 'package:kriptum/domain/usecases/get_native_balance_of_account_usecase.dart';
import 'package:kriptum/domain/usecases/import_wallet_usecase.dart';
import 'package:kriptum/domain/usecases/lock_wallet_usecase.dart';
import 'package:kriptum/domain/usecases/reset_wallet_usecase.dart';
import 'package:kriptum/domain/usecases/unlock_wallet_usecase.dart';

Future<void> registerUsecases() async {
  injector.registerLazySingleton<GenerateAccountsPreviewUsecase>(
    () => GenerateAccountsPreviewUsecase(
        accountGenerator: injector.get(), passwordRepository: injector.get()),
  );
  injector.registerLazySingleton<ConfirmAndSaveGeneratedAccountsUsecase>(
    () => ConfirmAndSaveGeneratedAccountsUsecase(
      accountsRepository: injector.get(),
      encryptionService: injector.get(),
      mnemonicRepository: injector.get(),
      passwordRepository: injector.get(),
    ),
  );
  injector.registerLazySingleton<ResetWalletUsecase>(
    () => ResetWalletUsecase(
      accountsRepository: injector.get(),
    ),
  );
  injector.registerLazySingleton<UnlockWalletUsecase>(
    () => UnlockWalletUsecase(
      accountsRepository: injector.get(),
      accountDecryptionWithPasswordService: injector.get(),
      passwordRepository: injector.get(),
    ),
  );
  injector.registerLazySingleton<GetNativeBalanceOfAccountUsecase>(
    () => GetNativeBalanceOfAccountUsecase(
      injector.get(),
      injector.get(),
      injector.get(),
    ),
  );
  injector.registerLazySingleton<ImportWalletUsecase>(
    () => ImportWalletUsecase(
      injector.get(),
      injector.get(),
      injector.get(),
      injector.get(),
      injector.get(),
      injector.get(),
    ),
  );
  injector.registerLazySingleton<AddContactUsecase>(
    () => AddContactUsecase(
      injector.get(),
      injector.get(),
    ),
  );
  injector.registerLazySingleton<AddHdWalletAccountUsecase>(
    () => AddHdWalletAccountUsecase(
      injector.get(),
      injector.get(),
      injector.get(),
      injector.get(),
      injector.get(),
      injector.get(),
    ),
  );
  injector.registerLazySingleton<LockWalletUsecase>(
    () => LockWalletUsecase(
      injector.get(),
      injector.get(),
    ),
  );
}
