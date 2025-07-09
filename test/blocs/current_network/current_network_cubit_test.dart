import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/current_network/current_network_cubit.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworksRepository extends Mock implements NetworksRepository {}

class FakeNetwork extends Fake implements Network {}

void main() {
  late CurrentNetworkCubit sut;
  late MockNetworksRepository mockNetworksRepository;
  late StreamController<Network> networkStreamController;

  final testNetwork = Network(id: 1, name: 'Testnet', rpcUrl: '', ticker: 'TEST', currencyDecimals: 18);

  setUpAll(() {
    registerFallbackValue(FakeNetwork());
  });

  setUp(() {
    mockNetworksRepository = MockNetworksRepository();
    networkStreamController = StreamController<Network>.broadcast();
    when(() => mockNetworksRepository.watchCurrentNetwork()).thenAnswer((_) => networkStreamController.stream);
    sut = CurrentNetworkCubit(mockNetworksRepository);
  });

  tearDown(() {
    networkStreamController.close();
    sut.close();
  });

  group('CurrentNetworkCubit', () {
    test('initial state is CurrentNetworkInitial', () {
      expect(sut.state, isA<CurrentNetworkInitial>());
    });

    group('requestCurrentNetwork', () {
      blocTest<CurrentNetworkCubit, CurrentNetworkState>(
        'emits [CurrentNetworkLoading, CurrentNetworkLoaded] on success',
        build: () {
          when(() => mockNetworksRepository.getCurrentNetwork()).thenAnswer((_) async => testNetwork);
          return sut;
        },
        act: (cubit) => cubit.requestCurrentNetwork(),
        expect: () => [
          isA<CurrentNetworkLoading>(),
          isA<CurrentNetworkLoaded>()
              .having((s) => s.network, 'network', testNetwork)
              .having((s) => s.isChangingNetwork, 'isChangingNetwork', false),
        ],
        verify: (_) {
          verify(() => mockNetworksRepository.getCurrentNetwork()).called(1);
        },
      );

      blocTest<CurrentNetworkCubit, CurrentNetworkState>(
        'emits [CurrentNetworkLoading, CurrentNetworkError] on failure',
        build: () {
          when(() => mockNetworksRepository.getCurrentNetwork()).thenThrow(Exception('Failed to load'));
          return sut;
        },
        act: (cubit) => cubit.requestCurrentNetwork(),
        expect: () => [
          isA<CurrentNetworkLoading>(),
          isA<CurrentNetworkError>().having((e) => e.message, 'message', 'Failed to load current network'),
        ],
        verify: (_) {
          verify(() => mockNetworksRepository.getCurrentNetwork()).called(1);
        },
      );
    });

    group('changeCurrentNetwork', () {
      blocTest<CurrentNetworkCubit, CurrentNetworkState>(
        'calls repository and does not emit state directly on success',
        build: () {
          when(() => mockNetworksRepository.changeCurrentNetwork(any())).thenAnswer((_) async {});
          return sut;
        },
        act: (cubit) => cubit.changeCurrentNetwork(testNetwork),
        expect: () => [],
        verify: (_) {
          verify(() => mockNetworksRepository.changeCurrentNetwork(testNetwork)).called(1);
        },
      );

      blocTest<CurrentNetworkCubit, CurrentNetworkState>(
        'emits [CurrentNetworkError] on failure',
        build: () {
          when(() => mockNetworksRepository.changeCurrentNetwork(any())).thenThrow(Exception('Failed to change'));
          return sut;
        },
        act: (cubit) => cubit.changeCurrentNetwork(testNetwork),
        expect: () => [
          isA<CurrentNetworkError>().having((e) => e.message, 'message', 'Failed to change network'),
        ],
        verify: (_) {
          verify(() => mockNetworksRepository.changeCurrentNetwork(testNetwork)).called(1);
        },
      );
    });

    group('Stream Subscription', () {
      blocTest<CurrentNetworkCubit, CurrentNetworkState>(
        'emits [CurrentNetworkLoaded] with isChangingNetwork true when stream emits a new network',
        build: () => sut,
        act: (cubit) => networkStreamController.add(testNetwork),
        expect: () => [
          isA<CurrentNetworkLoaded>()
              .having((s) => s.network, 'network', testNetwork)
              .having((s) => s.isChangingNetwork, 'isChangingNetwork', true),
        ],
      );
    });
  });
}
