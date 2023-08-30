// import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

import 'core/class.dart';
import 'features/editor/modules/main_editor.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Fluent UI Demo',
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData(
        brightness: Brightness.dark,
        // primarySwatch: Colors.blue,
        accentColor: Colors.green,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        LogicalKeySet(LogicalKeyboardKey.keyI, LogicalKeyboardKey.controlLeft):
            const NavigationListIntent(),
        LogicalKeySet(LogicalKeyboardKey.keyS, LogicalKeyboardKey.controlLeft):
            const NavigationSettingsIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          NavigationListIntent: CallbackAction<NavigationListIntent>(
            onInvoke: (NavigationListIntent intent) => setState(() {
              selectedIndex = 0;
            }),
          ),
          NavigationSettingsIntent: CallbackAction<NavigationSettingsIntent>(
            onInvoke: (NavigationSettingsIntent intent) => setState(() {
              selectedIndex = 1;
            }),
          ),
        },
        child: Focus(
            autofocus: true,
            child: NavigationView(
              appBar: _getAppBar(),
              pane: _getNavigationPane(),
              paneBodyBuilder: (item, body) {
                return body!;
              },
            )),
      ),
    );
  }

  NavigationPane _getNavigationPane() {
    return NavigationPane(
      header: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, right: 7),
        child: Image.network(
            'https://docs.microsoft.com/en-us/windows/uwp/design/controls-and-patterns/images/navview-freeform-header-top.png'),
      ),
      size: const NavigationPaneSize(openMaxWidth: 240),
      selected: selectedIndex,
      onChanged: (value) {
        setState(() {
          selectedIndex = value;
          LogicalKeySet(LogicalKeyboardKey.keyU);
          const SingleActivator(LogicalKeyboardKey.keyX, control: true);
        });
      },
      items: [
        PaneItem(
          icon: const Icon(FluentIcons.to_do_logo_outline),
          title: const Text('List Todo'),
          body: const ColumnApp(),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.settings),
          title: const Text('Settings'),
          body: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Settings'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  NavigationAppBar _getAppBar() {
    return NavigationAppBar(
      height: 30,
      automaticallyImplyLeading: false,
      title: () {
        if (kIsWeb) {
          return const Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(appTitle),
          );
        }
        return const DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(appTitle),
          ),
        );
      }(),
      actions: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 8.0),
              child: ToggleSwitch(
                content: const Text('Dark Mode'),
                checked: FluentTheme.of(context).brightness.isDark,
                onChanged: (v) {
                  if (v) {
                    print('dark');
                    // appTheme.mode = ThemeMode.dark;
                  } else {
                    print('light');
                    // appTheme.mode = ThemeMode.light;
                  }
                },
              ),
            ),
          ),
          if (!kIsWeb) const WindowButtons(),
        ],
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);
    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
