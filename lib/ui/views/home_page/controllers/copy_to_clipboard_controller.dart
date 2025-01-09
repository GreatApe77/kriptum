import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CopyToClipboardController extends ChangeNotifier {
  Future<void> copyToClipboard(
      {required String content,
      required Function(String content) onCopied}) async {
    await Clipboard.setData(ClipboardData(text: content));
    onCopied(content);
  }
}
