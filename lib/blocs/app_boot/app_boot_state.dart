// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_boot_bloc.dart';

enum AppBootStatus {
  unknown,
  noWallet,
  lockedWallet,
}

class AppBootState {
  final AppBootStatus appBootStatus;

  AppBootState({required this.appBootStatus});

  AppBootState copyWith({
    AppBootStatus? appBootStatus,
  }) {
    return AppBootState(
      appBootStatus: appBootStatus ?? this.appBootStatus,
    );
  }
}
