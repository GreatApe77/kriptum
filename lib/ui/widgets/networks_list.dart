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
          create: (context) => CurrentNetworkCubit(injector.get()),
        ),
        BlocProvider<NetworksListBloc>(
          create: (context) => NetworksListBloc()..add(NetworksListRequested()),
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
  void dispose() {
    _filterTextEditingController.dispose();
    super.dispose();
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
                border: OutlineInputBorder()),
            onChanged: (value) {},
          ),
          Expanded(child: BlocBuilder<NetworksListBloc, NetworksListState>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.networks.length,
                itemBuilder: (context, index) {
                  final network = state.networks[index];
                  return NetworkListTile(
                    //selected: currNetwork.network.id == network.id,
                    network: network,
                    onNetworkTap: (network) {},
                  );
                },
              );
            },
          )),
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
    );
  }
}
