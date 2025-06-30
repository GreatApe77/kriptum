import 'package:kriptum/domain/factories/ethereum_address_factory.dart';
import 'package:kriptum/domain/models/ethereum_address.dart';
import 'package:kriptum/shared/utils/result.dart';
import 'package:web3dart/web3dart.dart' as web3;

class EthereumAddressFactoryImpl implements EthereumAddressFactory {
  ///
  /// Creates an instance of [EthereumAddress] from a string representation.
  /// Returns a [Result] containing the [EthereumAddress] on success,
  /// or an error message on failure.
  @override
  Result<EthereumAddress, String> create(String address) {
    try {
      web3.EthereumAddress.fromHex(address);
      final ethereumAddress = EthereumAddress(address);
      return Result.success(ethereumAddress);
    } on ArgumentError catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure('Invalid Ethereum Address: ${e.toString()}');
    }
  }
}
