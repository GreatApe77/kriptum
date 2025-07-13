import 'package:kriptum/blocs/app_boot/app_boot_bloc.dart';
import 'package:kriptum/blocs/unlock_wallet/unlock_wallet_bloc.dart';
import 'package:kriptum/config/di/injector.dart';

Future<void> registerPresenters() async {
  /* injector.registerFactory<AppBootBloc>(
    () => AppBootBloc(accountsRepository: injector.get()),
  ); */
  injector.registerFactory<UnlockWalletBloc>(
    () => UnlockWalletBloc(
      unlockWalletUsecase: injector.get(),
    ),
  );
}
