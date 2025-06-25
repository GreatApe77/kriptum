import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:kriptum/blocs/account_list/account_list_bloc.dart';
import 'package:kriptum/blocs/current_account/current_account_cubit.dart';
import 'package:kriptum/blocs/current_network/current_network_cubit.dart';
import 'package:kriptum/blocs/native_balance/native_balance_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/ui/pages/home/widgets/accounts_modal.dart';
import 'package:kriptum/ui/pages/send_native/widgets/page_title.dart';
import 'package:kriptum/ui/tokens/placeholders.dart';
import 'package:kriptum/ui/tokens/spacings.dart';
import 'package:kriptum/ui/widgets/account_tile_widget.dart';
import 'package:kriptum/ui/widgets/ethereum_address_text_field.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ChooseRecipientWidget extends StatelessWidget {
  const ChooseRecipientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrentAccountCubit>(
          create: (context) =>
              CurrentAccountCubit(injector.get())..requestCurrentAccount(),
        ),
        BlocProvider<NativeBalanceBloc>(
          create: (context) => NativeBalanceBloc(
            injector.get(),
            injector.get(),
            injector.get(),
            injector.get(),
          )
            ..add(NativeBalanceRequested())
            ..add(NativeBalanceVisibilityRequested()),
        ),
        BlocProvider<CurrentNetworkCubit>(
          create: (context) =>
              CurrentNetworkCubit(injector.get())..requestCurrentNetwork(),
        ),
        BlocProvider<AccountListBloc>(
          create: (context) =>
              AccountListBloc(injector.get())..add(AccountListRequested()),
        )
      ],
      child: const _ChooseRecipientWidget(),
    );
  }
}

class _ChooseRecipientWidget extends StatefulWidget {
  const _ChooseRecipientWidget();

  @override
  State<_ChooseRecipientWidget> createState() => _ChooseRecipientWidgetState();
}

class _ChooseRecipientWidgetState extends State<_ChooseRecipientWidget> {
  final _toAddressController = TextEditingController();

  @override
  void dispose() {
    _toAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'))
        ],
        title: BlocBuilder<CurrentNetworkCubit, CurrentNetworkState>(
          builder: (context, state) {
            String content = '';
            if (state is CurrentNetworkLoaded) {
              content = state.network.name;
            }
            return PageTitle(
              title: 'Send to',
              networkName: content,
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'From: ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Flexible(
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),

                          //  width: 0.1,
                          //    color: Theme.of(context).colorScheme.onSurface),

                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              isScrollControlled: true,
                              showDragHandle: true,
                              builder: (context) {
                                return const AccountsModal();
                              },
                            );
                          },
                          leading: BlocBuilder<CurrentAccountCubit,
                              CurrentAccountState>(
                            builder: (context, state) {
                              if (state.account == null) {
                                return SizedBox.shrink();
                              }
                              return Jazzicon.getIconWidget(
                                Jazzicon.getJazziconData(
                                  40,
                                  address: state.account?.address,
                                ),
                              );
                            },
                          ),
                          title: BlocBuilder<CurrentAccountCubit,
                              CurrentAccountState>(
                            builder: (context, state) {
                              if (state.account == null) {
                                return SizedBox.shrink();
                              }
                              return Text(state.account?.alias ?? '');
                            },
                          ),
                          subtitle: BlocBuilder<NativeBalanceBloc,
                              NativeBalanceState>(
                            builder: (context, state) {
                              String content = '';
                              switch (state.status) {
                                case NativeBalanceStatus.loading:
                                  content = '........';
                                  break;
                                case NativeBalanceStatus.loaded:
                                  content =
                                      '${state.accountBalance?.toReadableString(5)} ${state.ticker}';
                                  break;
                                case NativeBalanceStatus.error:
                                  content = 'error';
                                default:
                              }
                              if (!state.isVisible) {
                                content = Placeholders.hiddenBalancePlaceholder;
                              }
                              return Skeletonizer(
                                enabled:
                                    state.status == NativeBalanceStatus.loading,
                                child: Text(content),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'To: ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Flexible(
                        child: Form(
                          child: EthereumAddressTextField(
                            controller: _toAddressController,
                          ),
                          //key: formKey,
                          /*  child: TextFormField(
                            // validator: (value) =>
                            //     EthAddressValidatorController.validateEthAddress(
                            //         value ?? ''),
                            //controller: ethAddressFieldController,
                            onChanged: (value) {
                              // widget.toAddressController.setToAddress(value);
                            },
                            decoration: const InputDecoration(
                              label: Text('Ethereum Address'),
                              border: OutlineInputBorder(),
                            ),
                          ), */
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              // const Text(
              //   'Your Accounts',
              //   style: TextStyle(fontSize: 22),
              // ),
              const SizedBox(
                height: 18,
              ),
              // Expanded(
              //     child: ListView.builder(
              //   itemCount: accountsController.accounts.length,
              //   itemBuilder: (context, index) => AccountTile(
              //       onOptionsMenuSelected: () {},
              //       onSelected: () =>
              //           _onAccountTapped(accountsController.accounts[index]),
              //       account: accountsController.accounts[index]),
              // )),

              Expanded(
                child: BlocBuilder<AccountListBloc, AccountListState>(
                  builder: (context, accountsState) {
                    return ListView(
                      children: [
                        Text(
                          'Your Accounts',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        ...accountsState.accounts.map(
                          (e) => AccountTileWidget(
                            onSelected: () {},
                            account: e,
                            onOptionsMenuSelected: () {},
                          ),
                        )
                      ],
                    );
                  },
                ),
/*                 child: ListenableBuilder(
                  listenable: widget.contactsController,
                  builder: (context, child) {
                    return ListView(
                      children: [
                        const Text(
                          'Your Accounts',
                          style: TextStyle(fontSize: 22),
                        ),
                        ...widget.accountsController.accounts.map(
                          (account) => AccountTile(
                              onOptionsMenuSelected: () {},
                              onSelected: () => _onAccountTapped(account),
                              account: account),
                        ),
                        widget.contactsController.contacts.isEmpty
                            ? const SizedBox.shrink()
                            : const Text(
                                'Contacts',
                                style: TextStyle(fontSize: 22),
                              ),
                        ...widget.contactsController.contacts.map(
                          (contact) => ListTile(
                            title: Text(contact.name),
                            subtitle: Text(formatAddress(contact.address)),
                            leading: Jazzicon.getIconWidget(
                                Jazzicon.getJazziconData(40,
                                    address: contact.address)),
                            onTap: () => _onContactTapped(contact),
                          ),
                        )
                      ],
                    );
                  },
                ), */
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                      onPressed: () {},
                      //onPressed: () => _onNextStep(context),
                      child: const Text('Next')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
