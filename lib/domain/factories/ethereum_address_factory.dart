import 'package:kriptum/domain/models/ethereum_address.dart';
import 'package:kriptum/shared/contracts/factory.dart';
import 'package:kriptum/shared/utils/result.dart';

abstract interface class EthereumAddressFactory implements Factory<String, EthereumAddress, String> {
  @override
  Result<EthereumAddress, String> create(String address);
}
