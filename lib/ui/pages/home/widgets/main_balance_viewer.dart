import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/current_network/current_network_cubit.dart';
import 'package:kriptum/blocs/native_balance/native_balance_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/ui/tokens/placeholders.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MainBalanceViewer extends StatelessWidget {
  const MainBalanceViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NativeBalanceBloc>(
          create: (context) => NativeBalanceBloc(injector.get(), injector.get(), injector.get(), injector.get())
            ..add(
              NativeBalanceRequested(),
            )
            ..add(
              NativeBalanceVisibilityRequested(),
            ),
        ),
        BlocProvider<CurrentNetworkCubit>(
          create: (context) => CurrentNetworkCubit(
            injector.get(),
          )..requestCurrentNetwork(),
        )
      ],
      child: const _MainBalanceViewer(),
    );
  }
}

class _MainBalanceViewer extends StatelessWidget {
  const _MainBalanceViewer();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final currentNetworkCubit = context.watch<CurrentNetworkCubit>();
      final nativeBalanceBloc = context.watch<NativeBalanceBloc>();
      final currentNetworkState = currentNetworkCubit.state;
      final nativeBalanceState = nativeBalanceBloc.state;
      if (currentNetworkState is! CurrentNetworkLoaded) return SizedBox.shrink();
      String content = '';
      switch (nativeBalanceState.status) {
        case NativeBalanceStatus.error:
          content = nativeBalanceState.errorMessage ?? 'An error occurred';
          break;
        case NativeBalanceStatus.initial:
        case NativeBalanceStatus.loading:
          content = 'Loading...';
          break;
        case NativeBalanceStatus.loaded:
          content = nativeBalanceState.accountBalance!.toReadableString();
          break;
      }
      bool isVisible = nativeBalanceState.isVisible;
      content = '$content ${currentNetworkState.network.ticker}';
      if (!isVisible) {
        content = Placeholders.hiddenBalancePlaceholder;
      }
      return Skeletonizer(
        enabled: nativeBalanceState.status == NativeBalanceStatus.loading,
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
    });
  }
}
