import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/account_list/account_list_bloc.dart';
import 'package:kriptum/blocs/add_hd_wallet_account/add_hd_wallet_account_bloc.dart';
import 'package:kriptum/blocs/balances/balances_bloc.dart';
import 'package:kriptum/blocs/current_account/current_account_cubit.dart';
import 'package:kriptum/blocs/current_network/current_network_cubit.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/models/ether_amount.dart';
import 'package:kriptum/shared/utils/show_snack_bar.dart';
import 'package:kriptum/ui/pages/edit_account/edit_account_page.dart';
import 'package:kriptum/ui/tokens/spacings.dart';
import 'package:kriptum/ui/widgets/account_tile_widget.dart';

class AccountsModal extends StatelessWidget {
  const AccountsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountListBloc>(
          create: (context) => AccountListBloc(
            injector.get(),
          )..add(AccountListRequested()),
        ),
        BlocProvider<CurrentAccountCubit>(
          create: (context) => CurrentAccountCubit(injector.get())..requestCurrentAccount(),
        ),
        BlocProvider<AddHdWalletAccountBloc>(
          create: (context) => AddHdWalletAccountBloc(injector.get()),
        ),
        BlocProvider<BalancesBloc>(
          create: (context) => BalancesBloc(
            injector.get(),
            injector.get(),
            injector.get(),
          )..add(BalancesRequested()),
        ),
        BlocProvider<CurrentNetworkCubit>(
          create: (context) => CurrentNetworkCubit(
            injector.get(),
          )..requestCurrentNetwork(),
        ),
      ],
      child: _AccountsModalView(),
    );
  }
}

class _AccountsModalView extends StatelessWidget {
  const _AccountsModalView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Accounts',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Builder(builder: (context) {
            final currentAccountCubit = context.watch<CurrentAccountCubit>();
            final accountsListBloc = context.watch<AccountListBloc>();
            final balancesBloc = context.watch<BalancesBloc>();
            final networkCubit = context.watch<CurrentNetworkCubit>();
            final currentAccount = currentAccountCubit.state.account;
            final accountsList = accountsListBloc.state.accounts;
            final balancesState = balancesBloc.state;
            final currentNetworkState = networkCubit.state;
            String ticker = '';
            if (currentAccount == null) return SizedBox.shrink();
            if (currentNetworkState is CurrentNetworkLoaded) {
              ticker = currentNetworkState.network.ticker;
            }
            Map<String,EtherAmount> balanceOf = {};
            if(balancesState is BalancesLoaded){
              balanceOf = balancesState.balanceOf;
            }

            return Expanded(
              child: ListView.builder(
                itemCount: accountsList.length,
                itemBuilder: (context, index) {
                  return AccountTileWidget(
                    account: accountsList[index],
                    includeMenu: true,
                    balance: balanceOf[accountsList[index].address],
                    ticker: ticker,
                    isSelected: currentAccount.accountIndex == accountsList[index].accountIndex,
                    onSelected: () {
                      context.read<CurrentAccountCubit>().changeCurrentAccount(
                            accountsList[index],
                          );
                      Navigator.of(context).pop();
                    },
                    onOptionsMenuSelected: () => _showAccountOptionsModal(
                      context: context,
                      account: accountsList[index],
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
    /* return BlocBuilder<AccountListBloc, AccountListState>(
      builder: (context, listState) {
        return BlocBuilder<CurrentAccountCubit, CurrentAccountState>(
          builder: (context, currentAccountState) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Accounts',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listState.accounts.length,
                      itemBuilder: (context, index) {
                        return AccountTileWidget(
                          account: listState.accounts[index],
                          includeMenu: true,
                          isSelected:
                              currentAccountState.account?.accountIndex == listState.accounts[index].accountIndex,
                          onSelected: () {
                            context.read<CurrentAccountCubit>().changeCurrentAccount(
                                  listState.accounts[index],
                                );
                            Navigator.of(context).pop();
                          },
                          onOptionsMenuSelected: () => _showAccountOptionsModal(
                            context: context,
                            account: listState.accounts[index],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacings.horizontalPadding),
                    child: OutlinedButton(
                      onPressed: () {
                        _showCreateOrImportAccountBottomSheet(context);
                      },
                      child: const Text('Add or Import Account'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ); */
  }

  void _showCreateOrImportAccountBottomSheet(BuildContext context) {
    final bloc = context.read<AddHdWalletAccountBloc>();
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Add account',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                )
              ],
            ),
            BlocConsumer<AddHdWalletAccountBloc, AddHdWalletAccountState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is AddHdWalletAccountSuccess) {
                  Navigator.of(context).pop();
                }
                if (state is AddHdWalletAccountError) {
                  showSnackBar(
                    message: state.message,
                    context: context,
                    snackBarType: SnackBarType.error,
                  );
                }
              },
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(Icons.add),
                  enabled: state is! AddHdWalletAccountLoading,
                  // enabled: !widget.accountsController.addAccountLoading,
                  onTap: () => bloc.add(AddHdWalletAccountRequested()),
                  ////leading: widget.accountsController.addAccountLoading
                  /*  ? SizedBox(
                                        width:
                                            Theme.of(context).listTileTheme.minLeadingWidth,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context).colorScheme.onSurface,
                                        ),
                                      )
                                    : const Icon(Icons.add), */
                  title: const Text('Add new account'),
                );
              },
            ),
            ListTile(
              onTap: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //  builder: (context) {
                //return ImportAccountScreen(
                //    passwordController: widget.passwordController,
                //    accountsController: widget.accountsController);
                //  },
                //));
              },
              leading: const Icon(Icons.file_download_outlined),
              title: const Text('Import account'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAccountOptionsModal({
    required BuildContext context,
    required Account account,
  }) {
    final bloc = context.read<AccountListBloc>();
    showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text(
                'Edit account name',
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditAccountPage(
                      accountToBeEdited: account,
                      onAccountEditionCompleted: (editedAccount) {
                        bloc.add(
                          AccountsListUpdated(
                            updatedAccount: editedAccount,
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
