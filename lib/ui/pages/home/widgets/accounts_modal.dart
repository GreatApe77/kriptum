import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/account_list/account_list_bloc.dart';
import 'package:kriptum/blocs/current_account/current_account_cubit.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/domain/models/account.dart';
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
          create: (context) =>
              CurrentAccountCubit(injector.get())..requestCurrentAccount(),
        ),
      ],
      child: _AccountsModalView(),
    );
    /* return BlocProvider<AccountListBloc>(
      create: (context) => AccountListBloc(
        injector.get(),
      )..add(AccountListRequested()),
      child: _AccountsModalView(),
    ); */
  }
}

class _AccountsModalView extends StatelessWidget {
  const _AccountsModalView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountListBloc, AccountListState>(
      builder: (context, listState) {
        return BlocBuilder<CurrentAccountCubit, CurrentAccountState>(
          builder: (context, currentAccountState) {
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
                      itemCount: listState.accounts.length,
                      itemBuilder: (context, index) {
                        return AccountTileWidget(
                          account: listState.accounts[index],
                          includeMenu: true,
                          isSelected:
                              currentAccountState.account?.accountIndex ==
                                  listState.accounts[index].accountIndex,
                          onSelected: () {
                            context
                                .read<CurrentAccountCubit>()
                                .changeCurrentAccount(
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
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAccountOptionsModal({
    required BuildContext context,
    required Account account,
  }) {
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
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
