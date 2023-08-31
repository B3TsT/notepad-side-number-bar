import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad/src/features/editor/modules/cubit/dark_mode_cubit.dart';

import 'features/shared/widgets/fluent/fluent_desktop_widget.dart';
import 'common/variable.dart' as va;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DarkModeCubit(),
      child: BlocBuilder<DarkModeCubit, DarkModeState>(
        builder: (context, state) {
          return FluentApp(
            title: va.titleFuentApp,
            debugShowCheckedModeBanner: false,
            theme: FluentThemeData(
              brightness: state.isDarkMode ? Brightness.dark : Brightness.light,
              accentColor: Colors.green,
            ),
            home: const FluentBodyDesktop(),
          );
        },
      ),
    );
  }
}
