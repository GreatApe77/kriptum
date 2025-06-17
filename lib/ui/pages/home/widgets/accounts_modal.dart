import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/account_list/account_list_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/ui/widgets/account_tile_widget.dart';

class AccountsModal extends StatelessWidget {
  const AccountsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountListBloc>(
      create: (context) => AccountListBloc(
        injector.get(),
      )..add(AccountListRequested()),
      child: _AccountsModalView(),
    );
  }
}

class _AccountsModalView extends StatelessWidget {
  const _AccountsModalView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountListBloc, AccountListState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              Text(
                'Accounts',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.accounts.length,
                  itemBuilder: (context, index) {
                    return AccountTileWidget(
                      account: state.accounts[index],
                      includeMenu: true,
                      isSelected: false,
                      onSelected: () {},
                      onOptionsMenuSelected: () {},
                    );
                  },
                ),
              )
            ],
          ),
          /* child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Accounts',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Expanded(
                child: ListenableBuilder(
                    listenable: widget.accountsController,
                    builder: (context, child) {
                      return ListenableBuilder(
                          listenable: widget.currentAccountController,
                          builder: (context, child) {
                            return ListView.builder(
                                itemCount:
                                    widget.accountsController.accounts.length,
                                itemBuilder: (context, index) => AccountTile(
                                    includeMenu: true,
                                    onOptionsMenuSelected: () {
                                      showModalBottomSheet(
                                        showDragHandle: true,
                                        context: context,
                                        builder: (context) => SafeArea(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                onTap: () async {
                                                  final String? nameResult =
                                                      await Navigator.of(
                                                              context)
                                                          .push(
                                                              MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateAccountAliasScreen(
                                                            account: widget
                                                                .accountsController
                                                                .accounts[index]),
                                                  ));

                                                  Account updatedAccount =
                                                      widget.accountsController
                                                          .accounts[index]
                                                          .copyWith(
                                                              alias:
                                                                  nameResult);
                                                  await widget
                                                      .accountsController
                                                      .updateAccount(index,
                                                          updatedAccount);
                                                  if (updatedAccount.address ==
                                                      widget
                                                          .currentAccountController
                                                          .connectedAccount
                                                          ?.address) {
                                                    widget
                                                        .currentAccountController
                                                        .updateAccount(
                                                            updatedAccount);
                                                  }
                                                  if (!context.mounted) return;
                                                  Navigator.of(context).pop();
                                                },
                                                leading: const Icon(Icons.edit),
                                                title: const Text(
                                                    'Edit account name'),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    isSelected: widget.currentAccountController
                                            .connectedAccount?.accountIndex ==
                                        widget.accountsController
                                            .accounts[index].accountIndex,
                                    onSelected: () async {
                                      await widget.settingsController
                                          .changeCurrentAccountIndex(widget
                                              .accountsController
                                              .accounts[index]
                                              .accountIndex);
                                      widget.currentAccountController
                                          .updateAccount(widget
                                              .accountsController
                                              .accounts[index]);
                                      final account = widget
                                          .currentAccountController
                                          .connectedAccount;
                                      final network = widget
                                          .currentNetworkController
                                          .currentConnectedNetwork;
                                      widget.accountBalanceController
                                          .loadAccountBalance(
                                              account!.address, network!);
                                      if (!context.mounted) return;
                                      Navigator.of(context).pop();
                                    },
                                    account: widget
                                        .accountsController.accounts[index]));
                          });
                    }),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: AppSpacings.horizontalPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          _showCreateNewAccountBottomSheet(context);
                        },
                        child: const Text('Add or Import Account')),
                  ],
                ),
              )
            ],
          ), */
        );
      },
    );
  }
}
