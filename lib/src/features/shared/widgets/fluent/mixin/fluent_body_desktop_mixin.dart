part of '../fluent_desktop_widget.dart';

mixin _FluentBodyDesktopStateMixin on State<FluentBodyDesktop> {
  int selectedIndex = 0;

  Map<Type, Action<Intent>> get _getActions {
    return <Type, Action<Intent>>{
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
    };
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
                content: Text(va.labelDarkMode),
                checked: FluentTheme.of(context).brightness.isDark,
                onChanged: (v) {
                  if (v) {
                    if (kDebugMode) {
                      print('dark');
                    }
                    // appTheme.mode = ThemeMode.dark;
                  } else {
                    if (kDebugMode) {
                      print('light');
                    }
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

  NavigationPane _getNavigationPane() {
    return NavigationPane(
      header: const HeaderNavigationPane(),
      size: const NavigationPaneSize(openMaxWidth: 240),
      selected: selectedIndex,
      onChanged: (value) => setState(() {
        selectedIndex = NavigationPaneOnchangedPeople.updateSelectedIndex(
          selectedIndex: selectedIndex,
          value: value,
        );
      }),
      items: [
        PaneItem(
          icon: const Icon(FluentIcons.to_do_logo_outline),
          title: Text(va.todoPaneItem),
          body: const EditorView(),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.settings),
          title: Text(va.settingsPaneItem),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(va.settingsPaneItem),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
