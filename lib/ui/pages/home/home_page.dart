import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/current_account/current_account_cubit.dart';
import 'package:kriptum/blocs/current_network/current_network_cubit.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/shared/utils/copy_to_clipboard.dart';
import 'package:kriptum/shared/utils/format_address.dart';
import 'package:kriptum/shared/utils/show_snack_bar.dart';
import 'package:kriptum/ui/pages/home/widgets/account_viewer_btn.dart';
import 'package:kriptum/ui/pages/home/widgets/accounts_modal.dart';
import 'package:kriptum/ui/pages/home/widgets/main_balance_viewer.dart';
import 'package:kriptum/ui/pages/scan_qr_code/scan_qr_code_page.dart';
import 'package:kriptum/ui/tokens/spacings.dart';
import 'package:kriptum/ui/widgets/networks_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrentAccountCubit>(
          create: (context) => CurrentAccountCubit(injector.get())..requestCurrentAccount(),
        ),
        BlocProvider<CurrentNetworkCubit>(
          create: (context) => CurrentNetworkCubit(
            injector.get(),
          )..requestCurrentNetwork(),
        )
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: 100,
        leading: BlocConsumer<CurrentNetworkCubit, CurrentNetworkState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is CurrentNetworkLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CurrentNetworkLoaded) {
              return TextButton(
                onPressed: () => _buildNetworksListModal(context),
                child: Text(
                  state.network.name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                copyToClipboard(
                  content: context.read<CurrentAccountCubit>().state.account!.address,
                  onCopied: (text) => _onCopyToClipBoard(
                    text,
                    context,
                  ),
                );
              },
              icon: Icon(Icons.copy)),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ScanQrCodePage(),
                ),
              );
            },
            icon: Icon(Icons.qr_code),
          ),
        ],
        title: BlocBuilder<CurrentAccountCubit, CurrentAccountState>(
          builder: (context, state) {
            if (state.account == null) {
              return const CircularProgressIndicator();
            }
            return AccountViewerBtn(
              account: state.account!,
              onPressed: () {
                _showAccountsModal(context);
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacings.horizontalPadding,
        ),
        child: MainBalanceViewer(),
      ),
    );
  }

  void _showAccountsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return const AccountsModal();
      },
    );
  }

  Future<void> _buildNetworksListModal(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacings.horizontalPadding,
        ),
        child: NetworksList(
          onNetworkChosen: (network) {
            //ScaffoldMessenger.of(context)
            //  ..clearSnackBars()
            //  ..showSnackBar(
            //    SnackBar(
            //      content: Text('Network changed to ${network.name}'),
            //    ),
            //  );
            showSnackBar(
              message: 'Network changed to ${network.name}',
              context: context,
            );
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  void _onCopyToClipBoard(String text, BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Builder(
          builder: (context) {
            return FutureBuilder(
                future: Future.delayed(const Duration(seconds: 1)).then((value) => true),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Navigator.of(context).pop();
                  }
                  return AlertDialog(
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          size: 80,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Public address ${formatAddress(text)} copied to clipboard',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                });
          },
        );
      },
    );
  }
}
