import 'package:fluent_ui/fluent_ui.dart';

import 'features/shared/widgets/fluent/fluent_desktop_widget.dart';
import 'common/variable.dart' as va;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: va.titleFuentApp,
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.green,
      ),
      home: const FluentBodyDesktop(),
    );
  }
}
