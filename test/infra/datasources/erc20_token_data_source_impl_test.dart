import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/domain/models/erc20_token.dart';
import 'package:kriptum/infra/datasources/erc20_tokens_data_source_impl.dart';
import 'package:kriptum/infra/persistence/database/sqflite/tables/erc20_tokens_table.dart';
import 'package:kriptum/infra/persistence/database/sql_database.dart';
import 'package:mocktail/mocktail.dart';

class MockSqlDatabase extends Mock implements SqlDatabase {}

void main() {
  late Erc20TokenDataSourceImpl sut;
  late MockSqlDatabase mockDatabase;

  final testToken = Erc20Token(
    id: 1,
    address: '0x12345',
    name: 'Test Token',
    symbol: 'TST',
    decimals: 18,
    networkId: 1,
  );

  setUp(() {
    mockDatabase = MockSqlDatabase();
    sut = Erc20TokenDataSourceImpl(mockDatabase);
  });

  group('Erc20TokenDataSourceImpl', () {
    test('save should call insert on the database with correct values', () async {
      when(() => mockDatabase.insert(any(), any())).thenAnswer((_) async => 1);

      await sut.save(testToken);

      verify(() => mockDatabase.insert(Erc20TokensTable.table, testToken.toMap())).called(1);
    });

    test('delete should call delete on the database with correct values', () async {
      when(() => mockDatabase.delete(any(), any(), any())).thenAnswer((_) async => 1);

      await sut.delete(1);

      verify(() => mockDatabase.delete(
            Erc20TokensTable.table,
            '${Erc20TokensTable.columnId} = ?',
            [1],
          )).called(1);
    });

    test('deleteAll should call deleteAll on the database', () async {
      when(() => mockDatabase.deleteAll(any())).thenAnswer((_) async {});

      await sut.deleteAll();

      verify(() => mockDatabase.deleteAll(Erc20TokensTable.table)).called(1);
    });

    group('findByAddress', () {
      test('should return a token when found', () async {
        when(() => mockDatabase.query(
              any(),
              where: any(named: 'where'),
              whereArgs: any(named: 'whereArgs'),
            )).thenAnswer((_) async => [testToken.toMap()]);

        final result = await sut.findByAddress('0x12345');

        expect(result, isA<Erc20Token>());
        expect(result?.address, '0x12345');
      });

      test('should return null when token is not found', () async {
        when(() => mockDatabase.query(
              any(),
              where: any(named: 'where'),
              whereArgs: any(named: 'whereArgs'),
            )).thenAnswer((_) async => []);

        final result = await sut.findByAddress('0x12345');

        expect(result, isNull);
      });
    });

    group('findById', () {
      test('should return a token when found', () async {
        when(() => mockDatabase.query(
              any(),
              where: any(named: 'where'),
              whereArgs: any(named: 'whereArgs'),
            )).thenAnswer((_) async => [testToken.toMap()]);

        final result = await sut.findById(1);

        expect(result, isA<Erc20Token>());
        expect(result?.id, 1);
      });

      test('should return null when token is not found', () async {
        when(() => mockDatabase.query(
              any(),
              where: any(named: 'where'),
              whereArgs: any(named: 'whereArgs'),
            )).thenAnswer((_) async => []);

        final result = await sut.findById(1);

        expect(result, isNull);
      });
    });

    group('getAllImportedTokensOfNetwork', () {
      test('should return a list of tokens for a given networkId', () async {
        when(() => mockDatabase.query(
              any(),
              where: any(named: 'where'),
              whereArgs: any(named: 'whereArgs'),
            )).thenAnswer((_) async => [testToken.toMap()]);

        final result = await sut.getAllImportedTokensOfNetwork(1);

        expect(result, isA<List<Erc20Token>>());
        expect(result.length, 1);
        expect(result.first.networkId, 1);
      });

      test('should return an empty list when no tokens are found for the networkId', () async {
        when(() => mockDatabase.query(
              any(),
              where: any(named: 'where'),
              whereArgs: any(named: 'whereArgs'),
            )).thenAnswer((_) async => []);

        final result = await sut.getAllImportedTokensOfNetwork(1);

        expect(result, isEmpty);
      });
    });

    group('getAllTokens', () {
      test('should return a list of all tokens', () async {
        final tokensMap = [testToken.toMap(), testToken.copyWith(id: 2, address: '0x67890').toMap()];
        when(() => mockDatabase.query(any())).thenAnswer((_) async => tokensMap);

        final result = await sut.getAllTokens();

        expect(result.length, 2);
        expect(result.first.id, 1);
        expect(result.last.id, 2);
      });
    });
  });
}
