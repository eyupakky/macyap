import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvent {}

/// Notifies bloc to increment state.
class Increment extends CounterEvent {}

/// Notifies bloc to decrement state.
class Decrement extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  /// {@macro counter_bloc}
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }
}
class ChangeBottomCubit extends Cubit<bool> {
  ChangeBottomCubit(bool initialState) : super(initialState);
  void changeFlushBar(bool change) {
    emit(change);
  }
}
class ChangeFavorite extends Cubit<bool> {
  ChangeFavorite(bool initialState) : super(initialState);
  void changeFavorite(bool change) {
    emit(change);
  }
}
class GameFavorite extends Cubit<bool> {
  GameFavorite(bool initialState) : super(initialState);
  void changeFavorite(bool change) {
    emit(change);
  }
}
class NewVenuesComment extends Cubit<int> {
  NewVenuesComment(int initialState) : super(initialState);
  void changeVenuesComment(int change) {
    emit(change);
  }
}
class MacListesiCubit extends Cubit<int> {
  MacListesiCubit(int initialState) : super(initialState);
  void changeFlushBar(int widget) {
    emit(widget);
  }
}


class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    brightness: Brightness.light,
  );

  static final _darkTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
    ),
    brightness: Brightness.dark,
  );

  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}