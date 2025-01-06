import 'package:get_it/get_it.dart';
import 'package:kriptum/controllers/create_new_wallet_controller.dart';
import 'package:kriptum/data/services/wallet_services.dart';
import 'package:kriptum/ui/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/controllers/navigation_bar_controller.dart';

final locator = GetIt.instance;
void setup() {
  locator.registerFactory(() => CreateWalletStepsController());
  locator.registerCachedFactory(
    () => NavigationBarController(),
  );
  locator.registerCachedFactory(() => WalletServices());
  locator.registerSingleton(
      CreateNewWalletController(walletServices: locator.get<WalletServices>()));
}
