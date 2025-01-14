import 'package:flutter/material.dart';
import 'package:kriptum/controllers/account_balance_controller.dart';

import 'package:kriptum/controllers/accounts_controller.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/utils/format_address.dart';
import 'package:kriptum/ui/shared/utils/format_ether.dart';
import 'package:kriptum/ui/shared/controllers/copy_to_clipboard_controller.dart';
import 'package:kriptum/ui/shared/widgets/networks_list.dart';
import 'package:kriptum/ui/views/home_page/widgets/account_viewer_btn.dart';

class WalletScreen extends StatefulWidget {
  final AccountsController accountsController;
  final SettingsController settingsController;
  final AccountBalanceController accountBalanceController;
  final NetworksController networksController;
  final CurrentNetworkController currentNetworkController;
  const WalletScreen({
    super.key,
    required this.accountsController,
    required this.settingsController,
    required this.accountBalanceController,
    required this.networksController,
    required this.currentNetworkController,
  });

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final CopyToClipboardController copyToClipboardController =
      CopyToClipboardController();

  @override
  void initState() {
    super.initState();
    _loadCurrentNetwork();
    _loadNetworks();
  }

  void _loadCurrentNetwork() {
    final connectedNetworkId =
        widget.settingsController.settings.lastConnectedChainId;
    widget.networksController.loadCurrentConnectedNetwork(connectedNetworkId);
  }

  void _loadNetworks() {
    widget.networksController.loadNetworks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: AccountViewerBtn(
          account: widget.accountsController.connectedAccount!,
          onPressed: () {},
        ),
        leadingWidth: 100,
        leading: TextButton.icon(
            
            onPressed: () {
              showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  showDragHandle: true,
                  context: context,
                  builder: (context) => NetworksList(
                      onNetworkChooseSideEffect: () {
                        _onNetworkChooseSideEffect(context);
                      },
                      currentNetworkController: widget.currentNetworkController,
                      settingsController: widget.settingsController,
                      networksController: widget.networksController));
            },
            label: ListenableBuilder(
                listenable: widget.currentNetworkController,
                builder: (context, child) {
                  return Text(
                    widget.networksController.currentConnectedNetwork == null
                        ? 'Loading...'
                        : widget.currentNetworkController
                            .currentConnectedNetwork!.name,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  );
                })),
        actions: [
          IconButton(
              onPressed: () => copyToClipboardController.copyToClipboard(
                    content:
                        widget.accountsController.connectedAccount!.address,
                    onCopied: (content) {
                      showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Builder(builder: (context) {
                            return FutureBuilder(
                                future:
                                    Future.delayed(const Duration(seconds: 1))
                                        .then((value) => true),
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
                                          'Public address ${formatAddress(widget.accountsController.connectedAccount!.address)} copied to clipboard',
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  );
                                });
                          });
                        },
                      );
                    },
                  ),
              icon: const Icon(Icons.copy)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.qr_code_scanner_rounded))
        ],
      ),
      body: Container(
          padding: AppSpacings.horizontalPadding,
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListenableBuilder(
                  listenable: widget.accountBalanceController,
                  builder: (context, child) {
                    return Flexible(
                      child: Text(
                        formatEther(widget.accountBalanceController.balance),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 36),
                      ),
                    );
                  }),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_red_eye_rounded))
            ],
          )),
    );
  }

  void _onNetworkChooseSideEffect(BuildContext context) {
    Navigator.pop(context);
  }
}
