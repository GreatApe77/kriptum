import 'package:flutter/material.dart';
import 'package:kriptum/data/services/url_launcher_services.dart';
import 'package:kriptum/domain/models/account.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/shared/utils/datetime_helper.dart';
import 'package:kriptum/ui/shared/controllers/copy_to_clipboard_controller.dart';
import 'package:kriptum/ui/shared/utils/format_address.dart';
import 'package:kriptum/ui/shared/utils/format_ether.dart';

class TransactionInfoDialog extends StatefulWidget {
  TransactionInfoDialog(
      {super.key,
      required this.network,
      required this.from,
      required this.toAddress,
      required this.transactionHash,
      required this.amount,
      required this.dateTime});
  final Network network;
  final Account from;
  final String toAddress;
  final String transactionHash;
  final BigInt amount;
  final DateTime dateTime;
  @override
  State<TransactionInfoDialog> createState() => _TransactionInfoDialogState();
}

class _TransactionInfoDialogState extends State<TransactionInfoDialog> {
  final CopyToClipboardController copyToClipboardController =
      CopyToClipboardController();
  bool copiedToClipboard = false;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelMedium;
    return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 1),
        content: Builder(builder: (context) {
          var width = MediaQuery.of(context).size.width;
          return SizedBox(
            width: width - 100,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status',
                          style: labelStyle,
                        ),
                        const Text('Confirmed'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Date',
                          style: labelStyle,
                        ),
                        Text(DatetimeHelper.getReadableDate(
                            widget.dateTime.toUtc().toLocal())),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: labelStyle,
                        ),
                        Text(formatAddress(widget.from.address)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('To', style: labelStyle),
                        Text(formatAddress(widget.toAddress)),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Transaction Hash'),
                  subtitle: Text(
                    widget.transactionHash,
                    overflow: TextOverflow.clip,
                  ),
                  trailing: copiedToClipboard
                      ? IconButton(
                          onPressed: () {}, icon: const Icon(Icons.check))
                      : IconButton(
                          onPressed: () {
                            copyToClipboardController.copyToClipboard(
                              content: widget.transactionHash,
                              onCopied: (content) {
                                setState(() {
                                  copiedToClipboard = true;
                                });
                                Future.delayed(
                                  const Duration(seconds: 1),
                                  () {
                                    setState(() {
                                      copiedToClipboard = false;
                                    });
                                  },
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.copy)),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Amount'),
                  trailing: Text(
                    '${formatEther(widget.amount)} ${widget.network.ticker}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const Spacer(),
                widget.network.blockExplorerUrl != null
                    ? TextButton(
                        onPressed: () async {
                          await _triggerViewTxOnBlockExplorer(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                textAlign: TextAlign.center,
                                'View on ${widget.network.blockExplorerName ?? 'Block Explorer'}'),
                          ],
                        ))
                    : Container(),
              ],
            ),
          );
        }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sent ${widget.network.ticker}'),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close))
          ],
        ));
  }

  _triggerViewTxOnBlockExplorer(BuildContext context) async {
    await UrlLauncherServices.launchInBrowser(
        '${widget.network.blockExplorerUrl}/tx/${widget.transactionHash}');
  }
}
