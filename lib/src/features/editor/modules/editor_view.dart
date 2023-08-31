import 'package:fluent_ui/fluent_ui.dart';

import 'widgets/editor_view_header_widget.dart';

part '../mixin/editor_view_mixin.dart';

class EditorView extends StatefulWidget {
  const EditorView({super.key});

  @override
  State<EditorView> createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> with _EditorViewStateMixin {
  @override
  void dispose() {
    scrollController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    updateText(textController.text);
    return ScaffoldPage.scrollable(
      padding: const EdgeInsets.only(top: 0.0),
      header: const EditorViewHeaderWidget(),
      children: [
        editorViewBodyExtension(size),
      ],
    );
  }
}
