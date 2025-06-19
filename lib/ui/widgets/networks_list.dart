import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/current_network/current_network_cubit.dart';
import 'package:kriptum/blocs/networks_list/networks_list_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/ui/widgets/network_list_tile.dart';

class NetworksList extends StatelessWidget {
  const NetworksList({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrentNetworkCubit>(
          create: (context) =>
              CurrentNetworkCubit(injector.get())..requestCurrentNetwork(),
        ),
        BlocProvider<NetworksListBloc>(
          create: (context) =>
              NetworksListBloc(injector.get())..add(NetworksListRequested()),
        ),
      ],
      child: _NetworksList(),
    );
  }
}

class _NetworksList extends StatefulWidget {
  const _NetworksList();

  @override
  State<_NetworksList> createState() => _NetworksListState();
}

class _NetworksListState extends State<_NetworksList> {
  final TextEditingController _filterTextEditingController =
      TextEditingController();
  @override
  void initState() {
    _filterTextEditingController.addListener(_filterTextListener);
    super.initState();
  }

  @override
  void dispose() {
    _filterTextEditingController.dispose();
    super.dispose();
  }

  void _filterTextListener() {
    context.read<NetworksListBloc>().add(
          NetworksListFiltered(
            filter: _filterTextEditingController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _filterTextEditingController,
            decoration: const InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          Expanded(child: BlocBuilder<NetworksListBloc, NetworksListState>(
            builder: (context, state) {
              if (state.status == NetworksListStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == NetworksListStatus.error) {
                return Center(
                  child: Text(state.errorMessage ?? 'Unknown error'),
                );
              }
              final networks = state.filteredNetworks;
              return BlocConsumer<CurrentNetworkCubit, CurrentNetworkState>(
                listener: (context, state) {
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          'Network changed to ${(state as CurrentNetworkLoaded).network.name}.',
                        ),
                      ),
                    );
                },
                listenWhen: (previous, current) {
                  if (current is CurrentNetworkLoaded) {
                    return current.isChangingNetwork;
                  }
                  return false;
                },
                builder: (context, currNetworksState) {
                  bool loaded = currNetworksState is CurrentNetworkLoaded;
                  if (!loaded) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final currentNetwork = currNetworksState.network;
                  return ListView.builder(
                    itemCount: networks.length,
                    itemBuilder: (context, index) {
                      final network = networks[index];
                      return NetworkListTile(
                        selected: currentNetwork.id == network.id,
                        network: network,
                        onNetworkTap: (network) {
                          context
                              .read<CurrentNetworkCubit>()
                              .changeCurrentNetwork(network);
                        },
                      );
                    },
                  );
                },
              );
            },
          ))
        ],
      ),
    );
/*     return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _filterTextEditingController,
            decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder()),
          ),
          Expanded(
            child: BlocBuilder<CurrentNetworkCubit, CurrentNetworkState>(
              buildWhen: (previous, current) =>
                  previous.runtimeType != current.runtimeType 
                  ,
              builder: (context, currNetworkState) {
                if (currNetworkState is CurrentNetworkLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (currNetworkState is CurrentNetworkError) {
                  return Center(
                    child: Text(currNetworkState.message),
                  );
                }
                if (currNetworkState is CurrentNetworkLoaded) {
                  final currentNetwork = currNetworkState.network;
                  return BlocBuilder<NetworksListBloc, NetworksListState>(
                    builder: (context, networksListState) {
                      final networks = networksListState.networks;
                      return ListView.builder(
                        itemCount: networks.length,
                        itemBuilder: (context, index) {
                          final network = networks[index];
                          return NetworkListTile(
                            selected: currentNetwork.id == network.id,
                            network: network,
                            onNetworkTap: (network) {
                              context
                                  .read<CurrentNetworkCubit>()
                                  .changeCurrentNetwork(network);
                            },
                          );
                        },
                      );
                    },
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
/*               child: ListenableBuilder(
                  listenable: networksController,
                  builder: (context, child) {
                    if (filterController.text.isNotEmpty) {
                      return ListView.builder(
                        itemCount: networksController.filteredList.length,
                        itemBuilder: (context, index) => NetworkListTile(
                            onNetworkTap: () => _onNetworkTap(index, context),
                            network: networksController.filteredList[index]),
                      );
                    }
                    return ListView.builder(
                      itemCount: networksController.networks.length,
                      itemBuilder: (context, index) => NetworkListTile(
                          selected: currentNetworkController
                                  .currentConnectedNetwork?.id ==
                              networksController.networks[index].id,
                          onNetworkTap: () => _onNetworkTap(index, context),
                          network: networksController.networks[index]),
                    );
                  })), */
          FilledButton(onPressed: () {}, child: const Text('Add Network'))
        ],
      ),
    ); */
  }
}
