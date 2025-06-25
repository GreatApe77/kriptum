import 'package:flutter/material.dart';
import 'package:kriptum/ui/pages/send_native/widgets/page_title.dart';
import 'package:kriptum/ui/tokens/spacings.dart';
import 'package:kriptum/ui/widgets/ethereum_address_text_field.dart';

class SendNativeWrapperPage extends StatelessWidget {
   SendNativeWrapperPage({super.key});
  final textEditingController = TextEditingController();
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
          networkName: 'opa',
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
                          title: Text('Minha conta'),
                          subtitle: Text('34.90000 ETH'),
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
                          child: EthereumAddressTextField(controller: textEditingController),
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
                child: Container(),
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
