import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriptum/blocs/current_account/current_account_bloc.dart';
import 'package:kriptum/config/di/injector.dart';
import 'package:kriptum/ui/pages/home/widgets/account_viewer_btn.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrentAccountBloc>(
          create: (context) => CurrentAccountBloc(injector.get())
            ..add(CurrentAccountRequested()),
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
        title: BlocBuilder<CurrentAccountBloc, CurrentAccountState>(
          builder: (context, state) {
            if (state.account == null) {
              return const CircularProgressIndicator();
            }
            return AccountViewerBtn(
              account: state.account!,
              onPressed: () {},
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
}
