part of 'dark_mode_cubit.dart';

sealed class DarkModeState extends Equatable {
  const DarkModeState(this.isDarkMode);
  final bool isDarkMode;
}

final class DarkModeSelected extends DarkModeState {
  const DarkModeSelected(bool isDarkMode) : super(isDarkMode);

  @override
  List<Object?> get props => [isDarkMode];
}
