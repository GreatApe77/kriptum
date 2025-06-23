import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/models/contact.dart';
import 'package:kriptum/domain/repositories/accounts_repository.dart';
import 'package:kriptum/domain/repositories/contacts_repository.dart';

class AddContactUsecase {
  final ContactsRepository _contactsRepository;
  final AccountsRepository _accountsRepository;
  AddContactUsecase(this._contactsRepository, this._accountsRepository);

  Future<void> execute(AddContactUsecaseParams params) async {
    final currentConnectedAccount =
        await _accountsRepository.getCurrentAccount();
    if (currentConnectedAccount == null) {
      throw DomainException('Invalid current account state');
    }
    if (currentConnectedAccount.address == params.contact.address) {
      throw DomainException('Cannot add yourself');
    }
    await _contactsRepository.saveContact(params.contact);
  }
}

class AddContactUsecaseParams {
  final Contact contact;

  AddContactUsecaseParams({required this.contact});
}
