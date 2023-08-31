import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:window_manager/window_manager.dart';

import '../../../editor/modules/editor_view.dart';
import 'window_buttons_widget.dart';
import 'people/navigation_pane_on_changed_people.dart';
import 'header_navigation_pane_widget.dart';
import '../../../../core/utils/intent_class.dart';
import '../../../../common/variable.dart' as va;

part 'mixin/fluent_body_desktop_mixin.dart';

class FluentBodyDesktop extends StatefulWidget {
  const FluentBodyDesktop({super.key});

  @override
  State<FluentBodyDesktop> createState() => _FluentBodyDesktopState();
}

class _FluentBodyDesktopState extends State<FluentBodyDesktop>
    with _FluentBodyDesktopStateMixin {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: va.shortcut,
      child: Actions(
        actions: _getActions,
        child: Focus(
          autofocus: true,
          child: NavigationView(
            appBar: _getAppBar(),
            pane: _getNavigationPane(),
            paneBodyBuilder: (item, body) {
              return body!;
            },
          ),
        ),
      ),
    );
  }
}
