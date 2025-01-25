import 'package:kriptum/data/repositories/contact/contacts_repository.dart';
import 'package:kriptum/domain/models/contact.dart';

class ContactsRepositoryMemoryImpl implements ContactsRepository {
  int _nextId= 2;
  final _repo = [
    Contact(
        id: 0,
        name: 'Jonas',
        address: '0x6131e83CF571962813836B67DB07F2a1ebEaa357'),
    Contact(
        id: 1,
        name: 'Marcos',
        address: '0x3Caa0e5A638d3d4Ef266eb1cDE3C816A646CF314'),
  ];

  @override
  Future<void> deleteContact(int id) async {
    _repo.removeWhere(
      (element) => element.id == id,
    );
  }

  @override
  Future<Contact> getContact(int id) async {
    await Future.delayed(Duration(seconds: 1));

    return Future.value(_repo.firstWhere(
      (element) => element.id == id,
    ));
  }

  @override
  Future<List<Contact>> getContacts() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(List.from(_repo));
  }

  @override
  Future<int> saveContact(Contact contact)async {
    int insertedId = _nextId;
    contact.id = insertedId;
    _repo.add(contact);
    _nextId++;
    return insertedId;

  }

  @override
  Future<void> updateContact(int id, Contact contactData) async {
    int indexOf= _repo.indexWhere((element) => element.id==id,);
    _repo[indexOf] = contactData;
  }
}
