part of 'import_token_bloc.dart';

sealed class ImportTokenEvent {}

final class ValidEthereumAddressInputed extends ImportTokenEvent{
  final String contractAddress;

  ValidEthereumAddressInputed(this.contractAddress);
}
