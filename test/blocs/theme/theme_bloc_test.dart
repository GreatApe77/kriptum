import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kriptum/blocs/theme/theme_bloc.dart';
import 'package:kriptum/infra/persistence/user_preferences/user_preferences.dart';
import 'package:mocktail/mocktail.dart';

class MockUserPreferences extends Mock implements UserPreferences {}

void main() {
  late MockUserPreferences mockUserPreferences;

  setUp(() {
    mockUserPreferences = MockUserPreferences();
    when(() => mockUserPreferences.setDarkModeEnabled(any())).thenAnswer((_) async {});
  });

  group('ThemeBloc', () {
    test('initial state is ThemeLight when no initial state is provided', () {
      expect(ThemeBloc(mockUserPreferences).state, isA<ThemeLight>());
    });

    test('initial state is the one provided in the constructor', () {
      expect(ThemeBloc(mockUserPreferences, ThemeDark()).state, isA<ThemeDark>());
    });

    blocTest<ThemeBloc, ThemeState>(
      'emits [ThemeDark] when ThemeToggled is added and current state is ThemeLight',
      build: () => ThemeBloc(mockUserPreferences, ThemeLight()),
      act: (bloc) => bloc.add(ThemeToggled()),
      expect: () => [isA<ThemeDark>()],
      verify: (_) {
        verify(() => mockUserPreferences.setDarkModeEnabled(true)).called(1);
      },
    );

    blocTest<ThemeBloc, ThemeState>(
      'emits [ThemeLight] when ThemeToggled is added and current state is ThemeDark',
      build: () => ThemeBloc(mockUserPreferences, ThemeDark()),
      act: (bloc) => bloc.add(ThemeToggled()),
      expect: () => [isA<ThemeLight>()],
      verify: (_) {
        verify(() => mockUserPreferences.setDarkModeEnabled(false)).called(1);
      },
    );
  });
}
