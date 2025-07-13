part of 'import_account_bloc.dart';

sealed class ImportAccountEvent {}

final class ImportAccountRequested extends ImportAccountEvent {
  final String privateKey;

  ImportAccountRequested({required this.privateKey});
}
