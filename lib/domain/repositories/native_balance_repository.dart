import 'package:kriptum/domain/models/network.dart';

abstract interface class NativeBalanceRepository {
  Future<String> getNativeBalanceOfAccount({
    required String accountAddress,
    required Network network,
  });
}
