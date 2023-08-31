import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeState> {
  DarkModeCubit() : super(const DarkModeSelected(true));

  void toggleDarkMode() => emit(DarkModeSelected(!state.isDarkMode));
}
