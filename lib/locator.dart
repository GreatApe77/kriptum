import 'package:get_it/get_it.dart';
import 'package:kriptum/ui/controllers/create_wallet_steps_controller.dart';
import 'package:kriptum/ui/controllers/navigation_bar_controller.dart';

final locator = GetIt.instance;
void setup(){
  locator.registerFactory(() => CreateWalletStepsController());
  locator.registerCachedFactory(() => NavigationBarController(),);
}