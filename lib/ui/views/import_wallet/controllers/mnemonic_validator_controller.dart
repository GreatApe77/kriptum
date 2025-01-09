abstract class MnemonicValidatorController {
  static String _message = 'A valid 12 word Secret Recovery Pharse must be provided';
  static String? validateMnemonic(String? mnemonic){
    if(mnemonic==null) return _message;
    if(mnemonic.isEmpty) return _message;
    final List<String> mnemonicAsList = mnemonic.trim().split(' ');
    if(mnemonicAsList.length !=12) return _message;
    return null;
  }
}