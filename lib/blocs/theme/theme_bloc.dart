import 'package:bloc/bloc.dart';
import 'package:kriptum/infra/persistence/user_preferences/user_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final UserPreferences _userPreferences;
  ThemeBloc(this._userPreferences, [ThemeState? initialState])
      : super(initialState ?? ThemeLight()) {
    on<ThemeToggled>((event, emit) async {
      final bool isDarkMode = state is ThemeDark;
      emit(
        isDarkMode ? ThemeLight(): ThemeDark(),
      );
      await _userPreferences.setDarkModeEnabled(!isDarkMode);
    });
  }
}
