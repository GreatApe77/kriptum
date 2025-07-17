import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/networks_list/networks_list_bloc.dart';
import 'package:kriptum/domain/models/network.dart';
import 'package:kriptum/domain/repositories/networks_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworksRepository extends Mock implements NetworksRepository {}

void main() {
  late NetworksListBloc sut;
  late MockNetworksRepository mockNetworksRepository;

  final mockNetworks = [
    Network(id: 1, name: 'Ethereum', rpcUrl: '', ticker: 'ETH', currencyDecimals: 18),
    Network(id: 2, name: 'Sepolia', rpcUrl: '', ticker: 'ETH', currencyDecimals: 18),
    Network(id: 3, name: 'Fantom', rpcUrl: '', ticker: 'FTM', currencyDecimals: 18),
  ];

  setUp(() {
    mockNetworksRepository = MockNetworksRepository();
    sut = NetworksListBloc(mockNetworksRepository);
  });

  tearDown(() {
    sut.close();
  });

  group('NetworksListBloc', () {
    test('initial state is correct', () {
      expect(sut.state.status, NetworksListState.initial().status);
    });

    group('NetworksListRequested', () {
      blocTest<NetworksListBloc, NetworksListState>(
        'emits [loading, loaded] when getAllNetworks is successful',
        build: () {
          when(() => mockNetworksRepository.getAllNetworks()).thenAnswer((_) async => mockNetworks);
          return sut;
        },
        act: (bloc) => bloc.add(NetworksListRequested()),
        expect: () => [
          isA<NetworksListState>().having((s) => s.status, 'status', NetworksListStatus.loading),
          isA<NetworksListState>()
              .having((s) => s.status, 'status', NetworksListStatus.loaded)
              .having((s) => s.networks, 'networks', mockNetworks)
              .having((s) => s.filteredNetworks, 'filteredNetworks', mockNetworks),
        ],
        verify: (_) {
          verify(() => mockNetworksRepository.getAllNetworks()).called(1);
        },
      );

      blocTest<NetworksListBloc, NetworksListState>(
        'emits [loading, error] when getAllNetworks fails',
        build: () {
          when(() => mockNetworksRepository.getAllNetworks()).thenThrow(Exception('Failed to load'));
          return sut;
        },
        act: (bloc) => bloc.add(NetworksListRequested()),
        expect: () => [
          isA<NetworksListState>().having((s) => s.status, 'status', NetworksListStatus.loading),
          isA<NetworksListState>()
              .having((s) => s.status, 'status', NetworksListStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', 'Failed to load networks'),
        ],
        verify: (_) {
          verify(() => mockNetworksRepository.getAllNetworks()).called(1);
        },
      );
    });

    group('NetworksListFiltered', () {
      blocTest<NetworksListBloc, NetworksListState>(
        'emits state with correctly filtered networks',
        build: () => sut,
        seed: () => NetworksListState.initial().copyWith(networks: mockNetworks, filteredNetworks: mockNetworks),
        act: (bloc) => bloc.add(NetworksListFiltered(filter: 'eth')),
        expect: () => [
          isA<NetworksListState>()
              .having((s) => s.filteredNetworks.length, 'filteredNetworks.length', 1)
              .having((s) => s.filteredNetworks.first.name, 'filteredNetworks.first.name', 'Ethereum'),
        ],
      );

      blocTest<NetworksListBloc, NetworksListState>(
        'emits state with empty list for non-matching filter',
        build: () => sut,
        seed: () => NetworksListState.initial().copyWith(networks: mockNetworks, filteredNetworks: mockNetworks),
        act: (bloc) => bloc.add(NetworksListFiltered(filter: 'xyz')),
        expect: () => [
          isA<NetworksListState>().having((s) => s.filteredNetworks, 'filteredNetworks', isEmpty),
        ],
      );

      blocTest<NetworksListBloc, NetworksListState>(
        'emits state with all networks for empty filter',
        build: () => sut,
        seed: () => NetworksListState.initial().copyWith(networks: mockNetworks, filteredNetworks: []),
        act: (bloc) => bloc.add(NetworksListFiltered(filter: '')),
        expect: () => [
          isA<NetworksListState>().having((s) => s.filteredNetworks, 'filteredNetworks', mockNetworks),
        ],
      );
    });
  });
}
