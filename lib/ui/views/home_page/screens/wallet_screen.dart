import 'package:flutter/material.dart';
import 'package:kriptum/controllers/account_balance_controller.dart';

import 'package:kriptum/controllers/accounts_controller.dart';
import 'package:kriptum/controllers/current_account_controller.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/networks_controller.dart';
import 'package:kriptum/controllers/settings_controller.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/utils/format_address.dart';
import 'package:kriptum/ui/shared/utils/format_ether.dart';
import 'package:kriptum/ui/shared/controllers/copy_to_clipboard_controller.dart';
import 'package:kriptum/ui/shared/widgets/account_tile.dart';
import 'package:kriptum/ui/shared/widgets/networks_list.dart';
import 'package:kriptum/ui/views/home_page/widgets/account_viewer_btn.dart';
import 'package:kriptum/ui/views/home_page/widgets/main_balance_view_.dart';

class WalletScreen extends StatefulWidget {
  final AccountsController accountsController;
  final SettingsController settingsController;
  final AccountBalanceController accountBalanceController;
  final NetworksController networksController;
  final CurrentNetworkController currentNetworkController;
  final CurrentAccountController currentAccountController;
  const WalletScreen({
    super.key,
    required this.accountsController,
    required this.settingsController,
    required this.accountBalanceController,
    required this.networksController,
    required this.currentNetworkController,
    required this.currentAccountController,
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
    widget.currentNetworkController.addListener(_onNetworkChange);
    _loadCurrentNetwork();
    _loadNetworks();
    _loadAccounts();
  }

  @override
  void dispose() {
    super.dispose();
    widget.currentNetworkController.removeListener(_onNetworkChange);
  }

  void _loadAccounts() async {
    widget.accountsController.loadAccounts();
  }

  void _onNetworkChange() async {
    await widget.currentAccountController.loadCurrentAccount(
        widget.settingsController.settings.lastConnectedIndex);
    final accountAddress =
        widget.currentAccountController.connectedAccount?.address;
    widget.accountBalanceController.loadAccountBalance(accountAddress!,
        widget.currentNetworkController.currentConnectedNetwork!);
  }

  void _loadCurrentNetwork() {
    final connectedNetworkId =
        widget.settingsController.settings.lastConnectedChainId;
    widget.currentNetworkController
        .loadCurrentConnectedNetwork(connectedNetworkId);
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
        title: ListenableBuilder(
            listenable: widget.currentAccountController,
            builder: (context, child) {
              if (widget.currentAccountController.connectedAccount == null) {
                return const CircularProgressIndicator();
              }
              return AccountViewerBtn(
                account: widget.currentAccountController.connectedAccount!,
                onPressed: () => _showAccountsModal(context),
              );
            }),
        leadingWidth: 100,
        leading: TextButton.icon(
            onPressed: () => _showNetworksModal(context),
            label: ListenableBuilder(
                listenable: widget.currentNetworkController,
                builder: (context, child) {
                  return Text(
                    widget.currentNetworkController.currentConnectedNetwork ==
                            null
                        ? 'Loading...'
                        : widget.currentNetworkController
                            .currentConnectedNetwork!.name,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  );
                })),
        actions: [
          ListenableBuilder(
              listenable: widget.currentAccountController,
              builder: (context, child) {
                return IconButton(
                    onPressed:
                        widget.currentAccountController.connectedAccount == null
                            ? null
                            : () => copyToClipboardController.copyToClipboard(
                                  content: widget.currentAccountController
                                      .connectedAccount!.address,
                                  onCopied: (content) =>
                                      _onCopyToClipboard(content),
                                ),
                    icon: const Icon(Icons.copy));
              }),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.qr_code_scanner_rounded))
        ],
      ),
      body: Container(
          padding: AppSpacings.horizontalPadding,
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: MainBalanceView(
              accountBalanceController: widget.accountBalanceController)),
    );
  }

  void _onCopyToClipboard(String content) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Builder(builder: (context) {
          return FutureBuilder(
              future: Future.delayed(const Duration(seconds: 1))
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
                        'Public address ${formatAddress(widget.currentAccountController.connectedAccount!.address)} copied to clipboard',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              });
        });
      },
    );
  }

  void _showNetworksModal(BuildContext context) {
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
  }

  void _showAccountsModal(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Accounts',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.accountsController.accounts.length,
                  itemBuilder: (context, index) => AccountTile(
                      isSelected: widget.currentAccountController
                              .connectedAccount?.accountIndex ==
                          widget
                              .accountsController.accounts[index].accountIndex,
                      onSelected: () {},
                      account: widget.accountsController.accounts[index])),
            ),
            Padding(
              padding: AppSpacings.horizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _showCreateNewAccountDialog(context);
                      },
                      child: const Text('Add account')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showCreateNewAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create a password for this account'),
        content: const TextField(
          obscureText: true,
          decoration: InputDecoration(label: Text('Password')),
        ),
        contentPadding: AppSpacings.horizontalPadding,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Create'))
        ],
      ),
    );
  }

  void _triggerCreateNewAccount(BuildContext context) {}

  void _onNetworkChooseSideEffect(BuildContext context) {
    Navigator.pop(context);
  }
}
