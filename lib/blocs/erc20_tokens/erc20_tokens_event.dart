part of 'erc20_tokens_bloc.dart';


sealed class Erc20TokensEvent {}

final class _Erc20TokensRefreshed extends Erc20TokensEvent {}

final class Erc20TokensLoadRequested extends Erc20TokensEvent {}

