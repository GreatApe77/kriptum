import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/native_balance/bloc/native_balance_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MainBalanceViewer extends StatelessWidget {
  const MainBalanceViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NativeBalanceBloc>(
      create: (context) => NativeBalanceBloc()..add(NativeBalanceRequested()),
      child: _MainBalanceViewer(),
    );
  }
}

class _MainBalanceViewer extends StatelessWidget {
  const _MainBalanceViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NativeBalanceBloc, NativeBalanceState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is NativeBalanceLoading,
          child: Text('Test'),
        );
      },
    );
  }
}
