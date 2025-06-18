import 'package:bloc/bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeLight()) {
    on<ThemeToggled>((event, emit) {
      emit(
        state is ThemeLight ? ThemeDark() : ThemeLight(),
      );
    });
  }
}
