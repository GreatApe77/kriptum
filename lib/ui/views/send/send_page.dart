// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:kriptum/controllers/account_balance_controller.dart';
import 'package:kriptum/controllers/accounts/accounts_controller.dart';
import 'package:kriptum/controllers/accounts/current_account_controller.dart';
import 'package:kriptum/controllers/contacts/contacts_controller.dart';
import 'package:kriptum/controllers/current_network_controller.dart';
import 'package:kriptum/controllers/send/send_amount_controller.dart';
import 'package:kriptum/controllers/send/send_transaction_controller.dart';
import 'package:kriptum/controllers/send/to_address_controller.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/controllers/eth_address_validator_controller.dart';
import 'package:kriptum/ui/shared/utils/format_address.dart';
import 'package:kriptum/ui/shared/utils/format_ether.dart';
import 'package:kriptum/ui/shared/widgets/account_tile.dart';
import 'package:kriptum/ui/views/send/screens/amount_screen.dart';
import 'package:kriptum/ui/views/send/widgets/page_title.dart';

class SendPage extends StatefulWidget {
  final CurrentAccountController currentAccountController;
  final AccountBalanceController accountBalanceController;
  final AccountsController accountsController;
  final CurrentNetworkController currentNetworkController;
  final SendAmountController sendAmountController;
  final ToAddressController toAddressController;
  final ContactsController contactsController;
  final SendTransactionController sendTransactionController;

  const SendPage(
      {super.key,
      required this.currentAccountController,
      required this.accountsController,
      required this.currentNetworkController,
      required this.accountBalanceController,
      required this.sendAmountController,
      required this.toAddressController,
      required this.sendTransactionController,
      required this.contactsController});

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final TextEditingController ethAddressFieldController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    widget.contactsController.loadContacts();
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
        title: PageTitle(
          title: 'Send to',
          networkName:
              widget.currentNetworkController.currentConnectedNetwork!.name,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacings.horizontalPadding,
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
                          title: Text(
                              '${widget.currentAccountController.connectedAccount?.alias ?? widget.currentAccountController.connectedAccount!.accountIndex + 1}'),
                          subtitle: Text(
                              'Balance: ${formatEther(widget.accountBalanceController.balance)} ${widget.currentNetworkController.currentConnectedNetwork?.ticker}'),
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
                        key: formKey,
                        child: TextFormField(
                          validator: (value) =>
                              EthAddressValidatorController.validateEthAddress(
                                  value ?? ''),
                          controller: ethAddressFieldController,
                          onChanged: (value) {
                            widget.toAddressController.setToAddress(value);
                          },
                          decoration: const InputDecoration(
                              label: Text('Ethereum Address'),
                              border: OutlineInputBorder()),
                        ),
                      ))
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
                  child: ListenableBuilder(
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
                      })),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                      onPressed: () => _onNextStep(context),
                      child: const Text('Next')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onNextStep(BuildContext context) {
    if (!formKey.currentState!.validate()) return;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AmountScreen(
          sendTransactionController: widget.sendTransactionController,
          toAddressController: widget.toAddressController,
          currentAccountController: widget.currentAccountController,
          sendAmountController: widget.sendAmountController,
          accountBalanceController: widget.accountBalanceController,
          currentNetworkController: widget.currentNetworkController),
    ));
  }

  void _onContactTapped(Contact contact) {
    ethAddressFieldController.text = contact.address;
    widget.toAddressController.setToAddress(contact.address);
  }

  void _onAccountTapped(Account account) {
    ethAddressFieldController.text = account.address;
    widget.toAddressController.setToAddress(account.address);
  }
}
