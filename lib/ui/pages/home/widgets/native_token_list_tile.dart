import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/current_native_balance/current_native_balance_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/ui/tokens/placeholders.dart';

class NativeTokenListTile extends StatelessWidget {
  const NativeTokenListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentNativeBalanceBloc>(
      create: (context) => CurrentNativeBalanceBloc(injector.get(), injector.get(), injector.get(), injector.get(),)..add(CurrentNativeBalanceRequested())..add(CurrentNativeBalanceVisibilityRequested()),
      child: const _NativeTokenListTile(),
    );
  }
}

class _NativeTokenListTile extends StatelessWidget {
  const _NativeTokenListTile();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentNativeBalanceBloc,CurrentNativeBalanceState>(
      builder: (context, state) {
      final isVisible = state.isVisible;
      
      return ListTile(
        title: Text(state.ticker),
        trailing: 
        isVisible?
        Text('${state.accountBalance?.toEther()} ${state.ticker}'):
        Text(Placeholders.hiddenBalancePlaceholder)
        ,
      );
      },
    );
  }
}
