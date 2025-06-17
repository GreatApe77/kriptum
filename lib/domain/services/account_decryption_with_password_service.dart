abstract interface class AccountDecryptionWithPasswordService {
  Future<bool> isPasswordCorrect(
    AccountDecryptionWithPasswordParams params,
  );
}

class AccountDecryptionWithPasswordParams {
  final String password;
  final String encryptedAccount;

  AccountDecryptionWithPasswordParams({
    required this.password,
    required this.encryptedAccount,
  });
}
