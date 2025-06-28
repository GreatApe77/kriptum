import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/native_balance/native_balance_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/ui/tokens/placeholders.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MainBalanceViewer extends StatelessWidget {
  const MainBalanceViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NativeBalanceBloc>(
      create: (context) => NativeBalanceBloc(injector.get(), injector.get(), injector.get(), injector.get())
        ..add(
          NativeBalanceRequested(),
        )
        ..add(
          NativeBalanceVisibilityRequested(),
        ),
      child: _MainBalanceViewer(),
    );
  }
}

class _MainBalanceViewer extends StatelessWidget {
  const _MainBalanceViewer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NativeBalanceBloc, NativeBalanceState>(
      builder: (context, state) {
        String content = '';
        /* if (state.status == NativeBalanceStatus.error) {
          content = state.errorMessage!;
        }
        if (state.status == NativeBalanceStatus.initial ||
            state.status == NativeBalanceStatus.loading) {
          content = 'Loading...';
        }
        if (state.status == NativeBalanceStatus.loaded) {
          content = state.accountBalance!.toReadableString();
        } */
        switch (state.status) {
          case NativeBalanceStatus.error:
            content = state.errorMessage ?? 'An error occurred';
            break;
          case NativeBalanceStatus.initial:
          case NativeBalanceStatus.loading:
            content = 'Loading...';
            break;
          case NativeBalanceStatus.loaded:
            content = state.accountBalance!.toReadableString();
            break;
        }
        bool isVisible = state.isVisible;
        if (!isVisible) {
          content = Placeholders.hiddenBalancePlaceholder;
        }
        return Skeletonizer(
          enabled: state.status == NativeBalanceStatus.loading,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  content,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<NativeBalanceBloc>().add(
                        ToggleNativeBalanceVisibility(isVisible: !isVisible),
                      );
                },
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
