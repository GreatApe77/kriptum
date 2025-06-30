import 'package:get_it/get_it.dart';
import 'package:kriptum/config/di/modules/data_sources.dart';
import 'package:kriptum/config/di/modules/domain_factories.dart';
import 'package:kriptum/config/di/modules/domain_services.dart';
import 'package:kriptum/config/di/modules/drivers.dart';
import 'package:kriptum/config/di/modules/repositories.dart';
import 'package:kriptum/config/di/modules/usecases.dart';

final injector = GetIt.instance;
Future<void> initInjector() async {
  await registerDrivers();
  await registerDataSources();
  await registerDomainServices();
  await registerDomainFactories();
  await registerRepositories();
  await registerUsecases();
}
