import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/domain/factories/ethereum_address/ethereum_address.dart';
import 'package:kriptum/domain/factories/mnemonic_factory.dart';
import 'package:kriptum/domain/factories/password_factory.dart';
import 'package:kriptum/infra/factories/mnemonic_factory_impl.dart';
import 'package:kriptum/infra/factories/password_factory_impl.dart';
import 'package:kriptum/infra/validators/validators.dart';

Future<void> registerDomainFactories() async {
  injector.registerLazySingleton<MnemonicFactory>(
    () => MnemonicFactoryImpl(),
  );
  injector.registerLazySingleton<PasswordFactory>(
    () => PasswordFactoryImpl(),
  );
  injector.registerLazySingleton<EthereumAddressFactory>(
    () => EthereumAddressFactory(EthereumAddressValidatorImpl()),
  );
}
