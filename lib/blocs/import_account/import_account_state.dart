part of 'import_account_bloc.dart';

sealed class ImportAccountState {}

final class ImportAccountInitial extends ImportAccountState {}

final class ImportAccountLoading extends ImportAccountState {}

final class ImportAccountFailed extends ImportAccountState {
  final String errorMessage;

  ImportAccountFailed({required this.errorMessage});
}

final class ImportAccountSuccess extends ImportAccountState {}
