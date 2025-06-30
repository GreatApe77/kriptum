import 'package:flutter/services.dart';

Future<void> copyToClipboard({
  required String content,
  Function(String content)? onCopied,
}) async {
  await Clipboard.setData(ClipboardData(text: content));
  if (onCopied != null) {
    onCopied(content);
  }
}
