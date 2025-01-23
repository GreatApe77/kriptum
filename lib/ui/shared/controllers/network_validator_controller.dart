abstract class NetworkValidatorController {
  static String? validateName(String name) {
    if (name.isEmpty) return 'Network name is required';
    return null;
  }

  static String? validateRpcUrl(String rpcUrl) {
    if (rpcUrl.isEmpty) return 'RPC Url is required';
    if (!rpcUrl.startsWith('http') && !rpcUrl.startsWith('ws')) {
      return 'RPC Url must be a valid URL';
    }
    return null;
  }

  static String? validateChainId(String chainId) {
    if (chainId.isEmpty) return 'Chain ID is required';
    if (int.tryParse(chainId) == null) return 'Chain ID must be a valid number';
    return null;
  }

  static String? validateTicker(String ticker) {
    if (ticker.isEmpty) return 'Ticker is required';
    if (ticker.length > 6) return 'Ticker too large. Max length: 6';
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(ticker)) {
      return 'Ticker must contain only letters';
    }
    return null;
  }

  static String? validateBlockExplorerName(
      String blockExplorerName, bool nameOrUrlExists) {
    if (nameOrUrlExists) {
      if (blockExplorerName.isEmpty) {
        return 'Block explorer Name and RPC URL are tied';
      }
      if (!RegExp(r'^[a-zA-Z]+$').hasMatch(blockExplorerName)) {
        return 'Block Explorer Name must contain only letters';
      }
      return null;
    }
    return null;
  }

  static String? validateBlockExplorerUrl(
      String blockExplorerUrl, bool nameOrUrlExists) {
    if (nameOrUrlExists) {
      if (blockExplorerUrl.isEmpty) {
        return 'Block explorer Name and RPC URL are tied';
      }
      if (!blockExplorerUrl.startsWith('http')) {
        return 'Must be a valid URL';
      }
      return null;
    }
    return null;
  }

  static String? validateDecimals(String decimals) {
    if (decimals.isEmpty) return 'Decimals are required';
    if (int.tryParse(decimals) == null) return 'Decimals must be a valid number';
    return null;
  }
}
