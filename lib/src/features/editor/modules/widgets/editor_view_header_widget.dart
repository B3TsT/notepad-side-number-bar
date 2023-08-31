import 'package:fluent_ui/fluent_ui.dart';

class EditorViewHeaderWidget extends StatelessWidget {
  const EditorViewHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          FilledButton(
            child: const Text('Filled Button'),
            // TODO: create notes
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
