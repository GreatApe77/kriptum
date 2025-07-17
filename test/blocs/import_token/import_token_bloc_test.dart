import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/import_token/import_token_bloc.dart';
import 'package:kriptum/domain/exceptions/domain_exception.dart';
import 'package:kriptum/domain/usecases/import_erc20_token_usecase.dart';
import 'package:kriptum/domain/usecases/search_erc20_token_metadata_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchErc20TokenMetadataUsecase extends Mock implements SearchErc20TokenMetadataUsecase {}

class MockImportErc20TokenUsecase extends Mock implements ImportErc20TokenUsecase {}

class FakeSearchErc20TokenMetadataInput extends Fake implements SearchErc20TokenMetadataInput {}

class FakeImportErc20TokenInput extends Fake implements ImportErc20TokenInput {}

void main() {
  late ImportTokenBloc sut;
  late MockSearchErc20TokenMetadataUsecase mockSearchErc20TokenMetadataUsecase;
  late MockImportErc20TokenUsecase mockImportErc20TokenUsecase;

  const contractAddress = '0x12345';
  final searchResult = SearchErc20TokenMetadataOutput(name: 'Test Token', decimals: 18, symbol: 'TST');

  setUpAll(() {
    registerFallbackValue(FakeSearchErc20TokenMetadataInput());
    registerFallbackValue(FakeImportErc20TokenInput());
  });

  setUp(() {
    mockSearchErc20TokenMetadataUsecase = MockSearchErc20TokenMetadataUsecase();
    mockImportErc20TokenUsecase = MockImportErc20TokenUsecase();
    sut = ImportTokenBloc(mockSearchErc20TokenMetadataUsecase, mockImportErc20TokenUsecase);
  });

  tearDown(() {
    sut.close();
  });

  group('ImportTokenBloc', () {
    test('initial state is correct', () {
      expect(sut.state, isA<ImportTokenState>());
      expect(sut.state.fetchTokenInfoStatus, FetchTokenInfoStatus.initial);
      expect(sut.state.importTokenStatus, ImportTokenStatus.initial);
    });

    group('ValidEthereumAddressInputed', () {
      blocTest<ImportTokenBloc, ImportTokenState>(
        'emits [loading, success] for fetch status on successful metadata search',
        build: () {
          when(() => mockSearchErc20TokenMetadataUsecase.execute(any())).thenAnswer((_) async => searchResult);
          return sut;
        },
        act: (bloc) => bloc.add(ValidEthereumAddressInputed(contractAddress)),
        expect: () => [
          isA<ImportTokenState>()
              .having((s) => s.fetchTokenInfoStatus, 'fetchStatus', FetchTokenInfoStatus.loading)
              .having((s) => s.tokenAddress, 'tokenAddress', contractAddress),
          isA<ImportTokenState>()
              .having((s) => s.fetchTokenInfoStatus, 'fetchStatus', FetchTokenInfoStatus.success)
              .having((s) => s.tokenName, 'tokenName', searchResult.name)
              .having((s) => s.tokenSymbol, 'tokenSymbol', searchResult.symbol)
              .having((s) => s.tokenDecimals, 'tokenDecimals', searchResult.decimals),
        ],
      );

      blocTest<ImportTokenBloc, ImportTokenState>(
        'emits [loading, failure] for fetch status when metadata search fails',
        build: () {
          when(() => mockSearchErc20TokenMetadataUsecase.execute(any())).thenThrow(Exception('RPC Error'));
          return sut;
        },
        act: (bloc) => bloc.add(ValidEthereumAddressInputed(contractAddress)),
        expect: () => [
          isA<ImportTokenState>().having((s) => s.fetchTokenInfoStatus, 'fetchStatus', FetchTokenInfoStatus.loading),
          isA<ImportTokenState>()
              .having((s) => s.fetchTokenInfoStatus, 'fetchStatus', FetchTokenInfoStatus.failure)
              .having((s) => s.errorMessage, 'errorMessage', 'Could not load token metadata'),
        ],
      );
    });

    group('ImportTokenSubmitted', () {
      blocTest<ImportTokenBloc, ImportTokenState>(
        'emits [loading, success] for import status on successful import',
        build: () {
          when(() => mockImportErc20TokenUsecase.execute(any())).thenAnswer((_) async {});
          return sut;
        },
        seed: () => ImportTokenState.initial().copyWith(
          tokenAddress: contractAddress,
          tokenName: searchResult.name,
          tokenSymbol: searchResult.symbol,
          tokenDecimals: searchResult.decimals,
        ),
        act: (bloc) => bloc.add(ImportTokenSubmitted()),
        expect: () => [
          isA<ImportTokenState>().having((s) => s.importTokenStatus, 'importStatus', ImportTokenStatus.loading),
          isA<ImportTokenState>().having((s) => s.importTokenStatus, 'importStatus', ImportTokenStatus.success),
        ],
        verify: (_) {
          verify(() => mockImportErc20TokenUsecase.execute(any(that: isA<ImportErc20TokenInput>()))).called(1);
        },
      );

      blocTest<ImportTokenBloc, ImportTokenState>(
        'emits [loading, failure] for import status on DomainException',
        build: () {
          when(() => mockImportErc20TokenUsecase.execute(any())).thenThrow(DomainException('Token already exists'));
          return sut;
        },
        seed: () => ImportTokenState.initial().copyWith(
          tokenAddress: contractAddress,
          tokenName: searchResult.name,
          tokenSymbol: searchResult.symbol,
          tokenDecimals: searchResult.decimals,
        ),
        act: (bloc) => bloc.add(ImportTokenSubmitted()),
        expect: () => [
          isA<ImportTokenState>().having((s) => s.importTokenStatus, 'importStatus', ImportTokenStatus.loading),
          isA<ImportTokenState>()
              .having((s) => s.importTokenStatus, 'importStatus', ImportTokenStatus.failure)
              .having((s) => s.errorMessage, 'errorMessage', 'Token already exists'),
        ],
      );

      blocTest<ImportTokenBloc, ImportTokenState>(
        'emits [loading, failure] for import status on generic Exception',
        build: () {
          when(() => mockImportErc20TokenUsecase.execute(any())).thenThrow(Exception('DB Error'));
          return sut;
        },
        seed: () => ImportTokenState.initial().copyWith(
          tokenAddress: contractAddress,
          tokenName: searchResult.name,
          tokenSymbol: searchResult.symbol,
          tokenDecimals: searchResult.decimals,
        ),
        act: (bloc) => bloc.add(ImportTokenSubmitted()),
        expect: () => [
          isA<ImportTokenState>().having((s) => s.importTokenStatus, 'importStatus', ImportTokenStatus.loading),
          isA<ImportTokenState>()
              .having((s) => s.importTokenStatus, 'importStatus', ImportTokenStatus.failure)
              .having((s) => s.errorMessage, 'errorMessage', 'Could not import token'),
        ],
      );
    });
  });
}
