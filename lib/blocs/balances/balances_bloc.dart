import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'balances_event.dart';
part 'balances_state.dart';

class BalancesBloc extends Bloc<BalancesEvent, BalancesState> {
  BalancesBloc() : super(BalancesInitial()) {
    on<BalancesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
