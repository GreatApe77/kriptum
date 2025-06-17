import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/current_account/current_account_cubit.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/ui/pages/home/widgets/account_viewer_btn.dart';
import 'package:kriptum/ui/pages/home/widgets/accounts_modal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrentAccountCubit>(
          create: (context) =>
              CurrentAccountCubit(injector.get())..requestCurrentAccount(),
        )
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: BlocBuilder<CurrentAccountCubit, CurrentAccountState>(
          builder: (context, state) {
            if (state.account == null) {
              return const CircularProgressIndicator();
            }
            return AccountViewerBtn(
              account: state.account!,
              onPressed: () {
                _showAccountsModal(context);
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _showAccountsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return const AccountsModal();
      },
    );
  }
}
